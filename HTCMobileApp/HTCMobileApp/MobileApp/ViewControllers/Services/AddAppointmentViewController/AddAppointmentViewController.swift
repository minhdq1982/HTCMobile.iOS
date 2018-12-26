//
//  AddAppointmentViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import DropDown

class AddAppointmentViewController: BaseViewController {
    
    @IBOutlet weak var stepsView: UIView!
    @IBOutlet weak var line1View: UIView!
    @IBOutlet weak var line2View: UIView!
    @IBOutlet weak var step2ImageView: UIImageView!
    @IBOutlet weak var step3ImageView: UIImageView!
    
    @IBOutlet weak var step1View: UIView!
    @IBOutlet weak var step2View: UIView!
    @IBOutlet weak var step3View: UIView!
    @IBOutlet weak var step4View: UIView!
    
    @IBOutlet weak var step2ScrollView: UIScrollView!
    @IBOutlet weak var step3ScrollView: UIScrollView!
    @IBOutlet weak var step4ScrollView: UIScrollView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var previousIcon: UIImageView!
    @IBOutlet weak var forwardIcon: UIImageView!
    
    //  Step 1
    
    @IBOutlet weak var step1TitleLabel: UILabel!
    @IBOutlet weak var service1Label: UILabel!
    @IBOutlet weak var service2Label: UILabel!
    @IBOutlet weak var service3Label: UILabel!
    @IBOutlet weak var service4Label: UILabel!
    @IBOutlet weak var service5Label: UILabel!
    
    //  Step 2
    @IBOutlet weak var step2TitleLabel: UILabel!
    @IBOutlet weak var step2GuideLabel: UILabel!
    @IBOutlet weak var planDateLabel: UILabel!
    @IBOutlet weak var planDateTextField: UITextField!

    @IBOutlet weak var planTimeLabel: UILabel!
    @IBOutlet weak var planTimeButton: UIButton!
    @IBOutlet weak var planTimeTextField: UITextField!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var agencyLabel: UILabel!
    @IBOutlet weak var agencyButton: UIButton!
    @IBOutlet weak var agencyTextField: UITextField!
    
    @IBOutlet weak var staffLabel: UILabel!
    @IBOutlet weak var staffTextField: UITextField!
    @IBOutlet weak var requireTextLabel: UILabel!
    
    //  Step 3
    @IBOutlet weak var step3TitleLabel: UILabel!
    @IBOutlet weak var customerInfoLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var preNameButton: UIButton!
    @IBOutlet weak var preNameTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var notesLabel: UILabel!
    @IBOutlet weak var notesTextField: UITextField!
    
    @IBOutlet weak var carInfoLabel: UILabel!
    @IBOutlet weak var carModelLabel: UILabel!
    @IBOutlet weak var carModelButton: UIButton!
    @IBOutlet weak var carModelTextField: UITextField!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var versionButton: UIButton!
    @IBOutlet weak var versionTextField: UITextField!
    @IBOutlet weak var lisensePlateLabel: UILabel!
    @IBOutlet weak var lisensePlateTextField: UITextField!
    
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var yearButton: UIButton!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var step3RequiredLabel: UILabel!
    
    let serviceIndexs: Variable<[Int]> = Variable([])
    let currentStepIndex: Variable<Int> = Variable(1)
    var appointmentModel: AppointmentDataModel = AppointmentDataModel()
    
    var dropDown = DropDown()
    let times = ["09:00", "10:00", "11:00", "12:00", "13:00", "14:00", "15:00", "16:00", "17:00"]
    let cities = ["Hà nội", "TP. Hồ Chí Minh", "Đà nẵng", "Khánh hoà", "Vinh"]
    let agencies = ["Hyundai Đông Anh", "Hyundai Long Biên", "Hyundai Hà Đông", "Hyundai Giải Phóng", "Hyundai Phạm Hùng"]
    let preNames = ["Ông", "Bà", "Anh", "Chị"]
    let carModelNames = ["Grand i10 2017", "Grand i10 sedan"]
    let versions = ["BA", "CM", "HD", "LM", "RB"]
    let years = ["2018", "2017", "2016", "2015", "2014", "2013", "2012"]
    
    
    override func setupView() {
        super.setupView()
        
        viewModel = AddAppointmentViewModel(service: HTCService())
        let source = AddAppointmentViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            doneAction: self.doneButton.rx.tap.asDriver())
        let sink = (viewModel as! AddAppointmentViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Đặt lịch hẹn")
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? AddAppointmentViewModel.Sink {
            currentStepIndex.asObservable()
                .subscribe(onNext: {[weak self] (index) in
                    self?.showStepAtIndex(index)
                }).disposed(by: disposeBag)
            
            self.continueButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.currentStepIndex.value += 1
                }).disposed(by: disposeBag)
            
