//
//  Section.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxDataSources

public struct Section : BaseModel {
    public var identifier: String = ""
    
    public var header: String
    public var items: [BaseModel]
}

extension Section : SectionModelType {
    public typealias Item = BaseModel
    
    public var identity: String {
        return header
    }
    
    public init(original: Section, items: [Item]) {
        self = original
        self.items = items
    }
    
    public init(header:String,items:[Item])
    {
        self.header = header
        self.items = items
    }
}
