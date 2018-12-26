//
//  ContentMenuModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct ContentMenuModel: BaseModel {
    public var identifier: String = "ContentCell"
    public let title: String?
    public let isParrent: Bool?
    
    public func getTitle() -> String{
        return title ?? ""
    }
    
    public func getIsParrent() -> Bool{
        return isParrent ?? false
    }
    
    init(title: String, isParrent: Bool) {
        self.title = title
        self.isParrent = isParrent
    }
}
