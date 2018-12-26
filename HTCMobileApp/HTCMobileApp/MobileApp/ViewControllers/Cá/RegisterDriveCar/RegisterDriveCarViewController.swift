//
//  RegisterDriveCarViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import DropDown
import RxSwift
import RxCocoa

class RegisterDriveCarViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var modelButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var agencyButton: UIButton!
    
    @IBOutlet weak var modelTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var agencyTextField: UITextField!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var notesTextField: UITextField!
    @IBOutlet weak var registerButton: CustomButton!
    
    let dropDown = DropDown()
    
    let models:[String] = ["Grand i10 2017", "Accent", "Tucson", "Elantra",
                           "Santa Fe", "Country", "HD 210"]
    let cities:[String] = ["-- Chọn thành phố --", "THÀNH PHỐ HÀ NỘI", "THÀNH PHỐ HỒ CHÍ MINH", "THÀNH PHỐ HẢI PHÒNG","THÀNH PHỐ ĐÀ NẴNG", "THÀNH PHỐ HÀ GIANG", "THÀNH PHỐ CAO BẰNG"]
    
    let agencies: [String] = ["-- Chọn đại lý --", "Hyundai Hà Đông", "Hyundai Vinh", "Hyundai Đà Nẵng", "Hyundai HCM"]
    
    override func setupView() {
        super.setupView()
        
        viewModel = RegisterDriveCarViewModel(service: HTCService())
        let source = RegisterDriveCarViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()), registerAction: self.registerButton.rx.tap.asDriver())
        
        let sink = (viewModel as! RegisterDriveCarViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Đăng ký lái thử")
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? RegisterDriveCarViewModel.Sink {
            modelButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showModelDropdown()
                }).disposed(by: disposeBag)
            cityButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showCitiesDropdown()
                }).disposed(by: disposeBag)
            agencyButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showAgenciesDropdown()
                }).disposed(by: disposeBag)
            registerButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.registerAction()
                }).disposed(by: disposeBag)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func showModelDropdown() {
        self.dismissKeyboard()
        dropDown.anchorView = self.modelButton
        dropDown.dataSource = models
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.modelTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func showCitiesDropdown() {
        self.dismissKeyboard()
        dropDown.anchorView = self.cityButton
        dropDown.dataSource = cities
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.cityTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func showAgenciesDropdown() {
        self.dismissKeyboard()
        dropDown.anchorView = self.agencyButton
        dropDown.dataSource = agencies
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.agencyTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func registerAction() {
        let model = modelTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let city = cityTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let agency = agencyTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let fullname = fullNameTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let phone = phoneTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        let email = emailTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
//        let notes = notesTextField.text?.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines) ?? ""
        
        if model.isEmpty || city.isEmpty || agency.isEmpty || fullname.isEmpty || phone.isEmpty || email.isEmpty {
            self.showMessage(message: "Mời quý khách nhập đầy đủ các thông tin") {
                
            }
        }
        //  Call API
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}
