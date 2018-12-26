//
//  CityModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CityModel: BaseModel {
    public var identifier: String = ""
    public let name: String?
    public let areaId: Int?
    public let id: Int?
    
    public func getId() -> Int {
        return id ?? -1
    }
    
    public func getAreaId() -> Int {
        return areaId ?? -1
    }
    
    public func getName() -> String {
        return name ?? ""
    }
}

extension CityModel: ImmutableMappable {
    public init(map: Map) throws {
        self.name           = try? map.value("name")
        self.areaId         = try? map.value("areaId")
        self.id             = try? map.value("id")
    }
}
