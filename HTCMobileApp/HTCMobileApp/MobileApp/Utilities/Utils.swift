//
//  Utils.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

//MARK: AppDelegate instance

let appDelegate = UIApplication.shared.delegate as! AppDelegate

let windowAppDelegate = appDelegate.window!

//MARK: App version

let appName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as! String
let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as! String
let buildVersion = Bundle.main.infoDictionary?["CFBundleVersion"] as! String
let bundleIdentifier = Bundle.main.infoDictionary?["CFBundleIdentifier"] as! String

func colorFromHex(_ hexString: String) -> UIColor {
    let color = UIColor(hexString: hexString)
    return color
}

func callPhoneNumber(_ phone: String) {
    let phoneLink = "tel://\(phone)"
    if let url = URL(string: phoneLink) {
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
    }
}
