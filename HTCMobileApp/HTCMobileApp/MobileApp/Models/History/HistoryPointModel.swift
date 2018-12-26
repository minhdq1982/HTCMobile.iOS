//
//  HistoryPointModel.swift
//  HTCMobileApp
//
//  Created by admin on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct HistoryPointModel: BaseModel {
    public var identifier: String = "HistoryCardCell"
    public let transactionCode: String?
    public let membershipId: Int?
    public let membershipCode: String?
    public let membershipCardNumber: String?
    
    public let benefitTypeId: Int?
    public let benefitTypeName: String?
    public let transactionDate: String?
    public let type: String?
    public let points: Int?
    public let userChange: String?
    public let isActive: Bool?
    public let id: Int?
    
    
    public func getTransactionCode() -> String {
        return transactionCode ?? ""
    }
    
    public func getMembershipId() -> Int {
        return membershipId ?? 0
    }
    public func getMembershipCode() -> String {
        return  membershipCode ?? ""
    }
    public func getMembershipCardNumber() -> String {
        return membershipCardNumber ?? ""
    }
    public func getBenefitTypeId() -> Int {
        return benefitTypeId ?? 0
    }
    public func getBenefitTypeName() -> String {
        return benefitTypeName ?? ""
    }
    public func getTransactionDate() -> String {
        return transactionDate ?? ""
    }
    public func getType() -> String {
        return type ?? ""
    }
    public func getPoints() -> Int {
        return  points ?? 0
    }
    public func getUserChange() -> String {
        return userChange ?? ""
    }
    public func getActive() -> Bool {
        return isActive ?? false
    }
    public func getId() -> Int {
        return id ?? 0
    }
    
    init() {
        self.transactionCode = ""
        self.membershipId = 0
        self.membershipCode = ""
        self.membershipCardNumber = ""
        self.benefitTypeId = 0
        self.benefitTypeName = ""
        self.transactionDate = ""
        self.type = ""
        self.points = 0
        self.userChange = ""
        self.isActive = false
        self.id = 0
    }
    
    
}
extension HistoryPointModel: ImmutableMappable {
    public init(map: Map) throws {
        self.transactionCode                    = try? map.value("transactionCode")
        self.membershipId                       = try? map.value("membershipId")
        self.membershipCode                     = try? map.value("membershipCode")
        self.membershipCardNumber               = try? map.value("benefitTypeName")
        self.benefitTypeId                      = try? map.value("benefitTypeId")
        self.benefitTypeName                    = try? map.value("benefitTypeName")
        self.transactionDate                    = try? map.value("transactionDate")
        self.type                               = try? map.value("type")
        self.points                             = try? map.value("points")
        self.userChange                         = try? map.value("userChange")
        self.isActive                           = try? map.value("isActive")
        self.id                                 = try? map.value("id")
    }
}
