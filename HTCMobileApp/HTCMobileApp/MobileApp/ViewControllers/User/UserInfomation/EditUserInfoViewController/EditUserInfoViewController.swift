//
//  EditUserInfoViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/22/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import DropDown

class EditUserInfoViewController: BaseViewController {
    @IBOutlet weak var userAvatar: UIImageView!
    @IBOutlet weak var userNameTextField: CommonTextField!
    @IBOutlet weak var phoneTextField: CommonTextField!
    @IBOutlet weak var birthdayTextField: BirthdayTextField!
    @IBOutlet weak var identifierTextField: CommonTextField!
    @IBOutlet weak var emailTextField: CommonTextField!
    @IBOutlet weak var addressTextField: CommonTextField!
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var changeAvatarButton: UIButton!
    @IBOutlet weak var chooseCityButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    var isFromLoginSequence: Bool = false
    
    var imagePicker = UIImagePickerController()
    var user: User?
    
    let name: Variable<String> = Variable("")
    let birthDay: Variable<String> = Variable("")
    let identifyId: Variable<String> = Variable("")
    let email: Variable<String> = Variable("")
    let address: Variable<String> = Variable("")
    let avatar: Variable<UIImage> = Variable(R.image.user_default()!)
    let isChangeAvatar: Variable<Bool> = Variable(false)
    
    var dropDown: DropDown = DropDown()
    
    override func setupView() {
        
//        scrollView.keyboardDismissMode = .onDrag
        
        cameraButton.layer.cornerRadius = 12
        cameraButton.layer.masksToBounds = true
        userAvatar.layer.cornerRadius = 44
        userAvatar.layer.masksToBounds = true
        userAvatar.layer.borderColor = Colours.white.cgColor
        userAvatar.layer.borderWidth = 2
        
        guard let userInfo = user else {return}
        
        viewModel = EditUserInfoViewModel(service: HTCService())
        let source = EditUserInfoViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
            user: Driver.just(userInfo),
            saveAction: self.saveButton.rx.tap.asDriver(),
            name: name.asDriver(),
            birthDay: birthDay.asDriver(),
            identifyId: identifyId.asDriver(),
            email: email.asDriver(),
            address: address.asDriver(),
            avatar: avatar.asDriver(),
            isChangeAvatar: isChangeAvatar.asDriver())
        
