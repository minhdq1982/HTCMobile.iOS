//
//  IntExtension.swift
//  HTCMobileApp
//
//  Created by admin on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Int {
    func convertToDate() -> Date {
        return Date(timeIntervalSince1970: Double(self))
    }
    
    func convertToDateString() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "dd/MM/yyyy"
        return formater.string(from: convertToDate())
    }
    
    func convertToDateFormater() -> String {
        let formater = DateFormatter()
        formater.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formater.string(from: convertToDate())
    }
    
    func convertToDateString(format: String) -> String {
        let formater = DateFormatter()
        formater.dateFormat = format
        return formater.string(from: convertToDate())
    }
    
    func getDay() -> String{
        let formater = DateFormatter()
        formater.dateFormat = "dd"
        return formater.string(from: convertToDate())
    }
    func getMonth() -> String{
        let formater = DateFormatter()
        formater.dateFormat = "MM"
        return formater.string(from: convertToDate())
    }
    func getYear() -> String{
        let formater = DateFormatter()
        formater.dateFormat = "yyyy"
        return formater.string(from: convertToDate())
    }
    
}
