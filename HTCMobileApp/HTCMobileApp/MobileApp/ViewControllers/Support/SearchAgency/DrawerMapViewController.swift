//
//  DrawerMapViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import RxCoreLocation
import Pulley
import FSPagerView
import RxSwift
import RxCocoa

protocol DrawerMapViewControllerDelegate {
    func selectAgencyAtIndex(_ index: Int)
    func drawerPositionChanged(_ position: PulleyPosition)
    func navigate(to destination: CLLocation)
}

class DrawerMapViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    var delegate: DrawerMapViewControllerDelegate?
    @IBOutlet weak var agencyInfoView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fsPagerView: FSPagerView!{
        didSet {
            self.fsPagerView.register(AgencyPagerViewCell.nib, forCellWithReuseIdentifier:AgencyPagerViewCell.identifier)
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            self.fsPagerView.dataSource = self
            self.fsPagerView.delegate = self
        }
    }
    
    let agencyItems: Variable<[AgencyLocationModel]> = Variable([])
    var selectedIndex: Int = -1
    let currentLocation: Variable<CLLocation> = Variable(CLLocation.init(latitude: 21.028511, longitude: 105.804817))
    let contentHeight: CGFloat = 220
    
    override func setupView() {
        super.setupView()
        
        self.tableView.register(AgencyListCell.nib, forCellReuseIdentifier: AgencyListCell.identifier)
        
        self.fsPagerView.interitemSpacing = 6
        self.fsPagerView.itemSize = CGSize(width: UIScreen.main.bounds.size.width - 80 , height: contentHeight)
        self.fsPagerView.clipsToBounds = true
        self.fsPagerView.dataSource = self
        self.fsPagerView.delegate = self
        
        agencyItems.asObservable()
            .bind(to: tableView.rx.items) {[weak self] (tableView, row, item) in
                let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: IndexPath(row: row, section: 0)) as! AgencyListCell
                cell.setDataContext(indexPath: IndexPath(row: row, section: 0), data: item)
                guard let s = self else {return UITableViewCell()}
                s.currentLocation.asDriver()
                    .skip(1)
                    .drive(cell.currentLocation)
                    .disposed(by: s.disposeBag)
                return cell
            }
            .disposed(by: disposeBag)
        
        agencyItems.asObservable()
            .subscribe(onNext: {[weak self] (agencies) in
                if agencies.count > 0 {
                    //  reload pager view
                    self?.fsPagerView.reloadData()
                }
            }).disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (indexPath) in
                //  Tap location index path
                self?.viewAgencyInfoAtIndex(indexPath.row)
            }).disposed(by: disposeBag)
        
        self.backButton.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.backToAgencyList()
            }).disposed(by: disposeBag)
    }
    
    
    func viewAgencyInfoAtIndex(_ index: Int) {
        
        self.selectedIndex = index
        self.delegate?.selectAgencyAtIndex(index)
        
        self.agencyInfoView.isHidden = false
        if index < agencyItems.value.count {
            self.fsPagerView.scrollToItem(at: index, animated: false)
        }
        
        pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
        pulleyViewController?.setNeedsSupportedDrawerPositionsUpdate()
    }
    
    func backToAgencyList() {
        self.agencyInfoView.isHidden = true
        self.tableView.selectRow(at: IndexPath(row: selectedIndex, section: 0), animated: true, scrollPosition: .top)
        pulleyViewController?.setNeedsSupportedDrawerPositionsUpdate()
    }
}

extension DrawerMapViewController: FSPagerViewDataSource, FSPagerViewDelegate{
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return agencyItems.value.count
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "AgencyPagerViewCell", at: index)
        guard let aCell = cell as? AgencyPagerViewCell else {return FSPagerViewCell()}
        if index < agencyItems.value.count {
            aCell.setDataContext(index: index, data: agencyItems.value[index] as Any)
        }
        aCell.delegate = self
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
//    public func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
//        pagerView.deselectItem(at: index, animated: true)
//        pagerView.scrollToItem(at: index, animated: true)
//        selectedIndex = index
//        print("Did select pager \(selectedIndex)")
//    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        print(pagerView.currentIndex)
        selectedIndex = pagerView.currentIndex
        print("Did select pager \(selectedIndex)")
        self.delegate?.selectAgencyAtIndex(selectedIndex)
    }
}

extension DrawerMapViewController: AgencyPagerViewCellDelegate{
    
    func callHotlineCskh(agency: AgencyLocationModel){
        callPhoneNumber(agency.getHotline())
    }
    func callHotlineSale(agency: AgencyLocationModel){
        callPhoneNumber(agency.getHotlineSale())
    }
    func callHotlineService(agency: AgencyLocationModel){
        callPhoneNumber(agency.getHotlineService())
    }
    func openWebsite(agency: AgencyLocationModel){
        if let url = URL(string: agency.getWebsite()) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    func navigateToAgency(agency: AgencyLocationModel){
        delegate?.navigate(to: CLLocation(latitude: agency.getLatitude(), longitude: agency.getLongitude()))
    }
    func openGoogleMaps(agency: AgencyLocationModel){
        self.openMaps(latitude: agency.getLatitude(), longitude: agency.getLongitude(), addressName: agency.getAddress())
    }
}

extension DrawerMapViewController: PulleyDrawerViewControllerDelegate {
    
