//
//  AgencyBenefitModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct AgencyBenefitModel: BaseModel {
    public var identifier: String = ""
    
    public var name: String?
    public var address: String?
    public var phone: String?
    
    public func getName() -> String {
        return name ?? ""
    }
    public func getAddress() -> String {
        return address ?? ""
    }
    public func getPhone() -> String {
        return phone ?? ""
    }
    
    init(identifier: String, name: String, address: String, phone: String) {
        self.identifier = identifier
        self.name = name
        self.address = address
        self.phone = phone
    }
    
}
