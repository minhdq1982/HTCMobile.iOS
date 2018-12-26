//
//  CarVersionModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CarVersionModel: BaseModel {
    public var identifier: String = "CarVersionCell"
    public let name: String?
    public let type: Int?
    
    public func getName() -> String {
        return name ?? ""
    }
    
    init(name: String) {
        self.name = name
        self.type = 0
    }
}
extension CarVersionModel: ImmutableMappable {
    public init(map: Map) throws {
        self.name = try? map.value("name")
        self.type = try? map.value("type")
        
    }
}
