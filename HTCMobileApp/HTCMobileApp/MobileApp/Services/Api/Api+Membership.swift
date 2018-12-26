//
//  Api+Membership.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
extension Api {
    public func getMembershipList() -> RequestProtocol {
        return HTCRequest(function: Constants.membershipGetList, httpMethod: .get, isRequireLogin: true)
    }
    
    public func addMembership(cardNumber: String) -> RequestProtocol {
        let data: [String:Any] = [
            "cardNumber":cardNumber
        ]
        return HTCRequest(function: Constants.membershipAddCard, httpMethod: .post, isRequireLogin: true, postData: data)
    }
    
    public func getHistoryUsingPoint(skipCount: Int, maxResultCount: Int, membershipCode: String, fromDate: String, toDate: String) -> RequestProtocol {
        let params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)&MembershipCode=\(membershipCode)&FromDate=\(fromDate)&ToDate=\(toDate)"
        return HTCRequest(function: Constants.membershipGetUsingPointHistory, httpMethod: .get,isRequireLogin: true, getParams: params)
    }
    public func getHistoryNoUsingPoint(skipCount: Int, maxResultCount: Int, membershipCode: String, fromDate: String, toDate: String) -> RequestProtocol {
        let params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)&MembershipCode=\(membershipCode)&FromDate=\(fromDate)&ToDate=\(toDate)"
        return HTCRequest(function: Constants.membershipGetNoUsingPointHistory, httpMethod: .get,isRequireLogin: true, getParams: params)
    }
    public func getIncentiveHistory(skipCount: Int, maxResultCount: Int, membershipCode: String, fromDate: String, toDate: String) -> RequestProtocol {
        let params = "SkipCount=\(skipCount)&MaxResultCount=\(maxResultCount)&MembershipCode=\(membershipCode)&FromDate=\(fromDate)&ToDate=\(toDate)"
        return HTCRequest(function: Constants.membershipIncentiveHistory, httpMethod: .get,isRequireLogin: true, getParams: params)
    }
    
    //  Not use
//    public func getMembershipDetail(cardNumber: String) -> RequestProtocol {
//
//        return HTCRequest(function: Constants.membershipGetDetail, httpMethod: .get, isRequireLogin: true)
//    }
    
}
