//
//  Api+Settings.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/17/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Api {
    public func getSettings() -> RequestProtocol {
        return HTCRequest(function: Constants.getSetting, httpMethod: .get)
    }
}
