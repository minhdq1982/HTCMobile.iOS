//
//  BaseModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
public protocol BaseModel{
    var identifier: String {get set}
}

extension BaseModel {
    public func withIdentifier(_ identifier:String) -> Self {
        var value = self
        value.identifier = identifier
        return value
    }
}
