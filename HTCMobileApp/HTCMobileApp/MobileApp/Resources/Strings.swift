/*
 Strings.swift
 HTCMobileApp
 
 Created by Tuan Pham Hai  on 10/19/18.
 Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
 */

import Foundation

enum L10n {
    // Alert
    case alertTitle
    
    case alertAgree
    
    case alertAskMember
    
    case alertClose
    
    case alertUseCardNote
    
    case alertAddCardTitle
    //  Home
    case homeTitle
    case homeTextAddCard
    case homeTextInterest
    case homeTextCardInfo
    case homeTextUseCard
    
    case carsTitle
    
    case servicesTitle
    case servicesTextSchedule
    case servicesTextMaintenancePrice
    
    case newsTitle
    
    case supportTitle
    
    case termofuseTextAgree
    
    //  Common
    case commonTextOK
    case commonTextCancel
    
    //  Menu
    case menuTextHello
    case menuTextLogin
    case menuTextLogout
    case menuTextPersonalInfo
    case menuTextMaintenanceScheduler
    case menuTextSetting
    
    // login
    case loginTitle
    
    case loginPhoneNumber
    
    case loginNote
    
    case loginCheck
    
    // login confirm
    case loginConfirm
    
    case loginConfirmCheck
    
    case loginConfirmNote
    
    case loginConfirmTitle
    
    case loginConfirmCode
    
    case loginConfirmCodeExpired
    
    case loginConfirmCodeExpirationTime
    
    case loginConfirmResendCode
    
    case loginConfirmCheckLengthCode
    
    //user
    case userTitle
    
    case userCarInformation
    
    case userCardMember
    
    case userSave
    
    case userPhone
    
    case userCMND
    
    case userAddress
    
    case userDateBirth
    
    case userEmail
    
    case userAddMemberTitle
    
    case userAddMember
    
    case userCarAddTitle
    
    case userCarTitle
    
    case userCarName
    
    case userCarVinno
    
    case userCarLicensePlate
    
    case userCarNote
    
    case userCarBrand
    
    case userCarDatePurchase
    
    case userCarEditTitle
    
    // news
    case newsFeed
    
    case newsHTC
    
    case newsProduct
    
    case goodNews
    
    // benefit
    case benefitTitle
    
    case benefitDetail
    
    case benefitBrand
    
    case benefitOfYou
    
    // history card
    case historyTitle
}

extension L10n: CustomStringConvertible {
    var description: String { return self.string }
    
