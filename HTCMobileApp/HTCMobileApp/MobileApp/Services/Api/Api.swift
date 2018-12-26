//
//  Api.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public class Api {
    
    var url = Constants.baseUrl
    var accessToken = ""
    var userId: Int = 0
    
    public static let `default`: Api = {
        return Api()
    }()
    
    public func getUrl() -> String
    {
        return self.url
    }
    
    public func getFacebookUrl() -> String
    {
        return String(format: Constants.facebookUrl, Constants.facebookPageId)
    }
    
    public func getYoutubeUrl() -> String{
        return Constants.youtubeUrl
    }
    
    func isLogin() -> Bool {
        return self.accessToken.count > 0
    }
    
    func setAccessToken(_ accessToken:String, userId: Int){
        self.accessToken = accessToken
        self.userId = userId
    }
    
    public func clearAccessToken () {
        setAccessToken("", userId: 0)
    }
}
