//
//  MenuViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MenuViewController: BaseViewController {
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userInfoLabel: UILabel!
    @IBOutlet weak var scheduleLabel: UILabel!
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var scheduleImageView: UIImageView!
    
    @IBOutlet weak var userProfileImageView: AvatarImageView!
    @IBOutlet weak var logoutButton: CustomButton!
    @IBOutlet weak var loginButton: UIButton!
    
    
    @IBOutlet weak var personalInfoButton: UIButton!
    @IBOutlet weak var maintenanceSchedulerButton: UIButton!
    @IBOutlet weak var settingButtonButton: UIButton!
    
    let isLoggedIn: Variable<Bool> = Variable(false)
    
    override func setupView() {
        super.setupView()
        
        viewModel = MenuViewModel(service: Service())
        let source = MenuViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()), logoutAction: self.logoutButton.rx.tap.asDriver())
        let sink = (viewModel as! MenuViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isLoggedIn.value = UserPrefsHelper.shared.isLoggedIn()
    }
    
    override func localizable() {
        super.localizable()
        helloLabel.text = tr(L10n.menuTextHello)
        if !UserPrefsHelper.shared.isLoggedIn() {
            loginLabel.text = tr(L10n.menuTextLogin)
        }else{
            
        }
        userInfoLabel.text = tr(L10n.menuTextPersonalInfo)
        scheduleLabel.text = tr(L10n.menuTextMaintenanceScheduler)
        settingLabel.text = tr(L10n.menuTextSetting)
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? MenuViewModel.Sink {
            self.loginButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.tapLoginAction()
                }).disposed(by: disposeBag)
            self.logoutButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.tapLogoutAction()
                }).disposed(by: disposeBag)
            self.personalInfoButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.tapPersonalInfoAction()
                }).disposed(by: disposeBag)
            self.maintenanceSchedulerButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.tapMaintenanceSchedulerAction()
                }).disposed(by: disposeBag)
            self.settingButtonButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.tapSettingAction()
                }).disposed(by: disposeBag)

            isLoggedIn.asObservable()
                .subscribe(onNext: {[weak self] (value) in
                    self?.loginButton.isHidden = value
                    self?.logoutButton.isHidden = !value
                    self?.personalInfoButton.isEnabled = value
                    self?.maintenanceSchedulerButton.isEnabled = value
                    self?.phoneLabel.isHidden = !value
                    self?.emailLabel.isHidden = !value
                    if value == true {
                        self?.loginLabel.text = "Pham Hai Tuan"
                        self?.userInfoLabel.textColor = Colours.textColor
                        self?.scheduleLabel.textColor = Colours.textColor
//                        self?.userImageView.image = R.image.menu_user()
//                        self?.scheduleImageView.image = R.image.menu_schedule()
                    }else{
                        self?.loginLabel.text = tr(L10n.menuTextLogin)
                        self?.userInfoLabel.textColor = Colours.greyColor
                        self?.scheduleLabel.textColor = Colours.greyColor
//                        self?.userImageView.image = R.image.menu_user_inactive()
//                        self?.scheduleImageView.image = R.image.menu_schedule_inactive()
                    }
                    
                }).disposed(by: disposeBag)
            
            //  TODO logut action
        }
    }
    
    @objc func tapLoginAction() {
        //  Move to login screen
        isLoggedIn.value = true
    }
    @objc func tapLogoutAction() {
        //  Move to login screen
        isLoggedIn.value = false
    }
    @objc func tapPersonalInfoAction() {
        //  Move to user profile
        if let userProfileVC = R.storyboard.user.userProfileViewController() {
            self.navigationController?.pushViewController(userProfileVC, animated: true)
        }
    }
    @objc func tapMaintenanceSchedulerAction() {
        //  Move to maintenance schedule
    }
    @objc func tapSettingAction() {
        //  Move to setting
    }
}
