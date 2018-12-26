//
//  FacebookRequest.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
struct FacebookRequest: RequestProtocol {
    
    private var httpMethod:HttpMethod = .get
    private var getParams:String = ""
    private var contentType:String = ""
    
    func getId() -> String {
        return ""
    }
    
    public mutating func setBodyData(_ data: Data) {
        print(data)
    }
    
    public  func getRequest() -> URLRequest {
        print(Api.default.getFacebookUrl())
        var urlString = Api.default.getFacebookUrl()
        if httpMethod == .get && !getParams.isEmpty {
            urlString.append("?\(getParams)")
        }
        print("Request URL: \(urlString)")
        var urlRequest = URLRequest(url: URL(string:urlString)!)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        return urlRequest
    }
    
    public init(httpMethod:HttpMethod = .get, contentType: String = "application/json", getParams: String = "") {
        self.httpMethod = httpMethod
        self.contentType = contentType
        self.getParams = getParams
    }
}
