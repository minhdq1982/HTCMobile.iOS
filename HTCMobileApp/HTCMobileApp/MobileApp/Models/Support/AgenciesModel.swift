//
//  AgenciesModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct AgenciesModel: BaseModel {
    public var identifier: String = ""
    
    let totalCount: Int?
    let items: [AgencyLocationModel]?
    
    init() {
        self.totalCount = 0
        self.items = []
    }
}

extension AgenciesModel: ImmutableMappable {
    public init(map: Map) throws {
        self.totalCount         = try? map.value("totalCount")
        self.items              = try? map.value("items")
    }
}
