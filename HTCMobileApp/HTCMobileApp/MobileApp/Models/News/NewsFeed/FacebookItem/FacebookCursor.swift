//
//  FacebookCursor.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/14/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FacebookCursor: BaseModel {
    public var identifier: String = ""
    public let before: String?
    public let after: String?
}

extension FacebookCursor: ImmutableMappable {
    public init(map: Map) throws {
        self.before          = try? map.value("before")
        self.after           = try? map.value("after")
    }
}
