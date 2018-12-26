//
//  PaymentPeriodModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct PaymentPeriodModel: BaseModel {
    public var identifier: String = "InstallmentCollectionViewCell"
    public let name: String?
    public let totalOutstandingDebt: String?
    public let originalInMonth: String?
    public let interestOfMonth: String?
    public let originalAndInterest: String?

    public func getName() -> String {
        return name ?? ""
    }

    public func getTotalDebt() -> String {
        return totalOutstandingDebt ?? ""
    }
    
    public func getOriginalInMonth() -> String {
        return originalInMonth ?? ""
    }
    
    public func getInterestOfMonth() -> String {
        return interestOfMonth ?? ""
    }
    
    public func getOriginalAndInterest() -> String {
        return originalAndInterest ?? ""
    }

    init(name: String, totalDebt: String, originalInMonth: String, interestOfMonth: String, originalAndInterest: String) {
        self.name = name
        self.totalOutstandingDebt = totalDebt
        self.originalInMonth = originalInMonth
        self.interestOfMonth = interestOfMonth
        self.originalAndInterest = originalAndInterest
    }
}
extension PaymentPeriodModel: ImmutableMappable {
    public init(map: Map) throws {
        self.name                   = try? map.value("name")
        self.totalOutstandingDebt   = try? map.value("name")
        self.originalInMonth        = try? map.value("name")
        self.interestOfMonth        = try? map.value("name")
        self.originalAndInterest    = try? map.value("name")
    }
}
