//
//  MapViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import MapKit
import FSPagerView
import RxSwift
import RxCocoa
import RxDataSources
import RxCoreLocation
import RxGoogleMaps
import GoogleMaps
import DropDown
import Pulley

import Alamofire
import SwiftyJSON

protocol MapViewControllerDelegate {
    func didUpdateAgencies(_ agencies: [AgencyLocationModel])
    func didSelectAgencyAtIndex(_ index: Int)
    func didChangeCurrentLocation(_ location: CLLocation)
    func showOrHideDrawer(_ isShow: Bool)
}

class MapViewController: BaseViewController {
    
    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var mapViewBottomContraint: NSLayoutConstraint!
    var delegate: MapViewControllerDelegate?
    
    //  Search view
    @IBOutlet weak var headerSearchButton: UIButton!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTitleLabel: UILabel!
    @IBOutlet weak var searchOrLabel: UILabel!
    @IBOutlet weak var cityTextField: PaddingTextField!
    @IBOutlet weak var cityButton: DropdownButton!
    @IBOutlet weak var agencyTextField: PaddingTextField!
    @IBOutlet weak var searchButton: CustomButton!
    @IBOutlet weak var nearbyButton: UIButton!
    @IBOutlet weak var nearbyButtonContraint: NSLayoutConstraint!
    
    //  Filter view
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var filterSelectedImageView: UIImageView!
    @IBOutlet weak var workshopLabel: UILabel!
    @IBOutlet weak var exhibitionRoomLabel: UILabel!
    @IBOutlet weak var workshopButton: UIButton!
    @IBOutlet weak var exhibitionRoomButton: UIButton!
    @IBOutlet weak var filterLeadingContraint: NSLayoutConstraint!
    
    var isShowingSearchView: Bool = false
    var agencyList: [AgencyLocationModel] = []
    let isShowingListAgency: Variable<Bool> = Variable(true)
    
    //  Search params
    let searchCity: Variable<Int> = Variable(-1)
    let searchAgency: Variable<String> = Variable("")
    let currentLocation: Variable<CLLocation> = Variable(CLLocation.init(latitude: 21.028511, longitude: 105.804817))
    let type: Variable<Int> = Variable(2)
    var polyline: GMSPolyline?
    
