//
//  Api+Car.swift
//  HTCMobileApp
//
//  Created by admin on 11/27/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Api {
    public func getCarsList() -> RequestProtocol {
        return HTCRequest(function: Constants.carList, httpMethod: .get)
    }
}
