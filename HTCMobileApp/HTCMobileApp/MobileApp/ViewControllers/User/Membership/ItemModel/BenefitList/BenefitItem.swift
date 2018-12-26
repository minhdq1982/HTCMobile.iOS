//
//  BenefitItem.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct BenefitItem: BaseModel{
    public var identifier: String = ""
    var isExpand: Bool
    var brand: String?
    var licensePlate: String?
    var name: String?
    var benefits: [BenefitModel]
    
    public func getBrand() -> String {
        return brand ?? ""
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    public func getlicensePlate() -> String {
        return licensePlate ?? ""
    }
    
    init(isExpand: Bool, brand: String, name: String, licensePlate: String, benefits: [BenefitModel]) {
        self.isExpand = isExpand
        self.brand = brand
        self.name = name
        self.licensePlate = licensePlate
        self.benefits = benefits
    }
}
