//
//  YoutubeId.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct YoutubeId: BaseModel {
    public var identifier: String = ""
    public let kind: String?
    public let videoId: String?
    
    public func getVideoId() -> String {
        return videoId ?? ""
    }
}

extension YoutubeId: ImmutableMappable {
    public init(map: Map) throws {
        self.kind    = try? map.value("kind")
        self.videoId = try? map.value("videoId")
    }
}
