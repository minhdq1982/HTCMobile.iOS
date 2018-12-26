//
//  Api+City.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/28/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Api {
    public func getCities() -> RequestProtocol {
        return HTCRequest(function: Constants.cityList, httpMethod: .get)
    }
}
