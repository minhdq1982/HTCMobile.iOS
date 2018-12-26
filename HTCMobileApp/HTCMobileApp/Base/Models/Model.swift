//
//  Model.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct Model : BaseModel {
    public var identifier: String = ""
    
    public init(identifier : String){
        self.identifier = identifier
    }
}
