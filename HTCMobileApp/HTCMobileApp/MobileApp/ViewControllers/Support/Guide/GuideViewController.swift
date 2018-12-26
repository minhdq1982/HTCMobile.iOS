//
//  GuideViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/1/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class GuideViewController: BaseViewController {
    @IBOutlet weak var segment0: SegmentView!
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var segment2: SegmentView!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var technicalTableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var searchContraintHeight: NSLayoutConstraint!
    let segmentIndex:Variable<Int> = Variable(0)
    let searchText: Variable<String> = Variable("")
    
    let warranties: Variable<[WarrantyPolicyModel]> = Variable([])
    
    var technicalRefresh: RefreshHandler?
    var guidebookRefresh: RefreshHandler?
    
    override func setupView() {
        super.setupView()
        
        let tabbarHeight = appDelegate.tabbar?.tabBar.frame.size.height ?? 0
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabbarHeight, right: 0)
        self.technicalTableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabbarHeight, right: 0)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: tabbarHeight, right: 0)
        
        searchView.layer.borderColor = Colours.borderColor.cgColor
        searchView.layer.borderWidth = 0.5
        
        self.tableView.register(WarrantyPolicyCell.nib, forCellReuseIdentifier: WarrantyPolicyCell.identifier)
        self.technicalTableView.register(TechnicalGuidanceCell.nib, forCellReuseIdentifier: TechnicalGuidanceCell.identifier)
        self.technicalTableView.register(TechnicalGuidanceCommonCell.nib, forCellReuseIdentifier: TechnicalGuidanceCommonCell.identifier)
        
        //  Collection view
        self.collectionView.register(BookGuidanceCollectionCell.nib, forCellWithReuseIdentifier: BookGuidanceCollectionCell.identifier)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        let width = (UIScreen.main.bounds.width - 50) / 2
        collectionLayout.itemSize = CGSize(width: width, height: 200)
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.headerReferenceSize = CGSize.zero
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        self.collectionView.collectionViewLayout = collectionLayout
        
        //  Init refresh control
        self.technicalRefresh = RefreshHandler(view: self.technicalTableView)
        self.guidebookRefresh = RefreshHandler(view: self.collectionView)
        guard let techRefresh = technicalRefresh, let guideRefresh = guidebookRefresh else {return}
        
        viewModel = GuideViewModel(service: HTCService())
        let source = GuideViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            segmentIndex: segmentIndex.asDriver(),
            searchAction: searchButton.rx.tap.asDriver(),
            endEditingAction: searchTextField.rx.controlEvent([.editingDidEndOnExit]).asDriver(),
            technicalRefresh: techRefresh.refresh.asDriver(onErrorJustReturn: ()),
            guideBookRefresh: guideRefresh.refresh.asDriver(onErrorJustReturn: ()),
            technicalSearchText: searchText.asDriver(),
            guideBookSearchText: searchText.asDriver(),
            loadMoreTechicalAction: self.technicalTableView.rx.reachedBottomWithoutBounces.asDriver(),
            loadMoreGuideBookAction: self.collectionView.rx.reachedBottomWithoutBounces.asDriver())
        
        let sink = (viewModel as! GuideViewModel).transform(source: source)
        self.bindData(sink)
        
        updateSelectedSegment(0)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Hướng dẫn")
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? GuideViewModel.Sink {
            
            searchTextField.rx.text.orEmpty.asDriver()
                .drive(searchText)
                .disposed(by: disposeBag)
            
            sink.warantiesSource
                .drive(self.tableView.rx.itemsSource())
                .disposed(by: disposeBag)
            
            sink.warantiesSource.asDriver()
                .drive(self.warranties)
                .disposed(by: disposeBag)
            
            sink.technicalsSource
                .drive(self.technicalTableView.rx.itemsSource())
                .disposed(by: disposeBag)
            
            sink.guideBooksSource
                .drive(self.collectionView.rx.itemsSource())
                .disposed(by: disposeBag)
            
            sink.technicalsSource
                .asObservable()
                .subscribe(onNext: {[weak self] (items) in
                    print("Technical count: ")
                    self?.technicalRefresh?.end()
                }).disposed(by: disposeBag)
            
            sink.guideBooksSource
                .asObservable()
                .subscribe(onNext: {[weak self] (items) in
                    print("Guide book count: ")
                    self?.guidebookRefresh?.end()
                }).disposed(by: disposeBag)
            
            self.tableView.rx.itemSelected
                .asObservable()
                .subscribe(onNext: {[weak self] (index) in
                    self?.moveToDetailWarrantyPolicy(index: index.row)
                }).disposed(by: disposeBag)
            
            self.technicalTableView.rx.modelSelected(Any.self)
                .asObservable()
                .subscribe(onNext: {[weak self] (model) in
                    if let guide = model as? TechnicalGuidanceModel {
                        self?.moveToDetailTechnicalGuide(data: guide)
                    }
                }).disposed(by: disposeBag)
            
            self.collectionView.rx.modelSelected(Any.self)
                .asObservable()
                .subscribe(onNext: {[weak self] (model) in
                    if let guide = model as? BookGuidanceModel {
                        self?.moveToDetailBookGuide(data: guide)
                    }
                }).disposed(by: disposeBag)
            
            segment0.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.updateSelectedSegment(0)
                }).disposed(by: disposeBag)
            
            segment1.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.updateSelectedSegment(1)
                }).disposed(by: disposeBag)
            
            segment2.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.updateSelectedSegment(2)
                }).disposed(by: disposeBag)
            
            //  Hidden keyboard when scroll
            Driver.merge(tableView.rx.didScroll.asDriver(), technicalTableView.rx.didScroll.asDriver(), collectionView.rx.didScroll.asDriver(), searchButton.rx.tap.asDriver())
            .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.view.endEditing(true)
                }).disposed(by: disposeBag)
            
            //  Handle end refresh animation
            guard let techRefresh = technicalRefresh, let guideRefresh = guidebookRefresh else {return}
            
            techRefresh.refresh.asObservable()
                .subscribe(onNext: {[weak self] _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self?.technicalRefresh?.end()
                    })
                }).disposed(by: disposeBag)
            
            guideRefresh.refresh.asObservable()
                .subscribe(onNext: {[weak self] _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self?.guidebookRefresh?.end()
                    })
                }).disposed(by: disposeBag)
        }
    }
    
    func updateSelectedSegment(_ index: Int) {
        
        segmentIndex.value = index
        searchTextField.text = ""
        searchText.value = ""
        
        segment0.setSelected(false)
        segment1.setSelected(false)
        segment2.setSelected(false)
        
        if index == 0 {
            segment0.setSelected(true)
        }else if index == 1 {
            segment1.setSelected(true)
        }else {
            segment2.setSelected(true)
        }
        
        if index == 0 {
            tableView.isHidden = true
            technicalTableView.isHidden = false
            collectionView.isHidden = true
        }else if index == 1 {
            tableView.isHidden = true
            technicalTableView.isHidden = true
            collectionView.isHidden = false
        }else{
            tableView.isHidden = false
            technicalTableView.isHidden = true
            collectionView.isHidden = true
        }
        
        if index == 2 {
            searchContraintHeight.constant = 0
        }else{
            searchContraintHeight.constant = 35
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveToDetailWarrantyPolicy(index: Int)  {
        
//        if let webVC = R.storyboard.support.webviewController(), let contentVC = R.storyboard.support.contentViewController() {
//
//            webVC.warranties.value += self.warranties.value
//            contentVC.warranties.value += self.warranties.value
//
//            let drawerController    = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
//            drawerController.mainViewController = UINavigationController(
//                rootViewController: webVC
//            )
//            drawerController.drawerViewController = contentVC
//            drawerController.drawerDirection = .right
//            self.navigationController?.pushViewController(drawerController, animated: true)
//        }
        
        if let webVC = R.storyboard.support.webviewController() {
            webVC.warranties.value += self.warranties.value
            webVC.type = .WARRANTY
            webVC.contentIndex.value = index
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
    
    func moveToDetailTechnicalGuide(data: TechnicalGuidanceModel)  {
        
        if let newsDetailVC = R.storyboard.news.newsDetailViewController() {
            newsDetailVC.technicalModel = data
            self.navigationController?.pushViewController(newsDetailVC, animated: true)
        }
    }
    
    func moveToDetailBookGuide(data: BookGuidanceModel)  {
//        if let webVC = R.storyboard.support.webviewController(), let contentVC = R.storyboard.support.contentViewController() {
//
//            webVC.guideBook.value = data
//            contentVC.guideBook.value = data
//
//            let drawerController    = KYDrawerController(drawerDirection: .left, drawerWidth: 300)
//            drawerController.mainViewController = UINavigationController(
//                rootViewController: webVC
//            )
//            drawerController.drawerViewController = contentVC
//            drawerController.drawerDirection = .right
//            self.navigationController?.pushViewController(drawerController, animated: true)
//        }
        if let webVC = R.storyboard.support.webviewController() {
            webVC.guideBook.value = data
            webVC.type = .BOOK
            webVC.contentIndex.value = 0
            self.navigationController?.pushViewController(webVC, animated: true)
        }
    }
}
