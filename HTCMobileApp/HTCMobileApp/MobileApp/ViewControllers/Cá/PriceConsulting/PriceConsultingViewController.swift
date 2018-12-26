//
//  PriceConsultingViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import DropDown

class PriceConsultingViewController: BaseViewController {
    
    @IBOutlet weak var modelButton: DropdownButton!
    @IBOutlet weak var yearButton: DropdownButton!
    @IBOutlet weak var cityButton: DropdownButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var costEstimationButton: CustomButton!
    
    @IBOutlet weak var estimationView: UIView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var priceValueLabel: UILabel!
    @IBOutlet weak var totalRegisterTitleLabel: UILabel!
    @IBOutlet weak var totalRegisterValueLabel: UILabel!
    @IBOutlet weak var totalPriceTitleLabel: UILabel!
    @IBOutlet weak var totalPriceValueLabel: UILabel!
    @IBOutlet weak var registrationFeeTitleLabel: UILabel!
    @IBOutlet weak var registrationFeeValueLabel: UILabel!
    @IBOutlet weak var registerTitleLabel: UILabel!
    @IBOutlet weak var registerValueLabel: UILabel!
    @IBOutlet weak var inspectionFeeTitleLabel: UILabel!
    @IBOutlet weak var inspectionFeeValueLabel: UILabel!
    @IBOutlet weak var usingRoadTitleLabel: UILabel!
    @IBOutlet weak var usingRoadValueLabel: UILabel!
    @IBOutlet weak var insuranceTitleLabel: UILabel!
    @IBOutlet weak var insuranceValueLabel: UILabel!
    
    let minScrollContentHeight: CGFloat = 210
    let maxScrollContentHeight: CGFloat = 210 + 520
    
    let dropDown = DropDown()
    let models:[String] = ["Grand i10 2017", "Accent", "Tucson", "Elantra",
                           "Santa Fe", "Country", "HD 210"]
    let cities:[String] = ["-- Chọn khu vực --", "THÀNH PHỐ HÀ NỘI", "THÀNH PHỐ HỒ CHÍ MINH", "THÀNH PHỐ HẢI PHÒNG","THÀNH PHỐ ĐÀ NẴNG", "THÀNH PHỐ HÀ GIANG", "THÀNH PHỐ CAO BẰNG"]
    let years = ["-- Chọn phiên bản --","2018", "2017", "2016", "2015", "2014", "2013", "2012"]
    
    override func setupView() {
        super.setupView()
        self.showEstimateView(false)
        modelButton.setTitle(models[0], for: .normal)
        yearButton.setTitle(years[0], for: .normal)
        cityButton.setTitle(cities[0], for: .normal)
        
        viewModel = PriceConsultingViewModel(service: HTCService())
        let source = PriceConsultingViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()))
        
        let sink = (viewModel as! PriceConsultingViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Tư vấn giá xe")
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? PriceConsultingViewModel.Sink {
            self.modelButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showModelDropdown()
                }).disposed(by: disposeBag)
            self.yearButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showYearsDropdown()
                }).disposed(by: disposeBag)
            self.cityButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showCitiesDropdown()
                }).disposed(by: disposeBag)
            
            self.costEstimationButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    //  TODO handle logic to check estimate price
                    self?.showEstimateView(true)
                }).disposed(by: disposeBag)
        }
    }
    
    func showEstimateView(_ isShow: Bool) {
        estimationView.isHidden = !isShow
        if isShow {
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: maxScrollContentHeight)
        }else{
            scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: minScrollContentHeight)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showModelDropdown() {
        dropDown.anchorView = self.modelButton
        dropDown.dataSource = models
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.modelButton.setTitle(item, for: .normal)
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func showYearsDropdown() {
        dropDown.anchorView = self.yearButton
        dropDown.dataSource = years
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.yearButton.setTitle(item, for: .normal)
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func showCitiesDropdown() {
        dropDown.anchorView = self.cityButton
        dropDown.dataSource = cities
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.cityButton.setTitle(item, for: .normal)
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
}
