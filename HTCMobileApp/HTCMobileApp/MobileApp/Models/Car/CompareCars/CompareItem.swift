//
//  CompareItem.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/16/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct CompareItem: BaseModel {
    public var identifier: String = "MetricsCompareCollectionViewCell"
    public let value1: String?
    public let value2: String?
    
    public func getValue1() -> String {
        return value1 ?? ""
    }
    
    public func getValue2() -> String {
        return value2 ?? ""
    }
    
    init(value1: String, value2: String) {
        self.value1 = value1
        self.value2 = value2
    }
}
