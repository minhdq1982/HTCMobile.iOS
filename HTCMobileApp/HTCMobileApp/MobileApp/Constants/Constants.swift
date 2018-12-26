//
//  Constants.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    //  MARK: - Services
    //  Local
    public static let baseUrl = "http://192.168.50.132:8989/api/v1"
    public static let imageBaseUrl = "http://192.168.50.132:8989/"

    //  Public
//    public static let baseUrl = "http://14.160.64.50:21021/api/v1"
//    public static let imageBaseUrl = "http://14.160.64.50:21021/"
    
    public static let maxLoadMoreNumber: Int = 20
    public static let verifyCodeNumber: Int = 4
    public static let verifyCodeTime: Int = 60
    public static let enterDateFormat: String = "dd/mm/yyyy"
    
    //  Account
    public static let accountLogin = "/TokenAuth/MobileLogin"//"/Account/MobileLogin"
    public static let accountVerifyLogin = "/TokenAuth/MobileVerifyLogin" //"/Account/MobileVerifyLogin"
    public static let accountLogout = "/Account/MobileLogout"
    public static let accountSetting = "/Account/MobileSetting"
    
    //  Profile
    public static let getProfileDetail = "/Profile/MobileGetDetail"
    public static let updateProfile = "/Profile/MobileUpdate"
    public static let updateAvatar = "/Profile/MobileUpdateAvatar"
    public static let postCar = "/Profile/MobilePostCar"
    public static let deleteCar = "/Profile/MobileDeleteCar"
    
    //  Membership
    public static let membershipAddCard = "/Membership/MobileAddCard"
    public static let membershipGetList = "/Membership/MobileGetList"
    public static let membershipGetDetail = "/Membership/MobileGetDetail"
    
    public static let membershipGetNoUsingPointHistory = "/Membership/MobileGetPointAccumulatingHistory"
    public static let membershipGetUsingPointHistory = "/Membership/MobileGetPointUsingHistory"
    public static let membershipIncentiveHistory = "/Membership/MobileGetIncentiveUsingHistory"
   
    // Car
    public static let carList = "/Car/MobileGetList"
    
    //  Feedback
    public static let feedback = "/Support/MobilePost"
    
    //  Agency
    public static let agencyList = "/Agency/MobileGetList"
    public static let agencyNearBy = "/Agency/MobileGetListNearby"
    public static let agencyFilter = "/Agency/MobileGetAndFilter"
    public static let agencyGetListByCity = "/Agency/MobileGetListByCity"
    
    //  Cities
    public static let cityList = "/City/MobileGetList"
    
    public static let termOfUse = "/Term/MobileGetDetail"
    
    //  Guide
    public static let warrantyList = "/WarrantyPolicy/MobileGetList"
    public static let warrantyDetail = "/WarrantyPolicy/MobileGetDetail"
    
    public static let guideBookList = "/GuideBook/MobileGetList"
    public static let guideBookDetail = "/GuideBook/MobileGetDetail"
    
    public static let technicalGuideList = "/TechnicalGuide/MobileGetList"
    public static let technicalGuideDetail = "/TechnicalGuide/MobileGetDetail"
    
    //  News
    public static let getNewsGroupList = "/News/MobileGetNewsGroupsList"
    public static let getNewsHTC = "/News/MobileGetNewsHTC"
    public static let getNewsMarketAndProduct = "/News/MobileGeNewsMarketAndProduct"
    public static let getNewsFromHome = "/News/MobileGetListNewsHome"
    
    public static let getSurvey = "/Survey/MobileGetSurvey"
    public static let checkSurvey = "/Survey/MobileCheckSurvey"
    public static let postSurveyAnswers = "/Survey/MobilePostSurveyAnswer"
    
    //  Settings
    public static let getSetting = "/Setting/MobileGet"
    
    //  Facebook
    public static let facebookUrl = "https://graph.facebook.com/v3.2/%@/feed"
    public static let facebookPageId = "207999709243254"
    public static let facebooPageToken = "EAADZC9LnnVpEBAPxUovPoX3lLuYOFaDSDI5mYf3gOdsYoJ6J5ScZCZCbuSJ5FTlRah3Pyv31eLZCsEODdHRns316Q0jIjmYJcfpkY4nGyu2BAujmdGxLA3dXjZBs2DXOjqwpgeelx1RUEKsP1aiPirY4lnOg6ez21dUQZCuTcv6wZDZD"
    public static let facebookFields = "full_picture,message,created_time,link,privacy"
    
    //  Youtube
    public static let youtubeUrl = "https://www.googleapis.com/youtube/v3/search"
    public static let openYoutubeUrl = "https://www.youtube.com/watch?v=%@"
    public static let youtubeChannelId = "UCCbtto6O9fmY_iSn0m3h7ng"
    
    //  MARK: - Google API key
    public static let googleAPIKey = "AIzaSyCkexWFeezWBxOBS40eJ-kdrSabtkQKTqg"
}

struct Colours {
    static let themeColor = colorFromHex("002856")
    static let tabbarColor = colorFromHex("001124")
    static let tabbarTextColor = colorFromHex("00c1ee")
    static let greyColor = colorFromHex("808080")
    static let textColor = colorFromHex("111111")
    static let borderColor = colorFromHex("dddddd")
    static let placeHolderColor = colorFromHex("999999")
    static let choosenColor = colorFromHex("1aa7cc")
    static let blueColor = colorFromHex("0d6797")
    static let headerColor = colorFromHex("385f7b")
    static let black = colorFromHex("000000")
    static let white = colorFromHex("FFFFFF")
    static let frenchBlue = colorFromHex("3F5FA3")
    static let darkBlue = colorFromHex("00005D")
    static let greyish = colorFromHex("EFEFFF")
    static let borderSurveyColor = colorFromHex("CCCCCC")
    
    // use card
    static let silverText = colorFromHex("555555")
    static let goldText = colorFromHex("5F5C3C")
    static let platiumText = colorFromHex("DABF7B")
    static let useCardPlatinumText = colorFromHex("6E530B")
    
    //  Service
    static let activeColor = colorFromHex("D9302A")
    static let inactiveColor = colorFromHex("999999")
    static let stepActiveColor = colorFromHex("00AAD2")
    static let stepInactiveColor = colorFromHex("2C62A1")
    
    //  Maps
    static let directionColor = colorFromHex("4196fc")
    
}
