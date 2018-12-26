//
//  VerifyModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct VerifyModel: BaseModel {
    public var identifier: String = ""
    public let user: User?
    
    init(user: User) {
        self.user = user
    }
}
extension VerifyModel: ImmutableMappable {
    public init(map: Map) throws {
         self.user        = try? map.value("data")
    }
    
}
