//
//  YoutubeThumb.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
public struct YoutubeThumb: BaseModel {
    public var identifier: String = ""
    public let url: String?
    public let width: Int?
    public let height: Int?
    
    public func getUrl() -> String {
        return url ?? ""
    }
}

extension YoutubeThumb: ImmutableMappable {
    public init(map: Map) throws {
        self.url    = try? map.value("url")
        self.width = try? map.value("width")
        self.height = try? map.value("height")
    }
}