    public lazy var branchMarker: UIImageView? = {
        let v = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 38)))
        
        v.image = R.image.map_anotation()
        
        return v
    }()
    public lazy var branchMarkerSelected: UIImageView? = {
        let v = UIImageView(frame: CGRect(origin: .zero, size: CGSize(width: 28, height: 38)))
        
        v.image = R.image.map_anotation_selected()
        
        return v
    }()
    
    var dropDown: DropDown = DropDown()
    
    //  Location
    let manager = CLLocationManager()
    var oldSelectedMarker: GMSMarker?
    var allMarkers: [GMSMarker] = []
    
    override func setupView() {
        super.setupView()
        manager.requestWhenInUseAuthorization()
        // Setup API Key
//        mapView.settings.myLocationButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.zoomGestures = true
        mapView.delegate = self
        mapView.padding = UIEdgeInsets(top: 85, left: 0, bottom: 37, right: 0)
        
        agencyTextField.layer.borderColor = Colours.borderColor.cgColor
        agencyTextField.layer.borderWidth = 0.5
        
        self.searchView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        viewModel = MapViewModel(service: HTCService())
        let source = MapViewModel.Source(
            viewWillAppear: rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            nearByAction: nearbyButton.rx.tap.asDriver(),// mapView.rx.didTapMyLocationButton.asDriver()
            currentLocation: currentLocation.asDriver(),
            type: type.asDriver(),
            searchAction: searchButton.rx.tap.asDriver(),
            searchCity: searchCity.asDriver(),
            searchAgency: searchAgency.asDriver(),
            filterWorkshopAction: workshopButton.rx.tap.asDriver(),
            filterExhibitionAction: exhibitionRoomButton.rx.tap.asDriver())
        let sink = (viewModel as! MapViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        mapView.isMyLocationEnabled = false
        mapView.clear()
        super.viewDidDisappear(animated)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Tìm đại lý")
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? MapViewModel.Sink {
            
            sink.agencyItems.asObservable()
                .subscribe(onNext: {[weak self] (agencies) in
                    self?.agencyList.removeAll()
                    if agencies.count > 0 {
                        self?.delegate?.didUpdateAgencies(agencies)
                        self?.agencyList += agencies
                        self?.addAllAnotations(agencies)
                    }
                }).disposed(by: disposeBag)
            
            agencyTextField.rx.text.orEmpty.asDriver()
                .drive(searchAgency)
                .disposed(by: disposeBag)
            
            headerSearchButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    guard let s = self else {return}
                    if s.isShowingSearchView {
                        self?.doShowSearchAnimation(false)
                    }else{
                        self?.delegate?.showOrHideDrawer(false)
                        self?.doShowSearchAnimation(true)
                    }
                }).disposed(by: disposeBag)
            
            workshopButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.selectFilter(2)
                }).disposed(by: disposeBag)
            
            exhibitionRoomButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.selectFilter(1)
                }).disposed(by: disposeBag)
            
            searchButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.doShowSearchAnimation(false)
                }).disposed(by: disposeBag)
            
            // Marker tapped
            mapView.rx.didTapAt.asDriver()
                .drive(onNext: {
                    print("Did tap at coordinate: \($0)")
                })
                .disposed(by: disposeBag)
            // Location update
            
            mapView.rx.myLocation
                .subscribe(onNext: {[weak self] location in
                    if let l = location {
                        self?.currentLocation.value = l
                        self?.delegate?.didChangeCurrentLocation(l)
                    }
                })
                .disposed(by: disposeBag)
            
            mapView.rx.selectedMarker
                .asObservable()
                .subscribe(onNext: {[weak self] (marker) in
                    guard let s = self else {return}
                    
                    if let old = s.oldSelectedMarker {
                        old.iconView = s.branchMarker
                    }
                    
                    marker?.iconView = s.branchMarkerSelected
                    s.oldSelectedMarker = marker
                    
                    self?.didTapMarker(marker)
                    
                }).disposed(by: disposeBag)
            
            manager.rx
                .didChangeAuthorization
                .subscribe(onNext: { [weak self] _, status in
                    switch status {
                    case .denied:
                        if(CLLocationManager.locationServicesEnabled()){
                            self?.showConfirmMessage(message: "Vào cài đặt để cho phép ứng dụng truy cập GPS", confirmAction: {
                                self?.openSetting()
                            }, cancelAction: {
                                
                            })
                        }
                    case .notDetermined:
                        self?.manager.requestWhenInUseAuthorization()
                    default:
                        break
                    }
                })
                .disposed(by: disposeBag)
        }
    }
    
    func selectFilter(_ index: Int) {
        type.value = index
        if index == 2 {
            workshopLabel.textColor = Colours.white
            exhibitionRoomLabel.textColor = Colours.textColor
            
            UIView.animate(withDuration: 0.25, animations: {
                self.filterLeadingContraint.constant = 0
                self.filterView.setNeedsLayout()
                self.filterView.layoutIfNeeded()
            }) { _ in
                
            }
        }else if index == 1 {
            workshopLabel.textColor = Colours.textColor
            exhibitionRoomLabel.textColor = Colours.white
            
            UIView.animate(withDuration: 0.25, animations: {
                self.filterLeadingContraint.constant = 136
                self.filterView.setNeedsLayout()
                self.filterView.layoutIfNeeded()
            }) { _ in
                
            }
        }
    }
    
    //  MARK: - Show search view
    @IBAction func chooseCityAction(_ sender: Any) {
        self.showCitiesDropdown()
    }
    
    func doShowSearchAnimation(_ isShow: Bool)  {
        if isShow {
            headerSearchButton.setImage(R.image.icon_close(), for: .normal)
            searchView.isHidden = false
            searchView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.alpha = 1
            }) { _ in
                self.showSearch(true)
            }
        }else{
            
            if self.agencyTextField.isFirstResponder == true {
                self.agencyTextField.resignFirstResponder()
            }
            
            headerSearchButton.setImage(R.image.icon_search(), for: .normal)
            searchView.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                self.searchView.alpha = 0
            }) { _ in
                self.showSearch(false)
            }
        }
    }
    
    func showSearch(_ isShow: Bool) {
        if isShow {
            isShowingSearchView = true
            searchView.isHidden = false
            headerSearchButton.setImage(R.image.icon_close(), for: .normal)
        }else{
            isShowingSearchView = false
            searchView.isHidden = true
            headerSearchButton.setImage(R.image.icon_search(), for: .normal)
        }
    }
    
    func showCitiesDropdown() {
        if appDelegate.cities.value.count > 0 {
            dropDown.anchorView = self.cityButton
            
            var datas = appDelegate.cities.value.map({ (mode) -> String in
                return mode.getName()
            })
            datas.insert("- Chọn tỉnh/thành phố -", at: 0)
            
            dropDown.dataSource = datas
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let s = self else {
                    return
                }
                s.cityTextField.text = item
                if index == 0 {
                    s.searchCity.value = -1
                }else if index - 1 < appDelegate.cities.value.count {
                    let cityModel = appDelegate.cities.value[index - 1]
                    s.searchCity.value = cityModel.getId()
                }
            }
            dropDown.direction = .bottom
            dropDown.show()
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        pulleyViewController?.navigationController?.popViewController(animated: true)
    }
    
    func didTapMarker(_ marker: GMSMarker?) {
        if let agency = marker?.userData as? AgencyLocationModel {
            for i in 0..<agencyList.count {
                let ay = agencyList[i]
                if ay.getAgencyId() == agency.getAgencyId() {
                    self.focusToAgencyAtIndex(i)
                    self.delegate?.didSelectAgencyAtIndex(i)
                    break
                }
                
            }
        }
    }
}

