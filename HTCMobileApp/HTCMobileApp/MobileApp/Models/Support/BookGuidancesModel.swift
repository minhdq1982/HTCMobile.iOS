//
//  BookGuidancesModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BookGuidancesModel: BaseModel {
    public var identifier: String = ""
    public let totalCount: Int?
    public let items: [BookGuidanceModel]?
}

extension BookGuidancesModel: ImmutableMappable {
    public init(map: Map) throws {
        self.totalCount         = try? map.value("totalCount")
        self.items              = try? map.value("items")
    }
}
