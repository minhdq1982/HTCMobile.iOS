//
//  Dictionary.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
extension Dictionary where Key == String {
    public func  toJsonString() ->String {
        return String(data: try! JSONSerialization.data(withJSONObject: self), encoding: String.Encoding.utf8)!
    }
}
