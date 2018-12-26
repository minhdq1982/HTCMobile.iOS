//
//  CarDetailCardModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct CarDetailCardModel: BaseModel {
    public var identifier: String = "CarDetailCell"
    
    public let carImage: String?
    public let carName: String?
    public let vinno: String?
    public let licensePlate: String?
    public let purchaseDate: String?
    
    public func getCarImage() -> String {
        return carName ?? ""
    }
    public func getCarName() -> String {
        return carName ?? ""
    }
    public func getVinno() -> String {
        return vinno ?? ""
    }
    
    public func getLicensePlate() -> String {
        return licensePlate ?? ""
    }
    public func getPurchaseDate() -> String {
        return purchaseDate ?? ""
    }
    
    init(carName: String, vinno: String, licensePlate: String, purchaseDate: String) {
        
        self.carName = carName
        self.vinno = vinno
        self.licensePlate = licensePlate
        self.purchaseDate = purchaseDate
        self.carImage = ""
    }
    
    
}
