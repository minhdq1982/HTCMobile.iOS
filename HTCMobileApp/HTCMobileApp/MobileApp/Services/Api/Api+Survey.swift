//
//  Api+Survey.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
extension Api {
    public func getSurvey(phone: String) -> RequestProtocol {
        let params = "_phone=\(phone)"
        return HTCRequest(function: Constants.getSurvey, httpMethod: .get, isRequireLogin: true, getParams: params)
    }
    
    public func checkSurvey(token: String) -> RequestProtocol {
        let params = "_token=\(token)"
        return HTCRequest(function: Constants.checkSurvey, httpMethod: .get, isRequireLogin: true, getParams: params)
    }
    
    public func postSurveyAnswer(token: String, device: String, answers: String) -> RequestProtocol {
        let data: [String:Any] = [
            "token":token,
            "device":device,
            "answers":answers
        ]
        return HTCRequest(function: Constants.postSurveyAnswers, httpMethod: .post, isRequireLogin: true, postData: data)
    }
}
