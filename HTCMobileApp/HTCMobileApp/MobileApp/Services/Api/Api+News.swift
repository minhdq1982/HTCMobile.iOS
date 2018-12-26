//
//  Api+News.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
extension Api {
    public func getNewsGroupList() -> RequestProtocol {
        return HTCRequest(function: Constants.getNewsGroupList, httpMethod: .get)
    }
    
    public func getNewsHTC(skipCount: Int, maxResultCount: Int) -> RequestProtocol {
        let params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        return HTCRequest(function: Constants.getNewsHTC, httpMethod: .get,isRequireLogin: true, getParams: params)
    }
    
    public func getNewsMarketAndProduct(skipCount: Int, maxResultCount: Int) -> RequestProtocol {
        let params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        return HTCRequest(function: Constants.getNewsMarketAndProduct, httpMethod: .get,isRequireLogin: true, getParams: params)
    }
    
    public func getNewsFromHome(groupId: Int, skipCount: Int, maxResultCount: Int) -> RequestProtocol {
        let params = "Id=\(groupId)&SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)"
        return HTCRequest(function: Constants.getNewsFromHome, httpMethod: .get, isRequireLogin: true, getParams:params)
    }
}
