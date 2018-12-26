//
//  DetaillCarProfileViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import ActionSheetPicker_3_0
import DropDown

class DetaillCarProfileViewController: BaseViewController {
    // MARK: - Outlet and Variable
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var carNameTextField: UITextField!
//    @IBOutlet weak var brandTextFeld: CommonTextField!
//    @IBOutlet weak var selectBrandButton: UIButton!
    @IBOutlet weak var selectCarButton: UIButton!
    @IBOutlet weak var dropDownCarButton: UIButton!
//    @IBOutlet weak var dropDownBrandButton: UIButton!
    @IBOutlet weak var licensePlateTextField: CommonTextField!
    @IBOutlet weak var vinnoTextField: CommonTextField!
    @IBOutlet weak var carImageView: UIImageView!
//    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var saveButton: CustomButton!
//    @IBOutlet weak var dateTextField: BirthdayTextField!
    
    let chooseCarDropDown = DropDown()
    let dropDown = DropDown()
    
    let isAddCar: Variable<Bool> = Variable(false)
    var userCarModel: UserCarModel?
    
    let id: Variable<Int> = Variable(-1)
    let carId: Variable<Int> = Variable(-1)
    let model: Variable<String> = Variable("")
    let vinNo: Variable<String> = Variable("")
    let lisencePlate: Variable<String> = Variable("")
    let agencyId: Variable<Int> = Variable(-1)
    let boughtDate: Variable<String> = Variable("")
    var urlCarImage: URL?
    var agencyName: String?
    var carName: String?
    
    // MARK: - LifeCycle
    override func setupView() {
        super.setupView()
        
        vinnoTextField.delegate = self
        
        //  In case edit car information
        if let userCarModel = self.userCarModel {
            urlCarImage = userCarModel.getCarImage()
            carId.value = userCarModel.getCarId()
            agencyId.value = userCarModel.getCarAgencyId()
            id.value = userCarModel.getId()
            boughtDate.value = userCarModel.getCarPurchaseDate()
            vinNo.value = userCarModel.getCarVINNO()
            lisencePlate.value = userCarModel.getCarLicensePlate()
            agencyName = userCarModel.getCarAgencyName()
            carName = userCarModel.getCarName()
            
            // Update UI
            updateUI()
        }else {
            self.checkDefaultFirstCar()
        }
        
        viewModel = DetailCarProfileViewModel(service: HTCService())
        let source = DetailCarProfileViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
            id: id.asDriver(),
            carId: carId.asDriver(),
            vinNo: vinNo.asDriver(),
            lisencePlate: lisencePlate.asDriver(),
//            agencyId: agencyId.asDriver(),
//            boughtDate: boughtDate.asDriver(),
            isAddCar: isAddCar.asDriver(),
            saveAction: saveButton.rx.tap.asDriver())
        
        let sink = (viewModel as! DetailCarProfileViewModel).transform(source: source)
        self.bindData(sink)        
    }
    
    func checkDefaultFirstCar() {
        if appDelegate.cars.value.count > 0 {
            let model = appDelegate.cars.value[0]
            urlCarImage = model.getCarUrl()
            carId.value = model.getId()
            carName = model.getName()
        }
        
        // Update UI
        updateUI()
    }
    
    override func localizable() {
        super.localizable()
        saveButton.setTitle(tr(L10n.userSave), for: .normal)
        if isAddCar.value == false {
            setHeaderTitle(tr(L10n.userCarEditTitle))
        } else {
            setHeaderTitle(tr(L10n.userCarAddTitle))
        }
    }
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? DetailCarProfileViewModel.Sink {
            
            //  Drive datas
            vinnoTextField.rx.text.orEmpty.asDriver()
                .drive(vinNo)
                .disposed(by: disposeBag)
            
            licensePlateTextField.rx.text.orEmpty.asDriver()
                .drive(lisencePlate)
                .disposed(by: disposeBag)
            
//            dateTextField.rx.text.orEmpty.asDriver()
//                .drive(boughtDate)
//                .disposed(by: disposeBag)
            sink.cars.asObservable()
                .subscribe(onNext: {[weak self] (items) in
                    if items.count > 0 {
                        self?.checkDefaultFirstCar()
                    }
                }).disposed(by: disposeBag)
            
            // Validate input fields
            sink.validateInput.asObservable()
                .subscribe(onNext: {[weak self] (isValid, message) in
                    if isValid == false {
                        self?.showMessage(message: message, closeAction: {})
                    }
                }).disposed(by: disposeBag)
            
            // Choose car
            self.selectCarButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showCarsDropdown()
                }).disposed(by: disposeBag)
            
            //  Choose agency
