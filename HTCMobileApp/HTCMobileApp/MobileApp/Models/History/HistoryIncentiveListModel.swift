//
//  HistoryIncentiveListModel.swift
//  HTCMobileApp
//
//  Created by admin on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

import Foundation
import ObjectMapper

public struct HistoryIncentiveListModel: BaseModel {
    public var identifier: String = ""
    public let totalCount: Int?
    public let items: [HistoryIncentiveModel]?
}

extension HistoryIncentiveListModel: ImmutableMappable {
    public init(map: Map) throws {
        self.totalCount         = try? map.value("totalCount")
        self.items              = try? map.value("items")
    }
}
