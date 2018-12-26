//
//  Request.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
public struct Request : RequestProtocol {
    public func getId() -> String {
        return ""
    }
    
    var urlRequest: URLRequest
    public  mutating func setBodyData(_ data: Data) {
        self.urlRequest.httpBody = data
    }
    
    public  func getRequest() -> URLRequest {
        return self.urlRequest
    }
    
    
    public init(urlRequest : URLRequest) {
        self.urlRequest = urlRequest
    }
}

public protocol RequestProtocol {
    func getRequest()-> URLRequest
    func getId()-> String
    mutating func setBodyData(_ data:Data)
}
