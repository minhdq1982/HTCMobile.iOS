//
//  HistoryIncentiveModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct HistoryIncentiveModel: BaseModel {
    public var identifier: String = "UsingIncentiveCell"
    public let transactionCode: String?
    public let membershipId: Int?
    public let membershipCode: String?
    public let membershipCardNumber: String?
    public let benefitTypeId: Int?
    public let benefitTypeName: String?
    public let transactionDate: String?
    public let typeIncentive: String?
    public let numberUsing: Int?
    public let numberAccept: Int?
    public let programCode: String?
    public let programName: String?
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
    public func getTypeIncentive() -> String {
        return typeIncentive ?? ""
    }
    public func getNumberUsing() -> Int {
        return  numberUsing ?? 0
    }
    public func getNumberAccept() -> Int {
        return numberAccept ?? 0
    }
    public func getProgramCode() -> String {
        return  programCode ?? ""
    }
    public func getProgramName() -> String {
        return programName ?? ""
    }
    public func getActive() -> Bool {
        return isActive ?? false
    }
    public func getId() -> Int {
        return id ?? 0
    }
    
    
}
extension HistoryIncentiveModel: ImmutableMappable {
    public init(map: Map) throws {
        self.transactionCode                    = try? map.value("transactionCode")
        self.membershipId                       = try? map.value("membershipId")
        self.membershipCode                     = try? map.value("membershipCode")
        self.membershipCardNumber               = try? map.value("benefitTypeName")
        self.benefitTypeId                      = try? map.value("benefitTypeId")
        self.benefitTypeName                    = try? map.value("benefitTypeName")
        self.transactionDate                    = try? map.value("transactionDate")
        self.typeIncentive                      = try? map.value("typeIncentive")
        self.numberUsing                        = try? map.value("numberUsing")
        self.numberAccept                       = try? map.value("numberAccept")
        self.programCode                        = try? map.value("programCode")
        self.programName                        = try? map.value("programName")
        self.isActive                           = try? map.value("isActive")
        self.id                                 = try? map.value("id")
    }
}
