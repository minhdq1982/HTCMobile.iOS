//
//  AppointmentResponseModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct AppointmentResponseModel: BaseModel {
    public var identifier: String = ""
    
    let id, serviceID, customerID: Int?
    let customerName, phone: String?
    let carID: Int?
    let carName: String?
    let cityID: Int?
    let cityName: String?
    let agencyID: Int?
    let agencyName: String?
    let status: Int?
    let createdDate: String?
}

extension AppointmentResponseModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id                 = try? map.value("id")
        self.serviceID          = try? map.value("serviceId")
        self.customerID         = try? map.value("customerId")
        self.customerName       = try? map.value("customerName")
        self.phone              = try? map.value("phone")
        self.carID              = try? map.value("carId")
        self.carName            = try? map.value("carName")
        self.cityID             = try? map.value("cityId")
        self.cityName           = try? map.value("cityName")
        self.agencyID           = try? map.value("agencyId")
        self.agencyName         = try? map.value("agencyName")
        self.status             = try? map.value("status")
        self.createdDate        = try? map.value("createdDate")
    }
}
