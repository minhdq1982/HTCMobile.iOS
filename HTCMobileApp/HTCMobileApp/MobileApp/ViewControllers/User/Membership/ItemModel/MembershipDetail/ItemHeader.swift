//
//  ItemHeader.swift
//  HTCMobileApp
//
//  Created by admin on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct ItemHeader: BaseModel {
    public var identifier: String = "DetailCardCell"
    public var brand: String?
    public var username: String?
    public var vinno: String?
    public var rank: String?
    public var licensePlate: String?
    
    public func getBrand() -> String {
        return brand ?? ""
    }
    public func getUsername() -> String {
        return username ?? ""
    }
    public func getVinno() -> String {
        return vinno ?? ""
    }
    public func getRank() -> String {
        return rank ?? ""
    }
    public func getLicensePlate() -> String {
        return licensePlate ?? ""
    }
    
    init(brand: String, username: String, vinno: String, rank: String, licensePlate: String) {
        self.brand = brand
        self.username = username
        self.vinno = vinno
        self.rank = rank
        self.licensePlate = licensePlate
    }
}