    var string: String {
        switch self {
            
        //  Home
        case .homeTitle:
            return L10n.tr("home.title")
        case .homeTextAddCard:
            return L10n.tr("home.text.add.card")
        case .homeTextInterest:
            return L10n.tr("home.text.interest")
        case .homeTextCardInfo:
            return L10n.tr("home.text.card.info")
        case .homeTextUseCard:
            return L10n.tr("home.text.use.card")
        
        //  Cars
        case .carsTitle:
            return L10n.tr("cars.title")
            
        //  Services
        case .servicesTitle:
            return L10n.tr("services.title")
        case .servicesTextSchedule:
            return L10n.tr("services.text.schedule")
        case .servicesTextMaintenancePrice:
            return L10n.tr("services.text.maintenance.price")
            
        //  News
        case .newsTitle:
            return L10n.tr("news.title")
            
        //  Support
        case .supportTitle:
            return L10n.tr("support.title")
            
        case .termofuseTextAgree:
            return L10n.tr("termofuse.text.agree")
            
        //  Common
        case .commonTextOK:
            return L10n.tr("common.text.ok")
        case .commonTextCancel:
            return L10n.tr("common.text.cancel")
            
        //  Menu
        case .menuTextHello:
            return L10n.tr("menu.text.hello")
        case .menuTextLogin:
            return L10n.tr("menu.text.login")
        case .menuTextLogout:
            return L10n.tr("menu.text.logout")
        case .menuTextPersonalInfo:
            return L10n.tr("menu.text.personal.info")
        case .menuTextMaintenanceScheduler:
            return L10n.tr("menu.text.maintenance.scheduler")
        case .menuTextSetting:
            return L10n.tr("menu.text.setting")
            
        // Login
        case .loginTitle:
            return L10n.tr("login.title")
            
        case .loginNote:
            return L10n.tr("login.note")
            
        case .loginPhoneNumber:
            return L10n.tr("login.phoneNumber")
            
        // Login Confirm
        case .loginCheck:
            return L10n.tr("login.check")
            
        case .loginConfirm:
            return L10n.tr("login.confirm")
            
        case .loginConfirmCode:
            return L10n.tr("login.confirm.code")
            
        case .loginConfirmTitle:
            return L10n.tr("login.confirm.title")
            
        case .loginConfirmNote:
            return L10n.tr("login.confirm.note")
            
        case .loginConfirmCodeExpired:
            return L10n.tr("login.confirm.code.expired")
            
        case .loginConfirmCodeExpirationTime:
            return L10n.tr("login.confirm.code.expiration.time")
            
        case .loginConfirmResendCode:
            return L10n.tr("login.confirm.resend.code")
            
        case .loginConfirmCheck:
            return L10n.tr("login.confirm.check")
            
        case .loginConfirmCheckLengthCode:
            return L10n.tr("login.confirm.check.length.code")
            
        // User
        case .userTitle:
            return L10n.tr("user.title")
        case .userCarInformation:
            return L10n.tr("user.car.information")
        case .userCardMember:
            return L10n.tr("user.member.card")
        case .userSave:
            return L10n.tr("user.save")
        case .userPhone:
            return L10n.tr("user.phone")
        case .userCMND:
             return L10n.tr("user.cmnd")
        case .userAddress:
             return L10n.tr("user.address")
        case .userDateBirth:
             return L10n.tr("user.dateOfBirth")
        case .userEmail:
             return L10n.tr("user.email")
        case .userAddMember:
            return L10n.tr("user.add.member")
        case .userAddMemberTitle:
            return L10n.tr("user.add.member.title")
        case .userCarAddTitle:
            return L10n.tr("user.car.add")
        case .userCarTitle:
            return L10n.tr("user.car.title")
        case .userCarName:
            return L10n.tr("user.car.name")
        case .userCarVinno:
            return L10n.tr("user.car.vinno")
        case .userCarLicensePlate:
            return L10n.tr("user.car.license.plate")
        case .userCarNote:
            return L10n.tr("user.car.note")
        case .userCarBrand:
            return L10n.tr("user.car.brand")
        case .userCarDatePurchase:
            return L10n.tr("user.car.date.purchase")
            
        case .userCarEditTitle:
            return L10n.tr("user.edit.car.title")
            
        // News
        case .newsFeed:
            return L10n.tr("news.newfeeds")
        case .newsHTC:
            return L10n.tr("news.htc")
        case .newsProduct:
            return L10n.tr("news.product")
        case .goodNews:
            return L10n.tr("news.good.title")
            
       // Benefit
        case .benefitTitle:
            return L10n.tr("benefit.title")
        case .benefitDetail:
            return L10n.tr("benefit.detail")
        case .benefitBrand:
            return L10n.tr("benefit.brand")
        case .benefitOfYou:
            return L10n.tr("benefit.of.you")

        // Alert
        case .alertTitle:
            return L10n.tr("alert.title")
        
        case .alertClose:
            return L10n.tr("alert.close")
        case .alertAgree:
            return L10n.tr("alert.agree")
        case .alertAskMember:
             return L10n.tr("alert.ask.member")
        case .alertUseCardNote:
            return L10n.tr("alert.use.card.note")
        case .alertAddCardTitle:
            return L10n.tr("alert.add.card.title")
        
       // History Card
        case .historyTitle:
            return L10n.tr("history.title")
      
        
        }
       
        
        
    }
    
    fileprivate static func tr(_ key: String, _ args: CVarArg...) -> String {
        //  TODO: Load current setting language code: en, vi
        let languageCode = "vi"
        let path = Bundle.main.path(forResource: languageCode, ofType: "lproj")
        let bundle = Bundle(path: path!)
        let format = bundle?.localizedString(forKey: key, value: nil, table: nil)
        return String(format: format!, arguments: args)
    }
}

func tr(_ key: L10n) -> String {
    return key.string
}
