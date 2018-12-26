//
//  GroupNewsHeaderModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct GroupNewsHeaderModel: BaseModel {
    public var identifier: String = "HomeHeaderViewCell"
    public let id: Int?
    public let name: String?
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
