//
//  PageInfo.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct PageInfo: BaseModel {
    public var identifier: String = ""
    public let totalResults: Int?
    public let resultsPerPage: Int?
}

extension PageInfo: ImmutableMappable {
    public init(map: Map) throws {
        self.totalResults   = try? map.value("totalResults")
        self.resultsPerPage = try? map.value("resultsPerPage")
    }
}
