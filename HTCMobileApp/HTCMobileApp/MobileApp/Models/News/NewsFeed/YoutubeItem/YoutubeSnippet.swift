//
//  YoutubeSnippet.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct YoutubeSnippet: BaseModel {
    public var identifier: String = ""
    public let publishedAt: String?
    public let channelId: String?
    public let title: String?
    public let description: String?
    public let thumbnails: YoutubeThumbnails?
    public let channelTitle: String?
    public let liveBroadcastContent: String?
    public let date: Date?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getDescription() -> String {
        return description ?? ""
    }
    
    public func getPublishTime() -> String {
        return publishedAt ?? ""
    }
    
    public func getDate() -> Date? {
        return date ?? nil
    }
    
    public func getPublishDateDisplay() -> String {
        if let date = self.date {
            return DateUtils.shared().displayDate(date: date)
        }
        return ""
    }
    
    public func getImageUrl() -> String {
        if let tbs = thumbnails, let thumb = tbs.high {
            return thumb.getUrl()
        }
        return ""
    }
}

extension YoutubeSnippet: ImmutableMappable {
    public init(map: Map) throws {
        self.publishedAt        = try? map.value("publishedAt")
        self.channelId          = try? map.value("channelId")
        self.title              = try? map.value("title")
        self.description        = try? map.value("description")
        self.thumbnails         = try? map.value("thumbnails")
        self.channelTitle       = try? map.value("channelTitle")
        self.liveBroadcastContent    = try? map.value("liveBroadcastContent")
        self.date               = DateUtils.shared().youtubeDate(time: self.publishedAt ?? "")
    }
}