//            self.selectBrandButton.rx.tap
//                .asObservable()
//                .subscribe(onNext: {[weak self] _ in
//                    self?.showAgenciesDropdown()
//                }).disposed(by: disposeBag)
            
            // Observer add car response
            sink.addCarResponse
                .asObservable()
                .subscribe(onNext: { [weak self] (carModel) in
                    guard let s = self else {return}
                    if carModel.getId() != 0 {
                        s.showMessage(message: "Thêm xe thành công", closeAction: {
                            s.backAction()
                        })
                    }
                }).disposed(by: disposeBag)
            
            // Observer update car info response
            sink.editCarResponse
                .asObservable()
                .subscribe(onNext: { [weak self] (carModel) in
                    guard let s = self else {return}
                    if carModel.getId() != 0 {
                        s.showMessage(message: "Cập nhật thông tin xe thành công", closeAction: {
                            s.backAction()
                        })
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - functions
    
    // UPDATE UI
    func updateUI() {
//        guard let carName = self.carName,
//            let agencyName = self.agencyName else {
//                return
//        }
        if let url = self.urlCarImage {
            self.carImageView.kf.setImage(with: url, placeholder: R.image.no_image_bg_small())
        } else {
            self.carImageView.image = R.image.no_image_bg_small()
        }
        self.vinnoTextField.text = vinNo.value
        self.licensePlateTextField.text = lisencePlate.value
        
//        if boughtDate.value != "" {
//            let milisecond = boughtDate.value.convertStringToMilisecond(format: "yyyy-MM-dd'T'hh:mm:ss")
//            let dateString = milisecond.convertToDateString()
//            self.dateTextField.text = dateString
//        } else {
//            self.dateTextField.text = ""
//        }
        
        self.carNameTextField.text = carName
//        self.brandTextFeld.text = agencyName
    }
    
//    func showAgenciesDropdown() {
//        self.view.endEditing(true)
//        if appDelegate.agencies.value.count > 0 {
//            dropDown.anchorView = dropDownBrandButton
//            dropDown.direction = .bottom
//            let datas = appDelegate.agencies.value.map { (model) -> String in
//                return model.getName()
//            }
//            dropDown.dataSource = datas
//            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
//                guard let s = self else {return}
//                s.brandTextFeld.text = item
//                for agency in appDelegate.agencies.value {
//                    if item == agency.getName() {
//                        s.agencyId.value = agency.getAgencyId()
//                        break
//                    }
//                }
//                print("Agency ID: \(s.agencyId.value)")
//            }
//            dropDown.show()
//        }
//    }
    
    func showCarsDropdown() {
        self.view.endEditing(true)
        if appDelegate.cars.value.count > 0 {
            chooseCarDropDown.anchorView = selectCarButton
            chooseCarDropDown.direction = .bottom
            let datas = appDelegate.cars.value.map { (model) -> String in
                return model.getName()
            }
            chooseCarDropDown.dataSource = datas
            chooseCarDropDown.cellNib = UINib(nibName: "DropCarCell", bundle: nil)
            chooseCarDropDown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
                guard let cell = cell as? DropCarCell else { return }
                cell.optionLabel.text = item
                cell.optionLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Medium", size: 17)
            }
            
            chooseCarDropDown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let s = self else {return}
                s.carNameTextField.text = item
                s.updateCarImage(carName: item)
                for car in appDelegate.cars.value {
                    if item == car.getName() {
                        s.carId.value = car.getId()
                        break
                    }
                }
            }
            chooseCarDropDown.show()
        }
    }

    //back action
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func backAction() {
        navigationController?.popViewController(animated: true)
    }
    
    // update Car Image
    func updateCarImage(carName: String) {
        if appDelegate.cars.value.count > 0 {
            for item in appDelegate.cars.value {
                if carName == item.getName() {
                    if let carUrl = item.getCarUrl() {
                        self.carImageView.kf.setImage(with: carUrl, placeholder: R.image.no_image_bg_small())
                    } else {
                        self.carImageView.image = R.image.no_image_bg_small()
                    }
                    break
                }
            }
        }else{
            self.carImageView.image = R.image.no_image_bg_small()
        }
    }
}

extension DetaillCarProfileViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == vinnoTextField {
            //  Backward character and 
            if (string.count == 0 && range.length > 0) || string == "\n" {
                return true
            }
            
            if let text = vinnoTextField.text {
                if text.count >= 17 {
                    return false
                }
            }
        }
        
        return true
    }
}
