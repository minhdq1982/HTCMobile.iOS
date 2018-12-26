//
//  FacebookModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/14/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FacebookModel: BaseModel {
    public var identifier: String = ""
    public let paging: FacebookPaging?
    public let items: [FacebookItem]?
    
    public func getAfter() -> String {
        if let p = self.paging {
            return p.getAfter()
        }
        return ""
    }
}

extension FacebookModel: ImmutableMappable {
    public init(map: Map) throws {
        self.paging = try? map.value("paging")
        self.items = try? map.value("data")
    }
}
