//
//  FacebookPrivacy.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FacebookPrivacy: BaseModel {
    public var identifier: String = ""
    public let allow: String?
    public let deny: String?
    public let description: String?
    public let friends: String?
    public let value: String?
}

extension FacebookPrivacy: ImmutableMappable {
    public init(map: Map) throws {
        self.allow          = try? map.value("allow")
        self.deny           = try? map.value("deny")
        self.description    = try? map.value("description")
        self.friends        = try? map.value("friends")
        self.value          = try? map.value("value")
    }
}
