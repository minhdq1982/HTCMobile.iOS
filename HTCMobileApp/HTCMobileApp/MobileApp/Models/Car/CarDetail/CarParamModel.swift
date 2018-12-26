//
//  CarParamModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CarParamModel: BaseModel {
    public var identifier: String = ""
    public let id: Int?
    public let name: String?
    public let items: [ParamItem]?
}

extension CarParamModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id         = try? map.value("id")
        self.name       = try? map.value("name")
        self.items      = try? map.value("items")
    }
}
