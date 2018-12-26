//
//  FacebookPaging.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/14/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FacebookPaging: BaseModel {
    public var identifier: String = ""
    public let cursors: FacebookCursor?
    public let next: String?
    
    public func getAfter() -> String {
        if let cs = cursors {
            return cs.after ?? ""
        }
        return ""
    }
    
}

extension FacebookPaging: ImmutableMappable {
    public init(map: Map) throws {
        self.cursors            = try? map.value("cursors")
        self.next               = try? map.value("next")
    }
}
