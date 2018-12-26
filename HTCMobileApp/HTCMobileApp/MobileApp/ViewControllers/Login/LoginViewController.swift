//
//  LoginViewController.swift
//  HTCMobileApp
//
//  Created by admin on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    // MARK: - Outlet
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var phoneNumberTextField: LoginTextField!
    
    // MARK: - LifeCycle
    override func setupView() {
        super.setupView()
        
        phoneNumberTextField.delegate = self
        
        viewModel = LoginViewModel(service: HTCService())
        let source = LoginViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
            loginAction: self.loginButton.rx.tap.asDriver(),
            phoneNumber: phoneNumberTextField.rx.text.orEmpty.asDriver())
        let sink = (viewModel as! LoginViewModel).transform(source: source)
        self.bindData(sink)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(true)
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        //setup TextField
//        phoneNumberTextField.setBorder(Colours.white, 1.0)
//    }
    
    override func localizable() {
        super.localizable()
        setHeaderTitle(tr(L10n.loginTitle))
        // setText for UIs
        noteLabel.text = tr(L10n.loginNote)
        loginButton.setTitle(tr(L10n.loginTitle), for: .normal)
        phoneNumberTextField.attributedPlaceholder = NSAttributedString.init(string: tr(L10n.loginPhoneNumber), attributes:[NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)])

    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? LoginViewModel.Sink {
            sink.loginResponse
                .asObservable()
                .subscribe(onNext: {[weak self] (phone, isSuccess) in
                    self?.moveToConfirmLogin(phone, isSuccess: isSuccess)
                }).disposed(by: disposeBag)
            
            sink.validation
                .asObservable()
                .subscribe(onNext: {[weak self] (isValid, message) in
                    if isValid == false {
                        self?.showMessage(message: message, closeAction: {})
                    }
                }).disposed(by: disposeBag)
            
            self.loginButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.phoneNumberTextField.resignFirstResponder()
                }).disposed(by: disposeBag)
        }
    }
    
    //MARK: - functions
   
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveToConfirmLogin(_ phoneNumber: String, isSuccess: Bool) {
        if let confirmLoginVC = R.storyboard.loginConfirm.confirmLoginViewController() {
            confirmLoginVC.phoneNumber.value = phoneNumber
            self.navigationController?.pushViewController(confirmLoginVC, animated: true)
        }
    }
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //  Backward character
        if string.count == 0 && range.length > 0 {
            return true
        }
        
        if let text = phoneNumberTextField.text {
            if text.count >= 11 {
                return false
            }
        }
        
        return true
    }
}