        let sink = (viewModel as! EditUserInfoViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        if isFromLoginSequence {
            self.setHeaderTitle("Cập nhật thông tin cá nhân")
            self.backButton.isHidden = true
            self.cancelButton.isHidden = false
        }else{
            self.setHeaderTitle("Sửa thông tin cá nhân")
            self.backButton.isHidden = false
            self.cancelButton.isHidden = true
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? EditUserInfoViewModel.Sink {
            
            userNameTextField.text = user?.getName()
            phoneTextField.text = user?.getPhone()
            birthdayTextField.text = user?.getBirthdayDisplay()
            identifierTextField.text = user?.getIdentifyCard()
            emailTextField.text = user?.getEmail()
            addressTextField.text = user?.getAddress()
//            userAvatar.image = user?.getAvatar()
            
            userNameTextField.rx.text.orEmpty.asDriver()
                .drive(name)
                .disposed(by: disposeBag)
            birthdayTextField.rx.text.orEmpty.asDriver()
                .drive(birthDay)
                .disposed(by: disposeBag)
            identifierTextField.rx.text.orEmpty.asDriver()
                .drive(identifyId)
                .disposed(by: disposeBag)
            emailTextField.rx.text.orEmpty.asDriver()
                .drive(email)
                .disposed(by: disposeBag)
            addressTextField.rx.text.orEmpty.asDriver()
                .drive(address)
                .disposed(by: disposeBag)
            
            sink.updateUserSuccess
                .asObservable()
                .filter{$0 == true}
                .subscribe(onNext: {[weak self] _ in
                    if self?.isFromLoginSequence == true {
                        self?.moveToHome()
                    }else{
                        self?.navigationController?.popViewController(animated: true)
                    }
                }).disposed(by: disposeBag)
            
//            sink.isUpdatingAvatar
//                .asObservable()
//                .skip(1)
//                .subscribe(onNext: { (isUpdating) in
//
//                }).disposed(by: disposeBag)
            
            sink.isUpdatingAvatar
                .drive(self.nvActivityIndicator!.rx.isAnimating)
                .disposed(by: disposeBag)
            sink.isUpdatingAvatar
                .asObservable()
                .subscribe(onNext: { (isFetching) in
                    if isFetching == true {
                        UIApplication.shared.beginIgnoringInteractionEvents()
                    }else {
                        UIApplication.shared.endIgnoringInteractionEvents()
                    }
                }).disposed(by: disposeBag)
            
            
//            sink.saveUserResponse
//                .asObservable()
//                .subscribe(onNext: {[weak self] (user) in
//                    if self?.isFromLoginSequence == true {
//                        self?.moveToHome()
//                    }else{
//                        self?.navigationController?.popViewController(animated: true)
//                    }
//                }).disposed(by: disposeBag)
//
//            sink.updateAvatarSuccess
//                .asObservable()
//                .subscribe(onNext: {[weak self] (isSuccess) in
//                    if isSuccess == true {
//                        if self?.isFromLoginSequence == true {
//                            self?.moveToHome()
//                        }else{
//                            self?.navigationController?.popViewController(animated: true)
//                        }
//                    }
//                }).disposed(by: disposeBag)
            
            sink.isEnableSaveButton
                .asObservable()
                .subscribe(onNext: {[weak self] (isEnable) in
                    if isEnable == true {
                        self?.saveButton.alpha = 1
                        self?.saveButton.isEnabled = true
                    }else{
                        self?.saveButton.alpha = 0.5
                        self?.saveButton.isEnabled = false
                    }
                }).disposed(by: disposeBag)
            
            sink.validation.asObservable()
                .subscribe(onNext: {[weak self] (args) in
                    let (isValid, message) = args
                    if isValid == false {
                        self?.showMessage(message: message, closeAction: {
                            
                        })
                    }
                }).disposed(by: disposeBag)
            
            self.cancelButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    if self?.isFromLoginSequence == true {
                        self?.moveToHome()
                    }else{
                        self?.navigationController?.popViewController(animated: true)
                    }
                }).disposed(by: disposeBag)
            
            self.changeAvatarButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.changeAvatarAction()
                }).disposed(by: disposeBag)
            
            //  Load user avatar
            if let url = user?.getAvatarUrl() {
                userAvatar.kf.setImage(with: url, placeholder: R.image.user_default())
            }
            
            self.saveButton.rx.tap
                .asObservable()
                .subscribe(onNext: { _ in
                    print("press save button")
                }).disposed(by: disposeBag)
            
            self.chooseCityButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.showCitiesDropdown()
                }).disposed(by: disposeBag)
        }
    }
    
    func showCitiesDropdown() {
        if appDelegate.cities.value.count > 0 {
            dropDown.anchorView = self.chooseCityButton
            
            var datas = appDelegate.cities.value.map({ (mode) -> String in
                return mode.getName()
            })
            datas.insert("- Chọn tỉnh/thành phố -", at: 0)
            dropDown.dataSource = datas
            
            dropDown.selectionAction = { [weak self] (index: Int, item: String) in
                guard let s = self else {
                    return
                }
                if index == 0 {
                    s.address.value = ""
                    s.addressTextField.text = ""
                }else {
                    s.addressTextField.text = item
                    s.address.value = item
                }
            }
            dropDown.direction = .top
            dropDown.show()
        }
    }
    
    func moveToHome() {
        if let vcs = navigationController?.viewControllers {
            for vc in vcs {
                if vc is HomeViewController {
                    navigationController?.popToViewController(vc, animated: true)
                    break
                }
            }
        }
    }
    
    func changeAvatarAction() {
        if let alert = R.storyboard.customAlert.chooseAvatarAlertViewController() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            appDelegate.tabbar?.present(alert, animated: true, completion: nil)
            
            alert.chooseAction.asObservable()
                .skip(1)
                .subscribe(onNext: {[weak self] (value) in
                    if value == 0 {
                        self?.changeAvatar(source: .camera)
                    }else if value == 1 {
                        self?.changeAvatar(source: .photoLibrary)
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func changeAvatar(source: UIImagePickerController.SourceType) {
        
        if source == .camera {
            let isAvailable = UIImagePickerController.isSourceTypeAvailable(.camera)
            if isAvailable == false {
                self.showMessage(message: "Thiết bị không hỗ trợ tính năng chụp hình") {}
                return
            }
        }
        
        imagePicker.sourceType = source
        imagePicker.delegate = self
        imagePicker.isEditing = true
        imagePicker.allowsEditing = true
        appDelegate.tabbar?.present(imagePicker, animated: true, completion: nil)
    }
}

extension EditUserInfoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            avatar.value = image
            userAvatar.image = image
            isChangeAvatar.value = true
        }else{
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                avatar.value = image
                userAvatar.image = image
                isChangeAvatar.value = true
            }
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.dismiss(animated: true, completion: nil)
    }
}
