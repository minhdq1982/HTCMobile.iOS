//
//  DateUtils.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/27/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

class DateUtils {
    
    // MARK: - Properties
    private static var sharedDateUtils: DateUtils = {
        let dateUtils = DateUtils()
        return dateUtils
    }()
    
    // MARK: - Variable
    
    var dateFormatter = DateFormatter()
    var calendar = Calendar(identifier: .gregorian)
    
    // Initialization
    
    private init() {
        setLocale()
    }
    
    fileprivate func setLocale() {
        let languageCode = "vi" //? "vi" : "en-US"
        dateFormatter.locale = Locale(identifier: languageCode)
        dateFormatter.timeZone = TimeZone.current
    }
    
    // MARK: - Accessors
    
    class func shared() -> DateUtils {
        return sharedDateUtils
    }
}

extension DateUtils {
    func string(from date: Date, format: String) -> String {
        setLocale()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from:date)
    }
    
    func displayDate(date: Date) -> String {
        if calendar.isDateInToday(date) {
            return "Hôm nay"
        }else if calendar.isDateInYesterday(date) {
            return "Hôm qua"
        }else {
            return self.string(from: date, format: "dd/MM/yyyy")
        }
    }
    
    func youtubeDate(time: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: time) {
            return date
        }
        return nil
    }
    
    func facebookDate(time: String) -> Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZ"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let date = dateFormatter.date(from: time) {
            return date
        }
        return nil
    }
    
    func creationTimeDisplay(time: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if time.count == 19 {
            if let date = dateFormatter.date(from: time) {
                return displayDate(date: date)
            }
        }else if time.count > 19 {
            let dateText = time.substring(to: 19)
            if let date = dateFormatter.date(from: dateText) {
                return displayDate(date: date)
            }
        }
        
        return ""
    }
    
    func birthDay(from date: String) -> String {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let birthdayDate = dateFormatter.date(from: date) {
            return string(from: birthdayDate, format: "dd/MM/yyyy")
        }else {
            return ""
        }
    }
    
    func isValidBirthday(date: String) -> Bool {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        if let _ =  dateFormatter.date(from: date){
            return true
        }else{
            return false
        }
    }
    
    func getBirthdayForUpdate(date: String) -> String {
        dateFormatter.dateFormat = "dd/MM/yyyy"
        if let updateDate = dateFormatter.date(from: date){
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
            dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
            return dateFormatter.string(from: updateDate)
        }else{
            return ""
        }
    }
    
    func day(from date: Date) -> String {
        return string(from: date, format: "dd")
    }
    
    func monthAndYear(from date: Date) -> String {
        return string(from: date, format: "MM/yyyy")
    }
    
    func dayOfWeek(from date: Date) -> String {
        return string(from: date, format: "EEEE")
    }
}
