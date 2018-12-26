//
//  BenefitModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BenefitModel: BaseModel {
    public var identifier: String = "BenefitDetailCardCell"
    public let id: Int?
    public let content: String?
    public let detail: String?
    
    public func getId() -> Int {
        return id ?? 0
    }
    public func getContent() -> String {
        return content ?? ""
    }
    
    public func getDetail() -> String {
        return detail ?? ""
    }
    
    init(identifier: String, id: Int, content: String, detail: String) {
        self.id = id
        self.content = content
        self.detail = detail
        self.identifier = identifier
    }
    
}
extension BenefitModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id = try? map.value("id")
        self.content = try? map.value("content")
        self.detail = try? map.value("detail")
    }
}
