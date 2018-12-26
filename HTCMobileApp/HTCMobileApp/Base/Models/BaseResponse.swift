//
//  BaseResponse.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BaseResponse : BaseModel {
    public var identifier: String = ""
    
    public let code: String?
    public let message: String?
    
    public init(code: String,
                message: String) {
        self.code = code
        self.message = message
    }
    
    public func getCode() -> String {
        return code ?? ""
    }
    
    public func getMessage() -> String {
        return message ?? ""
    }
}

extension BaseResponse: ImmutableMappable {
    public init(map: Map) throws {
        code = try? map.value("code",using: JSONInt642StringTransform())
        message = try? map.value("message",using: JSONInt642StringTransform())
    }
}
