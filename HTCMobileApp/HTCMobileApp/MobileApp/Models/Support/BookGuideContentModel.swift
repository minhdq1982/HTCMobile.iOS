//
//  BookGuideContentModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BookGuideContentModel: BaseModel {
    public var identifier: String = ""
    let title: String?
    let content: String?
    let orderNumber: Int?
    let parentId: Int?
    let guideBookId: Int?
    let isActive: Bool?
    let childs: String?
    let id: Int?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getContent() -> String {
        return content ?? ""
    }
    
    public func isParrent() -> Bool {
        return (parentId != nil && parentId == 0)
    }
}

extension BookGuideContentModel: ImmutableMappable {
    public init(map: Map) throws {
        self.title              = try? map.value("title")
        self.content            = try? map.value("content")
        self.orderNumber        = try? map.value("orderNumber")
        self.parentId           = try? map.value("parentId")
        self.guideBookId        = try? map.value("guideBookId")
        self.isActive           = try? map.value("isActive")
        self.childs             = try? map.value("childs")
        self.id                 = try? map.value("id")
    }
}
