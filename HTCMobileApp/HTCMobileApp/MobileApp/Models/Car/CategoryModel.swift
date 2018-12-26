//
//  CategoryModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CategoryModel: BaseModel {
    public var identifier: String = "CategoryCollectionViewCell"
    public let id: Int?
    public let name: String?
    
    mutating func setIdentifier(_ identifier: String) {
        self.identifier = identifier
    }
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    
    init(name: String) {
        self.id = 0
        self.name = name
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
extension CategoryModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id = try? map.value("id")
        self.name = try? map.value("name")
        
    }
}
