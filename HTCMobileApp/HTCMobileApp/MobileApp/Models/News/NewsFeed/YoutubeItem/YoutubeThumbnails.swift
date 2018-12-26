//
//  YoutubeThumbnails.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
public struct YoutubeThumbnails: BaseModel {
    public var identifier: String = ""
    public let normal: YoutubeThumb?
    public let medium: YoutubeThumb?
    public let high: YoutubeThumb?
}

extension YoutubeThumbnails: ImmutableMappable {
    public init(map: Map) throws {
        self.normal     = try? map.value("default")
        self.medium     = try? map.value("medium")
        self.high       = try? map.value("high")
    }
}
