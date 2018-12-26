//
//  ParamItem.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct ParamItem: BaseModel {
    public var identifier: String = ""
    public let name: String?
    public let value: String?
    public let type: Int?
}

extension ParamItem: ImmutableMappable {
    public init(map: Map) throws {
        self.name       = try? map.value("name")
        self.value      = try? map.value("value")
        self.type       = try? map.value("type")
    }
}
