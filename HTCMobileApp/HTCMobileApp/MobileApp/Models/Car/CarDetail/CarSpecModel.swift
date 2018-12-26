//
//  CarSpecModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CarSpecModel: BaseModel {
    public var identifier: String = ""
    public let version: CarVersionModel?
    public let details: [CarParamModel]?
    
    init() {
        version = nil
        details = []
    }
}
extension CarSpecModel: ImmutableMappable {
    public init(map: Map) throws {
        self.version = try? map.value("version")
        self.details = try? map.value("details")
    }
}
