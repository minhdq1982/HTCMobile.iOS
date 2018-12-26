//
//  UserCarModel.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct UserCarModel: BaseModel {
    public var identifier: String = "CarUserCell"
    public let indexNo: Int?
    public let Id: Int?
    public let carId: Int?
    public let name: String?
    public let vINNO: String?
    public let licensePlate: String?
    public let agencyId: Int?
    public let agencyName: String?
    public let purchaseDate: String?
    public let carImage: String?
    
    public func getId() -> Int {
        return Id ?? 0
    }
    
    public func getIndexNo() -> Int {
        return indexNo ?? 0
    }
    
    public func getCarImage() -> URL? {
        if let image = carImage {
            return URL(string: "\(Constants.imageBaseUrl)\(image)")
        }
        return nil
    }
    
    public func getCarId() -> Int {
        return carId ?? 0
    }
    
    public func getCarName() -> String {
        return name ?? ""
    }
    
    public func getCarVINNO() -> String {
        return vINNO ?? ""
    }
    
    public func getCarLicensePlate() -> String {
        return licensePlate ?? ""
    }
    
    public func getCarAgencyId() -> Int {
        return agencyId ?? 0
    }
    
    public func getCarAgencyName() -> String {
        return agencyName ?? ""
    }
    
    public func getCarPurchaseDate() -> String {
        return purchaseDate ?? ""
    }
   
    
    public init(name: String, agencyName: String, licensePlate: String, purchaseDate: String, carImage: String) {
        self.name = name
        self.vINNO = ""
        self.licensePlate = licensePlate
        self.Id = 0
        self.carId = 0
        self.agencyId = 0
        self.agencyName = agencyName
        self.purchaseDate = purchaseDate
        self.indexNo = 0
        self.carImage = carImage
        
    }
}

extension UserCarModel: ImmutableMappable {
    public init(map: Map) throws {
        self.indexNo        = try? map.value("indexNo")
        self.carId          = try? map.value("carId")
        self.name           = try? map.value("carName")
        self.vINNO          = try? map.value("vinNo")
        self.licensePlate   = try? map.value("licensePlate")
        self.agencyId       = try? map.value("agencyId")
        self.agencyName     = try? map.value("agencyName")
        self.purchaseDate   = try? map.value("purchaseDate")
        self.carImage       = try? map.value("carImage")
        self.Id             = try? map.value("id")
    }
}
