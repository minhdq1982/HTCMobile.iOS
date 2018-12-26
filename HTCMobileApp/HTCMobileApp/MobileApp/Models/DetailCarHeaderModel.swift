//
//  DetailCarHeaderModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct DetailCarHeaderModel: BaseModel {
    public var identifier: String = "DetailCarHeaderCell"
    public let carInfo: CarModel?
    
    init(car: CarModel) {
        self.carInfo = car
    }
}