    func collapsedDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 37.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func partialRevealDrawerHeight(bottomSafeArea: CGFloat) -> CGFloat
    {
        // For devices with a bottom safe area, we want to make our drawer taller. Your implementation may not want to do that. In that case, disregard the bottomSafeArea value.
        return 264.0 + (pulleyViewController?.currentDisplayMode == .drawer ? bottomSafeArea : 0.0)
    }
    
    func supportedDrawerPositions() -> [PulleyPosition] {
        if self.agencyInfoView.isHidden {
            return PulleyPosition.all
        }else{
            return [.partiallyRevealed, .collapsed]
        }
         // You can specify the drawer positions you support. This is the same as: [.open, .partiallyRevealed, .collapsed, .closed]
    }
    
    // This function is called by Pulley anytime the size, drawer position, etc. changes. It's best to customize your VC UI based on the bottomSafeArea here (if needed). Note: You might also find the `pulleySafeAreaInsets` property on Pulley useful to get Pulley's current safe area insets in a backwards compatible (with iOS < 11) way. If you need this information for use in your layout, you can also access it directly by using `drawerDistanceFromBottom` at any time.
    func drawerPositionDidChange(drawer: PulleyViewController, bottomSafeArea: CGFloat)
    {
        // We want to know about the safe area to customize our UI. Our UI customization logic is in the didSet for this variable.
//        drawerBottomSafeArea = bottomSafeArea
        
        /*
         Some explanation for what is happening here:
         1. Our drawer UI needs some customization to look 'correct' on devices like the iPhone X, with a bottom safe area inset.
         2. We only need this when it's in the 'collapsed' position, so we'll add some safe area when it's collapsed and remove it when it's not.
         3. These changes are captured in an animation block (when necessary) by Pulley, so these changes will be animated along-side the drawer automatically.
         */
        delegate?.drawerPositionChanged(drawer.drawerPosition)
//        if drawer.drawerPosition == .collapsed
//        {
//            headerSectionHeightConstraint.constant = 68.0 + drawerBottomSafeArea
//        }
//        else
//        {
//            headerSectionHeightConstraint.constant = 68.0
//        }
//
//        // Handle tableview scrolling / searchbar editing
//
//        tableView.isScrollEnabled = drawer.drawerPosition == .open || drawer.currentDisplayMode == .panel
//
//        if drawer.drawerPosition != .open
//        {
//            searchBar.resignFirstResponder()
//        }
//
//        if drawer.currentDisplayMode == .panel
//        {
//            topSeparatorView.isHidden = drawer.drawerPosition == .collapsed
//            bottomSeperatorView.isHidden = drawer.drawerPosition == .collapsed
//        }
//        else
//        {
//            topSeparatorView.isHidden = false
//            bottomSeperatorView.isHidden = true
//        }
    }
    
    /// This function is called when the current drawer display mode changes. Make UI customizations here.
    func drawerDisplayModeDidChange(drawer: PulleyViewController) {
        print("Drawer: \(drawer.currentDisplayMode)")
        
//        gripperTopConstraint.isActive = drawer.currentDisplayMode == .drawer
    }
}

extension DrawerMapViewController: MapViewControllerDelegate {
    func didUpdateAgencies(_ agencies: [AgencyLocationModel]){
        self.agencyItems.value.removeAll()
        self.agencyItems.value += agencies
    }
    
    func didSelectAgencyAtIndex(_ index: Int) {
        selectedIndex = index
        if index < self.tableView.numberOfRows(inSection: 0) {
            self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
        }
        self.viewAgencyInfoAtIndex(index)
    }
    
    func didChangeCurrentLocation(_ location: CLLocation) {
        currentLocation.value = location
    }
    
    func showOrHideDrawer(_ isShow: Bool){
        if isShow {
            pulleyViewController?.setDrawerPosition(position: .partiallyRevealed, animated: true)
        }else {
            pulleyViewController?.setDrawerPosition(position: .collapsed, animated: true)
        }
        pulleyViewController?.setNeedsSupportedDrawerPositionsUpdate()
    }
}

extension DrawerMapViewController {
    func openMaps(latitude: CLLocationDegrees, longitude: CLLocationDegrees, addressName: String) {
        let googleMapsInstalled = UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")!)
        
        if googleMapsInstalled {
            openGoogleMaps(latitude: latitude, longitude: longitude)
        }else{
            openAppleMaps(latitude: latitude, longitude: longitude, addressName: addressName)
        }
    }
    
    func openGoogleMaps(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let strUrl = "comgooglemaps-x-callback://" + "?daddr=\(latitude),\(longitude)&directionsmode=car&zoom=17"
        guard let url = URL(string: strUrl) else {return}
        UIApplication.shared.open(url)
    }
    
    func openAppleMaps(latitude: CLLocationDegrees, longitude: CLLocationDegrees, addressName: String) {
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = addressName
        mapItem.openInMaps(launchOptions: nil)
    }
}