            self.previousButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.currentStepIndex.value -= 1
                }).disposed(by: disposeBag)
            self.doneButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }).disposed(by: disposeBag)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func chooseService(_ sender: UIButton) {
        currentStepIndex.value = 2
    }
    
    @IBAction func tapPlanDateAction(_ sender: Any) {

    }
    
    @IBAction func tapPlanTimeAction(_ sender: Any) {
        selectTimeDropdown()
    }
    @IBAction func tapCityAction(_ sender: Any) {
        selectCityDropdown()
    }
    @IBAction func tapAgencyAction(_ sender: Any) {
        selectAgencyDropdown()
    }
    @IBAction func tapPreNameAction(_ sender: Any) {
        selectPrenameDropdown()
    }
    @IBAction func tapCarModelAction(_ sender: Any) {
        selectCarModelsDropdown()
    }
    @IBAction func tapCarVesionAction(_ sender: Any) {
        selectVersionDropdown()
    }
    @IBAction func tapYearAction(_ sender: Any) {
        selectYearDropdown()
    }
    
    func stepProgressAt(step: Int) {
        if step == 1 {
            line1View.backgroundColor = Colours.stepInactiveColor
            line2View.backgroundColor = Colours.stepInactiveColor
            step2ImageView.image = R.image.step_inactive()
            step3ImageView.image = R.image.step_inactive()
        }else if step == 2 {
            line1View.backgroundColor = Colours.stepActiveColor
            line2View.backgroundColor = Colours.stepInactiveColor
            step2ImageView.image = R.image.step_active()
            step3ImageView.image = R.image.step_inactive()
        }else if step == 3 {
            line1View.backgroundColor = Colours.stepActiveColor
            line2View.backgroundColor = Colours.stepActiveColor
            step2ImageView.image = R.image.step_active()
            step3ImageView.image = R.image.step_active()
        }
    }
    
    func showStepAtIndex(_ index: Int) {
        
        self.stepProgressAt(step: index)
        
        switch index {
        case 1: //  Choose service
            step1View.isHidden = false
            step2View.isHidden = true
            step3View.isHidden = true
            step4View.isHidden = true
            previousButton.isHidden = true
            previousIcon.isHidden = true
            doneButton.isHidden = true
            continueButton.isHidden = true
            forwardIcon.isHidden = true
        case 2:
            step1View.isHidden = true
            step2View.isHidden = false
            step3View.isHidden = true
            step4View.isHidden = true
            previousButton.isHidden = false
            previousIcon.isHidden = false
            doneButton.isHidden = true
            continueButton.isHidden = false
            forwardIcon.isHidden = false
        case 3:
            step1View.isHidden = true
            step2View.isHidden = true
            step3View.isHidden = false
            step4View.isHidden = true
            previousButton.isHidden = false
            previousIcon.isHidden = false
            doneButton.isHidden = true
            continueButton.isHidden = false
            forwardIcon.isHidden = false
        case 4:
            step1View.isHidden = true
            step2View.isHidden = true
            step3View.isHidden = true
            step4View.isHidden = false
            previousButton.isHidden = true
            previousIcon.isHidden = true
            doneButton.isHidden = false
            continueButton.isHidden = true
            forwardIcon.isHidden = true
        default:
            print("nothing to do")
        }
    }
    
    func updateUI(_ stepIndex: Int) {
        
    }
}

extension AddAppointmentViewController {
    func selectTimeDropdown() {
        dropDown.anchorView = self.planTimeButton
        dropDown.dataSource = times
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.planTimeTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func selectCityDropdown() {
        dropDown.anchorView = self.cityButton
        dropDown.dataSource = cities
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.cityTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func selectAgencyDropdown() {
        dropDown.anchorView = self.agencyButton
        dropDown.dataSource = agencies
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.agencyTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func selectPrenameDropdown() {
        dropDown.anchorView = self.preNameButton
        dropDown.dataSource = preNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.preNameTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func selectCarModelsDropdown() {
        dropDown.anchorView = self.carModelButton
        dropDown.dataSource = carModelNames
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.carModelTextField.text = item
        }
        dropDown.direction = .top
        dropDown.show()
    }
    
    func selectVersionDropdown() {
        dropDown.anchorView = self.versionButton
        dropDown.dataSource = versions
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.versionTextField.text = item
        }
        dropDown.direction = .top
        dropDown.show()
    }
    
    func selectYearDropdown() {
        dropDown.anchorView = self.yearButton
        dropDown.dataSource = years
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.yearTextField.text = item
        }
        dropDown.direction = .top
        dropDown.show()
    }
}
