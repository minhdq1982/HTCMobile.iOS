//
//  HistoryPointListModel.swift
//  HTCMobileApp
//
//  Created by admin on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct HistoryPointListModel: BaseModel {
    public var identifier: String = ""
    public let totalCount: Int?
    public let items: [HistoryPointModel]?
}

extension HistoryPointListModel: ImmutableMappable {
    public init(map: Map) throws {
        self.totalCount         = try? map.value("totalCount")
        self.items              = try? map.value("items")
    }
}
