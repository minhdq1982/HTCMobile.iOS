//
//  NetworkConnectivity.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import Alamofire

open class NetworkConnectivity {
    public class var isConnectedToInternet:Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
