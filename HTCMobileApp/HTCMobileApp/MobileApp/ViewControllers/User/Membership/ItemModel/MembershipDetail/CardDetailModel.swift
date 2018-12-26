//
//  CardDetailModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct CardDetailModel: BaseModel {
    public var identifier: String = "CardDetailCell"
    public let point: Int?
    public let activeDate: String?
    public let expiredDate: String?
    public let brand: String?
    public let addressBrand: String?
    public let phone: String?
    
    public func getPoint() -> Int {
        return point ?? 0
    }
    
    public func getActiveDate() -> String {
        return activeDate ?? ""
    }
    
    public func getBrand() -> String {
        return brand ?? ""
    }
    public func getAddressBrand() -> String {
        return addressBrand ?? ""
    }
    
    public func getExpiredDate() -> String {
        return expiredDate ?? ""
    }
    public func getPhone() -> String {
        return phone ?? ""
    }
    
    init(point: Int, activeDate: String, expiredDate: String, brand: String, addressBrand: String, phone: String) {
        
        self.point = point
        self.activeDate = activeDate
        self.expiredDate = expiredDate
        self.brand = brand
        self.addressBrand = addressBrand
        self.phone = phone
        
    }
    
    
}
