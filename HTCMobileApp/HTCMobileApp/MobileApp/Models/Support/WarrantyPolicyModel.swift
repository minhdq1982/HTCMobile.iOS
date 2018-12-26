//
//  WarrantyPolicyModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct WarrantyPolicyModel: BaseModel {
    public var identifier: String = "WarrantyPolicyCell"
    
    let id: Int?
    let name: String?
    let content: String?
    let createdDate: String?
    let modifiedDate: String?
    
    mutating func setIdentifier(_ identifier: String) {
        self.identifier = identifier
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    
    public func getContent() -> String {
        return content ?? ""
    }
    
    init(name: String) {
        self.id = 0
        self.name = name
        self.content = ""
        self.createdDate = ""
        self.modifiedDate = ""
    }
}

extension WarrantyPolicyModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id             = try? map.value("id")
        self.name           = try? map.value("name")
        self.content        = try? map.value("content")
        self.createdDate    = try? map.value("createdDate")
        self.modifiedDate   = try? map.value("modifiedDate")
    }
}
