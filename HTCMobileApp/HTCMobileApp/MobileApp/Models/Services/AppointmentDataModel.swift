//
//  AppointmentDataModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
public class AppointmentDataModel: NSObject {
    public var identifier: String = ""
    var serviceIds: [Int] = []
    var dateTime: String = ""
    var cityId: Int = 0
    var agencyId: Int = 0
    var serviceStaff: String = ""
    var honorifics: String = ""
    var fullName: String = ""
    var email: String = ""
    var phone: String = ""
    var notes: String = ""
    var carId: Int = 0
    var licensePlate: String = ""
    var year: String = ""
    
    public override init() {
        super.init()
    }
}
