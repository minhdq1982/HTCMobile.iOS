//
//  Api+Agency.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

extension Api {
    public func getAgenciesList() -> RequestProtocol {
        return HTCRequest(function: Constants.agencyList, httpMethod: .get)
    }
    
    public func getAgenciesNearBy(latitude: Double, longgitude: Double, type: Int) -> RequestProtocol {
        let params = "_lat=\(latitude)&_long=\(longgitude)&type=\(type)"
        return HTCRequest(function: Constants.agencyNearBy, httpMethod: .get, getParams: params)
    }
    
    public func getListByCity(agencyName: String, cityId: Int, latitude: Double, longgitude: Double, type: Int) -> RequestProtocol {
        var params = ""
        if agencyName.isEmpty {
            if cityId != -1 {
                params = "cityId=\(cityId)&_lat=\(latitude)&_long=\(longgitude)&type=\(type)"
            }
        }else {
            if let name = agencyName.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) {
                if cityId != -1 {
                    params = "name=\(name)&cityId=\(cityId)&_lat=\(latitude)&_long=\(longgitude)&type=\(type)"
                }else{
                    params = "name=\(name)&_lat=\(latitude)&_long=\(longgitude)&type=\(type)"
                }
            }
        }
        
        return HTCRequest(function: Constants.agencyGetListByCity, httpMethod: .get, getParams: params)
    }
}

