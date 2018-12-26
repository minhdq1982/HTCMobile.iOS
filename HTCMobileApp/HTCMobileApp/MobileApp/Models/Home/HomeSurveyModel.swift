//
//  HomeSurveyModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct HomeSurveyModel: BaseModel {
    
    public var identifier = "HomeSurveyCell"
    public let number: Int?
    public let token: String?
    public let fullName: String?
    public let phoneNumber: String?
    public let email: String?
    public let address: String?
    public let dayPayment: String?
    public let carName: String?
    public let agencyName: String?
    public let status: Int?
    public let dateAnswer: String?
    public let daySent: String?
    public let dayExpired: String?
    public let surveyType: Int?
    public let id: Int?
    
    public func getType() -> Int {
        return surveyType ?? -1
    }
    
    init(surveyType: Int) {
        self.number         = 0
        self.token          = ""
        self.fullName       = ""
        self.phoneNumber    = ""
        self.email          = ""
        self.address        = ""
        self.dayPayment     = ""
        self.carName        = ""
        self.agencyName     = ""
        self.status         = 0
        self.dateAnswer     = ""
        self.daySent        = ""
        self.dayExpired     = ""
        self.surveyType     = surveyType
        self.id             = 0
    }
}

extension HomeSurveyModel: ImmutableMappable {
    public init(map: Map) throws {
        self.number         = try? map.value("number")
        self.token          = try? map.value("token")
        self.fullName       = try? map.value("fullName")
        self.phoneNumber    = try? map.value("phoneNumber")
        self.email          = try? map.value("email")
        self.address        = try? map.value("address")
        self.dayPayment     = try? map.value("dayPayment")
        self.carName        = try? map.value("carName")
        self.agencyName     = try? map.value("agencyName")
        self.status         = try? map.value("status")
        self.dateAnswer     = try? map.value("dateAnswer")
        self.daySent        = try? map.value("daySent")
        self.dayExpired     = try? map.value("dayExpired")
        self.surveyType     = try? map.value("surveyType")
        self.id             = try? map.value("id")
    }
}
