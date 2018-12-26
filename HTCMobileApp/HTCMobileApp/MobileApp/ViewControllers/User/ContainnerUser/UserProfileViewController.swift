//
//  UserViewController.swift
//  HTCMobileApp
//
//  Created by admin on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class UserProfileViewController: BaseViewController {
    @IBOutlet weak var changeAvatarButton: UIButton!
    
    @IBOutlet weak var segment2: SegmentView!
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var segment0: SegmentView!
    let segmentIndex: Variable<Int> = Variable(0)
    
    //MARK: - Outlet
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var settingButton: UIButton!
    @IBOutlet weak var userContainer: UIView!
    @IBOutlet weak var membershipContainer: UIView!
    @IBOutlet weak var carInforContainer: UIView!
    
    //  child view controller
    var userInfoVC: UserInfomationViewController?
    var carInfoVC: CarInformationViewController?
    var memberShipVC: MembershipViewController?
    
    var user: User?
    
    //  Car info
    let cars: Variable<[UserCarModel]> = Variable([])
    
    var logoutAction: Driver<Void> = Driver.empty()
    
    //MARK: - LifeCycle
    override func setupView() {
        super .setupView()

        //setup button
        changeAvatarButton.layer.cornerRadius = changeAvatarButton.frame.height / 2
        changeAvatarButton.layer.masksToBounds = true
        
        //setup Avatar
        avatarImageView.layer.cornerRadius = avatarImageView.frame.height / 2
        avatarImageView.layer.borderWidth = 2
        avatarImageView.layer.borderColor = Colours.white.cgColor
        avatarImageView.layer.masksToBounds = true
        
        updateSelectedSegment(segmentIndex.value)
        
        viewModel = UserProfileViewModel(service: HTCService())
        let source = UserProfileViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
            segmentIndex: segmentIndex.asDriver())

        let sink = (viewModel as! UserProfileViewModel).transform(source: source)
        self.bindData(sink)
        
    }
    
    override func localizable() {
        super .localizable()
        self.setHeaderTitle("")
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? UserProfileViewModel.Sink {
            // move on data
            sink.itemsSource
                .asObservable()
                .subscribe { [weak self] (user) in
                    if let user = user.element {
                        self?.user = user
                        self?.updateUI(user: user)
                    }
            }
            .disposed(by: disposeBag)
            
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
            
            settingButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.moveToUserSetting()
                }).disposed(by: disposeBag)
        }
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("user profile prepare")
        if segue.identifier == "userInfoView" {
            if let userInfo = segue.destination as? UserInfomationViewController {
                userInfoVC = userInfo
                
                userInfo.tableView.rx.itemSelected
                    .asObservable()
                    .subscribe(onNext: {[weak self] (index) in
                        if index.row == 5 {
                            guard let s = self else {return}
                            s.editUserProfile(user: s.user)
                        }
                    }).disposed(by: disposeBag)
                
            }
        }else if segue.identifier == "carInfoView" {
            if let carInfo = segue.destination as? CarInformationViewController {
               
                carInfoVC = carInfo
                
            }
        }else if segue.identifier == "memberShipView" {
            if let memberShip = segue.destination as? MembershipViewController {
                memberShipVC = memberShip
            }
        }
    }
    
    func moveToUserSetting() {
        if let settingVC = R.storyboard.settings.settingViewController() {
            self.navigationController?.pushViewController(settingVC, animated: true)
        }
    }
    
    
    func editUserProfile(user: User?) {
        if let user = self.user {
            if let editUserProfileVC = R.storyboard.user.editUserInfoViewController() {
                editUserProfileVC.user = user
                self.navigationController?.pushViewController(editUserProfileVC, animated: true)
            }
        }else{
            self.showMessage(message: "Không có dữ liệu người dùng") {
                
            }
        }
    }
    
    func updateUI(user: User) {
        //  Update UI
        self.usernameLabel.text = user.getName()
        
        // user profile
        self.userInfoVC?.phoneTextField.text = user.getPhone()
        self.userInfoVC?.birthDayTextField.text = user.getBirthdayDisplay()
        self.userInfoVC?.badgeTextField.text = user.getIdentifyCard()
        self.userInfoVC?.emailTextField.text = user.getEmail()
        self.userInfoVC?.addressTextField.text = user.getAddress()
        // update avatar
        if let url = user.getAvatarUrl() {
            self.avatarImageView.kf.setImage(with: url, placeholder: R.image.user_default())
        }else{
            self.avatarImageView.image = R.image.user_default()
        }
        
        // car
        self.carInfoVC?.cars.value = user.getCars()
        
        // membership
        self.memberShipVC?.membershipCards.value = user.getCards()
    }
    
    // MARK: - Functions
    
    
    @IBAction func onChangeAvatar(_ sender: Any) {
    }
    
    override func tapBackAction(_ sender: Any) {
        self.moveToHome()
    }
    
    @IBAction func onSave(_ sender: Any) {
        self.moveToHome()
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
    
    func updateSelectedSegment(_ index: Int) {
        
        segmentIndex.value = index
        segment0.setSelected(false)
        segment1.setSelected(false)
        segment2.setSelected(false)
        
        if index == 0 {
            segment0.setSelected(true)
            segment0.backgroundColor = Colours.white
            segment1.backgroundColor = Colours.greyish
            segment2.backgroundColor = Colours.greyish
            userContainer.isHidden = false
            carInforContainer.isHidden = true
            membershipContainer.isHidden = true
        }else if index == 1 {
            segment1.setSelected(true)
            segment0.backgroundColor = Colours.greyish
            segment1.backgroundColor = Colours.white
            segment2.backgroundColor = Colours.greyish
            carInforContainer.isHidden = false
            userContainer.isHidden = true
            membershipContainer.isHidden = true
        }else {
            segment2.setSelected(true)
            segment0.backgroundColor = Colours.greyish
            segment1.backgroundColor = Colours.greyish
            segment2.backgroundColor = Colours.white
            membershipContainer.isHidden = false
            carInforContainer.isHidden = true
            userContainer.isHidden = true
            
        }
    }
    
}
