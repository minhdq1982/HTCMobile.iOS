//
//  DetailCarModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct DetailCarModel: BaseModel {
    public var identifier: String = "DetailCarTableViewCell"
    public let carInfo: CarModel?
    
    init(car: CarModel) {
        self.carInfo = car
    }
}
