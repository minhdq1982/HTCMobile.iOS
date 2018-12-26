//
//  UserPrefsHelper.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let DidChangeLoggedInStatus = NSNotification.Name("DidChangeLoggedInStatus")
}

struct PrefsKey {
    static let keyUserDidAgreeTermOfUse = "keyDidAgreeTermOfUse"
    static let keyUserDidLoggedIn = "keyUserDidLoggedIn"
    static let keyUserDisableLogginInHome = "keyUserDisableLogginInHome"
    static let keyAccessToken = "keyAccessToken"
    static let keyUserProfileId = "keyUserProfileId"
    static let keyUserPhoneNumber = "keyUserPhoneNumber"
}

class UserPrefsHelper: NSObject {
    static let shared: UserPrefsHelper = UserPrefsHelper()
    
    private override init() {}
    
    //  MARK: - Agree terms of use
    func setAgreeTermOfUse(_ isAgree: Bool) {
        UserDefaults.standard.then {
            $0.set(isAgree, forKey: PrefsKey.keyUserDidAgreeTermOfUse)
            $0.synchronize()
        }
    }
    
    func getAgreeTermOfUse() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.keyUserDidAgreeTermOfUse)
    }
    
    func isLoggedIn() -> Bool {
        if let accessToken = UserDefaults.standard.string(forKey: PrefsKey.keyAccessToken) {
            return !accessToken.isEmpty
        }else{
            return false
        }
    }
    
    func setDisableLoginSection(_ isDisable: Bool) {
        UserDefaults.standard.then {
            $0.set(isDisable, forKey: PrefsKey.keyUserDisableLogginInHome)
            $0.synchronize()
        }
    }
    
    func isDisableLoginSection() -> Bool {
        return UserDefaults.standard.bool(forKey: PrefsKey.keyUserDisableLogginInHome)
    }
    
    // MARK: User session
    
    func setAccessToken(_ token: String, userId: Int, phone: String) {
        UserDefaults.standard.then {
            if token.isEmpty {
                $0.removeObject(forKey: PrefsKey.keyAccessToken)
                $0.removeObject(forKey: PrefsKey.keyUserProfileId)
                $0.removeObject(forKey: PrefsKey.keyUserPhoneNumber)
            }else{
                $0.set(token, forKey: PrefsKey.keyAccessToken)
                $0.set(userId, forKey: PrefsKey.keyUserProfileId)
                $0.set(phone, forKey: PrefsKey.keyUserPhoneNumber)
            }
            $0.synchronize()
            
            NotificationCenter.default.post(name: .DidChangeLoggedInStatus, object: nil)
        }
    }
    
    func getUserId() -> Int {
        return UserDefaults.standard.integer(forKey: PrefsKey.keyUserProfileId)
    }
    
    func getAccessToken() -> String {
        return UserDefaults.standard.string(forKey: PrefsKey.keyAccessToken) ?? ""
    }
    
    func getUserPhone() -> String {
        return UserDefaults.standard.string(forKey: PrefsKey.keyUserPhoneNumber) ?? ""
    }
    
}
