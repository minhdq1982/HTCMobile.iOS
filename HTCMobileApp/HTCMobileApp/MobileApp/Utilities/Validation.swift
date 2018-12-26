//
//  Validation.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/28/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

func isValidEmail(_ email: String) -> Bool {
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPredicate.evaluate(with: email)
}

func isValidPhone(_ phone: String)->Bool {
    var isValid: Bool = false
    let charcterSet  = NSCharacterSet(charactersIn: "0123456789").inverted
    let inputString = phone.components(separatedBy: charcterSet)
    let filtered = inputString.joined(separator: "")
    //  If all characters is number
    if phone == filtered {
        if phone.count == 10 {
            let prefix = phone.substring(to: 1)
            if prefix == "0" {
                isValid = true
            }
        }else if phone.count == 11 {
            let prefix = phone.substring(to: 2)
            if prefix == "84" {
                isValid = true
            }
        }
    }
    return isValid
}

func isValidCardId(_ cardId: String) -> Bool {
    let numbersSet = CharacterSet(charactersIn: "0123456789")
    let cardIdSet = CharacterSet(charactersIn: cardId)
    if numbersSet.isSuperset(of: cardIdSet) {
        if cardId.count == 12 {
            return true
        }
    }
    return false
}

func isValidBirthday(_ birthday: String) -> Bool {
    return DateUtils.shared().isValidBirthday(date: birthday)
}

func isValidIdentifier(_ identifier: String) -> Bool {
    //  If all character is number or not
    let numbersSet = CharacterSet(charactersIn: "0123456789")
    let characterSet = CharacterSet(charactersIn: "abcdefjhijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
    let identifySet = CharacterSet(charactersIn: identifier)
    if numbersSet.isSuperset(of: identifySet) {
        if identifier.count == 9 || identifier.count == 12 {
            return true
        }
    }else{
        
        if identifier.count == 8 {
            //  Check the first character
            let firstCharacter = identifier.substring(to: 1)
            let remainCharacter = identifier.substring(from: 1)
            
            if characterSet.isSuperset(of: CharacterSet(charactersIn: firstCharacter))
                && numbersSet.isSuperset(of: CharacterSet(charactersIn: remainCharacter))
            {
                return true
            }
        }
    }
    
    return false
}

func isValidName(_ name: String)->Bool {
    let allowCharacterset = CharacterSet(charactersIn: "0123456789@#$%^&*()-_+=!~,/?'\":;{}[]").inverted
    let charcterSet  = CharacterSet(charactersIn: name)
    return allowCharacterset.isSuperset(of: charcterSet)
}

func isSpecialCharacter(_ name: String)->Bool {
    let allowCharacterset = CharacterSet(charactersIn: "@#$%^&*()-_+=!~,/?'\":;{}[]. ").inverted
    let charcterSet  = CharacterSet(charactersIn: name)
    return allowCharacterset.isSuperset(of: charcterSet)
}
