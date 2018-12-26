//
//  AppointmentScheduleIModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct AppointmentScheduleModel: BaseModel {
    public var identifier = "AppointmentScheduleCell"
    
    let customerName, phone, car: String?
    let carID: Int?
    let city: String?
    let cityID: Int?
    let agency: String?
    let agencyID: Int?
    let scheduleDate, scheduleTime: String?
    let status, id: Int?
    
    init() {
        self.customerName = "Nguyễn Văn A"
        self.phone = "0973092060"
        self.car = "tuanph@tinhvan.com"
        self.carID = 0
        self.city = ""
        self.cityID = 0
        self.agency = ""
        self.agencyID = 0
        self.scheduleDate = ""
        self.scheduleTime = ""
        self.status = 0
        self.id = 0
    }
}

extension AppointmentScheduleModel: ImmutableMappable {
    public init(map: Map) throws {
        self.customerName       = try? map.value("customerName")
        self.phone              = try? map.value("phone")
        self.car                = try? map.value("car")
        self.carID              = try? map.value("carId")
        self.city               = try? map.value("city")
        self.cityID             = try? map.value("cityId")
        self.agency             = try? map.value("agency")
        self.agencyID           = try? map.value("agencyId")
        self.scheduleDate       = try? map.value("scheduleDate")
        self.scheduleTime       = try? map.value("scheduleTime")
        self.status             = try? map.value("status")
        self.id                 = try? map.value("id")
    }
}
