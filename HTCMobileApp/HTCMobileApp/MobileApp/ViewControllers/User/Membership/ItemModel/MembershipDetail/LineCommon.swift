//
//  LineCommon.swift
//  HTCMobileApp
//
//  Created by admin on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct LineCommon: BaseModel{
    public var identifier: String = "LineDetailCell"
    public var title: String?
    public var content: String?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getContent() -> String {
        return content ?? ""
    }
    
    init(title: String, content: String) {
        self.content = content
        self.title = title
    }
    
}
