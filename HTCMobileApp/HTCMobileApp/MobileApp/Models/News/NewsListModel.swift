//
//  NewsListModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct NewsListModel: BaseModel {
    public var identifier: String = ""
    public let totalCount: Int?
    public let items: [NewsModel]?
}

extension NewsListModel: ImmutableMappable {
    public init(map: Map) throws {
        self.totalCount         = try? map.value("totalCount")
        self.items              = try? map.value("items")
    }
}
