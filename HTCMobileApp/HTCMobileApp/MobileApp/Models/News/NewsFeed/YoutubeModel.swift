//
//  YoutubeModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct YoutubeModel: BaseModel {
    public var identifier: String = ""
    public let kind: String?
    public let etag: String?
    public let nextPageToken: String?
    public let regionCode: String?
    public let pageInfo: PageInfo?
    public let items: [YoutubeItem]?
    
    public func getNextPageToken() -> String {
        return nextPageToken ?? ""
    }
}

extension YoutubeModel: ImmutableMappable {
    public init(map: Map) throws {
        
        self.kind = try? map.value("kind")
        self.etag = try? map.value("etag")
        self.nextPageToken = try? map.value("nextPageToken")
        self.regionCode = try? map.value("regionCode")
        self.pageInfo = try? map.value("pageInfo")
        self.items = try? map.value("items")
    }
}
