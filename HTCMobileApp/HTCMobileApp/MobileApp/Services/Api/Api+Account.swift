//
//  Api+Account.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Api {
    public func login(phone:String, deviceToken: String, terminal: String) -> RequestProtocol {
        let data: [String:Any] = [
            "phone":phone,
            "deviceToken": deviceToken,
            "terminal": terminal
        ]
        return HTCRequest(function: Constants.accountLogin, httpMethod: .post, postData: data)
    }

    
    public func verifyLogin(phone: String, code:String) -> RequestProtocol {
        let data: [String:Any] = [
            "phone":phone,
            "code":code
        ]
        return HTCRequest(function: Constants.accountVerifyLogin, httpMethod: .post, postData: data)
    }
    
    public func logout() -> RequestProtocol {
        return HTCRequest(function: Constants.accountLogout, httpMethod: .post, isRequireLogin: true, postData: [:])
    }
    
    public func setting(notification: Bool, newsfeed: Bool) -> RequestProtocol {
        let data: [String:Any] = [
            "notification":notification,
            "newsfeed":newsfeed
        ]
        return HTCRequest(function: Constants.accountSetting, httpMethod: .post, isRequireLogin: true, postData: data)
    }
    
    public func getProfileDetail() -> RequestProtocol {
        let params = "Id=\(Api.default.userId)"
        return HTCRequest(function: Constants.getProfileDetail, httpMethod: .get, isRequireLogin: true, getParams: params)
    }
    
    public func updateProfile(name: String, identifyId: String, birthDay: String, email: String, address: String) -> RequestProtocol {
        let data: [String:Any] = [
            "name":name,
            "email":email,
            "identityId":identifyId,
            "birthday":birthDay,
            "address":address
        ]
        
        return HTCRequest(function: Constants.updateProfile, httpMethod: .post, isRequireLogin: true, postData: data)
    }
    public func updateAvatar(imageData: Data) -> RequestProtocol {
        return HTCRequest(function: Constants.updateAvatar, httpMethod: .post, isRequireLogin: true, isMultipartForm: true, imageData: imageData)
    }
    
    public func addCar(carId: Int, vinno: String, licensePlate: String) -> RequestProtocol{
        let data: [String:Any] = [
            "carId":carId,
            "vinno":vinno,
            "licensePlate":licensePlate
//            "agencyId":(agencyId == -1 ? "" : agencyId),
//            "purchaseDate": purchaseDate
        ]
        return HTCRequest(function: Constants.postCar, httpMethod: .post, isRequireLogin: true, postData: data)
    }
    public func editCar(id: Int, carId: Int, vinno: String, licensePlate: String/*, agencyId: Int, purchaseDate: String*/) -> RequestProtocol{
        let data: [String:Any] = [
            "id":id,
            "carId":carId,
            "vinno":vinno,
            "licensePlate":licensePlate
//            "agencyId":agencyId,
//            "purchaseDate": purchaseDate
        ]
        return HTCRequest(function: Constants.postCar, httpMethod: .post, isRequireLogin: true, postData: data)
    }
    
    public func deleteCar(id: Int) -> RequestProtocol {
        let params = "Id=\(id)"
        return HTCRequest(function: Constants.deleteCar, httpMethod: .delete, isRequireLogin: true, getParams: params)
    }
    
}
