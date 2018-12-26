//
//  Api+TermsOfUse.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
extension Api {
    public func getTermOfUse() -> RequestProtocol {
        return HTCRequest(function: Constants.termOfUse, httpMethod: .get)
    }
}
