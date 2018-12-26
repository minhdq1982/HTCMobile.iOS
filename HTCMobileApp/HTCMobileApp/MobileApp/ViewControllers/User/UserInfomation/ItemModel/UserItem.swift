//
//  UserItem.swift
//  HTCMobileApp
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation


enum ItemUserType: String {
    case phone = "phone"
    
    case dateOfBirh = "dateOfBirth"
    
    case CMND = "CMND"
    
    case email = "email"
    
    case address = "address"
}

class UserItem: BaseModel {
    var identifier: String = "UserInforCell"
    var type: String
    var content: String
    
    public func getContent() -> String {
        return content
    }
    public func getType() -> String {
        return type
    }
    
    init(_ type: String, _ content: String) {
        self.type = type
        self.content = content
    }
}
