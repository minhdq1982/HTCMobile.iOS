//
//  DateExtension.swift
//  HTCMobileApp
//
//  Created by admin on 11/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Date {
    func convertToString() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy"
        return formater.string(from: self)
            .replacingOccurrences(of: "AM", with: "SA")
            .replacingOccurrences(of: "PM", with: "CH")
    }
}
