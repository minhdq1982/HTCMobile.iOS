//
//  ItemsResponse.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
public struct ItemsResponse<T:ImmutableMappable>  {
    public let code: String?
    public let message: String?
    public let data: [T]?
    
    public init(code: String,
                message: String,
                data: [T]) {
        self.code = code
        self.data = data
        self.message = message
    }
    
    public func getCode() -> String {
        return self.code ?? ""
    }
    
    public func getMessage() -> String {
        return self.message ?? ""
    }
}

extension ItemsResponse: ImmutableMappable {
    public init(map: Map) throws {
        code = try? map.value("code",using: JSONInt642StringTransform())
        message = try? map.value("message")
        data = try? map.value("data")
    }
}
