//
//  TypeQuestionEnum.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

enum TypeQuestionEnum: String {
    case EMAIL
    
    case FULL_NAME
    
    case PHONE
    
    case TEXT
    
    case TEXT_AREA
    
    case SPINNER
    
    case DATE
    
    case LEVEL
    
    case RADIO
    
    case CHECKBOX
    
    func typeValue() -> String {
        return self.rawValue
    }
}