extension MapViewController: DrawerMapViewControllerDelegate {
    func selectAgencyAtIndex(_ index: Int) {
        self.focusToAgencyAtIndex(index)
        if isShowingSearchView {
            self.doShowSearchAnimation(false)
        }
        print("Select agency at index: \(index)")
    }
    
    func drawerPositionChanged(_ position: PulleyPosition) {
        if position == PulleyPosition.collapsed {
            mapView.padding = UIEdgeInsets(top: 85, left: 0, bottom: 37, right: 0)
            nearbyButtonContraint.constant = 57
        }else{
            mapView.padding = UIEdgeInsets(top: 85, left: 0, bottom: 264, right: 0)
            nearbyButtonContraint.constant = 288
        }
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    func navigate(to destination: CLLocation) {
        self.drawDirection(from: currentLocation.value, to: destination)
    }
}

extension MapViewController {
    
    func focusToAgencyAtIndex(_ index: Int) {
        if index >= 0 && index < self.agencyList.count {
            let agency = self.agencyList[index]
            self.centerMapOnLocation(location: agency.getLocation())
//            self.delegate?.didSelectAgencyAtIndex(index)
            
            //  Set selected marker
            if index < self.allMarkers.count {
                if let old = oldSelectedMarker {
                    old.iconView = branchMarker
                }
                let marker = self.allMarkers[index]
                marker.iconView = branchMarkerSelected
                oldSelectedMarker = marker
            }
        }
    }
    
    func openSetting() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {return}
        UIApplication.shared.open(url)
    }
    
    func centerMapOnLocation(location: CLLocation) {
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude, longitude:location.coordinate.longitude, zoom:14)
        self.mapView.animate(to: camera)
    }
    
    func addAllAnotations(_ agencies: [AgencyLocationModel]) {
        // show artwork on map
        self.mapView.clear()
        self.allMarkers.removeAll()
        
        //  init bounds
        var bounds: GMSCoordinateBounds = GMSCoordinateBounds.init()
        bounds = bounds.includingCoordinate(self.currentLocation.value.coordinate)
        
        for agency in agencies {
            let position = CLLocationCoordinate2D(latitude: agency.getLatitude(), longitude: agency.getLongitude())
            let marker = GMSMarker(position: position)
            marker.iconView = self.branchMarker
            marker.userData = agency
            marker.title = agency.getName()
            marker.snippet = agency.getAddress()
            marker.map = self.mapView
            
            self.allMarkers.append(marker)
            
            bounds = bounds.includingCoordinate(marker.position)
        }
        
        let camera = GMSCameraUpdate.fit(bounds, withPadding: 30)
        
        self.mapView.animate(with: camera)
    }
}

extension MapViewController: GMSMapViewDelegate {
    // tap map marker
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        // remove color from currently selected marker
        if let selectedMarker = mapView.selectedMarker {
            selectedMarker.iconView = branchMarker
        }
        
        // select new marker and make green
        mapView.selectedMarker = marker
        marker.iconView = branchMarkerSelected
        return true
    }
}

extension MapViewController {
    
    func drawDirection(from source: CLLocation?, to destination: CLLocation?)
    {
        guard let _src = source?.coordinate, let _des = destination?.coordinate else {
            return
        }
        
        //  Move camera to bounds source and destimation
        var bounds: GMSCoordinateBounds = GMSCoordinateBounds.init()
        bounds = bounds.includingCoordinate(_src)
        bounds = bounds.includingCoordinate(_des)
        let camera = GMSCameraUpdate.fit(bounds, withPadding: 30)
        self.mapView.animate(with: camera)
        
        //  Clear GMSPolyline first
        self.polyline?.map = nil
        
        let origin = "\(_src.latitude),\(_src.longitude)"
        let destination = "\(_des.latitude),\(_des.longitude)"
        
        let url = "https://maps.googleapis.com/maps/api/directions/json?origin=\(origin)&destination=\(destination)&mode=driving&key=\(Constants.googleAPIKey)"
        
        Alamofire.request(url).responseJSON { response in
//            print(response.request)  // original URL request
//            print(response.response) // HTTP URL response
//            print(response.data)     // server data
//            print(response.result)   // result of response serialization
            if let data = response.data {
                do {
                    let json = try JSON(data: data)
                    let routes = json["routes"].arrayValue
                    if routes.count > 0 {
                        //  Display the first route
                        let route = routes[0]
                        
                        let routeOverviewPolyline = route["overview_polyline"].dictionary
                        let points = routeOverviewPolyline?["points"]?.stringValue
                        let path = GMSPath.init(fromEncodedPath: points!)
                        
                        self.polyline = GMSPolyline.init(path: path)
                        self.polyline?.strokeColor = Colours.directionColor
                        self.polyline?.strokeWidth = 5
                        self.polyline?.map = self.mapView
                    }
                } catch _ as NSError {
                    // error
                }
            }
        }
    }
}
