//
//  Api+Support.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Api {
    public func feedback() -> RequestProtocol {
        let data: [String:Any] = [
            "fullName": "Hoàn vũ",
            "phone": "0123456789",
            "email": "hoanvx@tinhvan.com",
            "licensePlate": "anv",
            "feedbackType": "1",
            "content": "My feedback",
            "level": "1",
            "agencyId": 1,
            "carId": 1
        ]
        return HTCRequest(function: Constants.feedback, httpMethod: .post, postData: data)
    }
    
    public func getWarrantyList() -> RequestProtocol {
        return HTCRequest(function: Constants.warrantyList, httpMethod: .get)
    }
    
    public func getWarrantyDetail() -> RequestProtocol {
        return HTCRequest(function: Constants.warrantyDetail, httpMethod: .get)
    }
    
    public func getGuidebookList(skipCount: Int, maxResultCount: Int, keySearch: String) -> RequestProtocol {
        var params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        if !keySearch.isEmpty, let text = keySearch.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            params = "KeySearch=\(text)&SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        }
        return HTCRequest(function: Constants.guideBookList, httpMethod: .get, getParams: params)
    }
    
    public func getGuidebookDetail(bookId: Int) -> RequestProtocol {
        let params = "Id=\(bookId)"
        return HTCRequest(function: Constants.guideBookDetail, httpMethod: .get, getParams: params)
    }
    
    public func getTechnicalGuideList(name: String, skipCount: Int, maxResultCount: Int) -> RequestProtocol {
        var params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        if !name.isEmpty, let text = name.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
            params = "Name=\(text)&SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        }
        return HTCRequest(function: Constants.technicalGuideList, httpMethod: .get, getParams: params)
    }
    
//    public func getTechnicalGuideDetail(technicalId: Int) -> RequestProtocol {
//        let params = "Id=\(technicalId)"
//        return HTCRequest(function: Constants.technicalGuideDetail, httpMethod: .get, getParams: params)
//    }
}
