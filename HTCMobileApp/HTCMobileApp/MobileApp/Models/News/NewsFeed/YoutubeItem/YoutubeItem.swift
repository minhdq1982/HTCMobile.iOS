//
//  YoutubeItem.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct YoutubeItem: BaseModel {
    public var identifier: String = LaterNewsCell.identifier
    public let kind: String?
    public let etag: String?
    public let id: YoutubeId?
    public let snippet: YoutubeSnippet?
    
    public mutating func setIdentifier(idenfier: String){
        self.identifier = idenfier
    }
    
    public func getVideoId() -> String {
        if let youtubeId = id {
            return youtubeId.getVideoId()
        }
        return ""
    }
    
    public func getTitle() -> String {
        if let sn = snippet {
            return sn.getTitle()
        }
        return ""
    }
    
    public func getImageUrl() -> URL? {
        if let sn = snippet {
            return URL(string: sn.getImageUrl())
        }
        return nil
    }
    
    public func getShortContent() -> String {
        if let sn = snippet {
            return sn.getDescription()
        }
        return ""
    }
    
    public func getDate() -> Date? {
        if let sn = snippet {
            return sn.getDate()
        }
        return nil
    }
    
    public func getCreationTimeDisplay() -> String {
        if let sn = snippet {
            return sn.getPublishDateDisplay()
        }
        return ""
    }
}

extension YoutubeItem: ImmutableMappable {
    public init(map: Map) throws {
        self.kind       = try? map.value("kind")
        self.etag       = try? map.value("etag")
        self.id         = try? map.value("id")
        self.snippet    = try? map.value("snippet")
    }
}
