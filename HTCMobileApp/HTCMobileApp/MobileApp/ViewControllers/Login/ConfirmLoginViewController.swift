//
//  LoginConfirmViewController.swift
//  HTCMobileApp
//
//  Created by admin on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class ConfirmLoginViewController: BaseViewController {
    // MARK: - Outlet
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var expirationCodeLabel: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var resendCodeLabel: UILabel!
    @IBOutlet weak var resendCodeButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet var codeLabels: [UILabel]!
    
    var phoneNumber: Variable<String> = Variable("")
//    var verifyCode: Variable<String> = Variable("")
    var counter = Constants.verifyCodeTime
    var timer: Timer?
    
    //MARK: - LifeCycle
    
    override func setupView() {
        super.setupView()
        
        self.startTimer()
        
        codeTextField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        
        viewModel = ConfirmLoginViewModel(service: HTCService())
        let source = ConfirmLoginViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            loginAgainAction:self.resendCodeButton.rx.tap.asDriver(),
            phoneNumber: phoneNumber.asDriver(),
            verifyCode: codeTextField.rx.text.orEmpty.asDriver())
        let sink = (viewModel as! ConfirmLoginViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        appDelegate.tabbar?.setHidden(true)
        codeTextField.text = ""
        self.resetCode()
        self.codeTextField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.stopTimer()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        //setup textfield
        codeTextField.setBorder(UIColor.white, 1.0)
        //setup label
        resendCodeLabel.addImageWith(name: "reload_confirm", behindText: false)
    }
    
    override func localizable() {
        super .localizable()
        //set text for UIs
        self.setHeaderTitle(tr(L10n.loginConfirmTitle))
        noteLabel.text = tr(L10n.loginConfirmNote)
        resendCodeLabel.text = tr(L10n.loginConfirmResendCode)
        codeTextField.attributedPlaceholder = NSAttributedString.init(string: tr(L10n.loginConfirmCode), attributes:[NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)])
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        if let sink = sink as? ConfirmLoginViewModel.Sink {
            
            sink.verifyResponse.asObservable()
                .subscribe(onNext: {[weak self] (user) in
                    self?.moveToUserProfile(user: user)
                }).disposed(by: disposeBag)
            sink.resendCodeResponse
                .asObservable()
                .subscribe(onNext: {[weak self] (response) in
                    if response.1 == true {
                        self?.startTimer()
                        self?.showMessage(message: "Gửi mã OTP thành công", closeAction: {
                            print("Gửi mã xác nhận thành công")
                        })
                    }
                }).disposed(by: disposeBag)
            
            stackView.rx.tapGesture()
                .skip(1)
                .subscribe(onNext: {[weak self] (gesture) in
                    self?.codeTextField.text = ""
                    self?.resetCode()
                    self?.codeTextField.becomeFirstResponder()
                }).disposed(by: disposeBag)
        }
    }
    
    //  MARK: TIMER
    func startTimer() {
        counter = Constants.verifyCodeTime
        self.updateCounter()
        self.stopTimer()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if timer != nil && (timer?.isValid == true) {
            timer?.invalidate()
            timer = nil
        }
    }
    
    func resetCode() {
        for i in 0..<Constants.verifyCodeNumber {
            codeLabels[i].text = ""
        }
    }
    
    @objc func textFieldDidChange(sender: UITextField!) {
        if sender.text?.isEmpty == true {
            return
        }
        
        if let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            for i in 0..<Constants.verifyCodeNumber {
                if i < text.count {
                    codeLabels[i].text = text.substring(with: i..<i+1)
                }else{
                    codeLabels[i].text = ""
                }
            }
            print("Code: \(text)")
            
            if text.count >= Constants.verifyCodeNumber {
                self.codeTextField.resignFirstResponder()
            }
        }
    }
    
    
    
    // MARK: - function
    func tapEnterCode() {
        if !self.codeTextField.isFirstResponder {
            self.codeTextField.becomeFirstResponder()
        }
    }
    
    @objc func updateCounter() {
        //you code, this is an example
        if counter >= 0 {
            var inputText: String = ""
            if counter == 60 {
                inputText = " 01:00"
            }else{
                if counter >= 10 {
                    inputText = " 00:\(counter)"
                } else {
                    inputText = " 00:0\(counter)"
                }
            }
            
            if counter == 0 {
                expirationCodeLabel.text = tr(L10n.loginConfirmCodeExpired)
            }else{
                expirationCodeLabel.text = tr(L10n.loginConfirmCodeExpirationTime) + inputText
            }
            if counter > 0 {
                counter -= 1
            }
        }
    }
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func moveToUserProfile(user: User) {
        Api.default.setAccessToken(user.getAccessToken(), userId: user.getId())
        // save token and user id
        UserPrefsHelper.shared.setAccessToken(user.getAccessToken(), userId: user.getId(), phone: user.getPhone())
        
        print("moveToUserProfile")
        
        if user.isFullInfo() {
            //  Move to home screen
            self.moveToHome()
        }else {
            if let editUserInfo = R.storyboard.user.editUserInfoViewController() {
                editUserInfo.user = user
                editUserInfo.isFromLoginSequence = true
                self.navigationController?.pushViewController(editUserInfo, animated: true)
            }
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
}

