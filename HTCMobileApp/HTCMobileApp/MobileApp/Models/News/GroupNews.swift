//
//  GroupNews.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct GroupNewsModel: BaseModel {
    public var identifier: String = "ScrollPromotionCell"
    public let id: Int?
    public let name: String?
    public let displayOrder: Int?
    public let items: [NewsModel]?
    
    mutating func setIdentifier(_ identifier: String) {
        self.identifier = identifier
    }
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getName() -> String {
        return name ?? ""
    }
}
extension GroupNewsModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id = try? map.value("id")
        self.name = try? map.value("name")
        self.displayOrder = try? map.value("displayOrder")
        self.items = try? map.value("items")
    }
}
