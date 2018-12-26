//
//  ServiceItem.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct ServiceItem: BaseModel {
    public var identifier: String = "ChooseServiceCollectionViewCell"
    let id: Int?
    let name: String?
    
    public func getName() -> String {
        return name ?? ""
    }
    
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

extension ServiceItem: ImmutableMappable {
    public init(map: Map) throws {
        self.id         = try? map.value("id")
        self.name       = try? map.value("name")
    }
}
