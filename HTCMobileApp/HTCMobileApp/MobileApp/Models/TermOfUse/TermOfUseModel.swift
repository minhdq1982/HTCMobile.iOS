//
//  TermOfUseModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct TermOfUseModel: BaseModel {
    public var identifier: String = ""
    public let content: String?
}

extension TermOfUseModel: ImmutableMappable {
    public init(map: Map) throws {
        self.content         = try? map.value("content")
    }
}
