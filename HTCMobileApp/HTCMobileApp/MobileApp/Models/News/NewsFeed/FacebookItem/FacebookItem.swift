//
//  FacebookItem.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct FacebookItem: BaseModel {
    public var identifier: String = LaterNewsCell.identifier
    public let full_picture: String?
    public let message: String?
    public let created_time: String?
    public let link: String?
    public let privacy: FacebookPrivacy?
    public let id: String?
    public let date: Date?
    
    public func getTitle() -> String {
        return ""
    }
    
    public func getImageUrl() -> URL? {
        if let image = full_picture {
            return URL(string: image)
        }
        return nil
    }
    
    public func getShortContent() -> String {
        return message ?? ""
    }
    
    public func getDate() -> Date? {
        return date ?? nil
    }
    
    public func getCreationTimeDisplay() -> String {
        if let date = self.date {
            return DateUtils.shared().displayDate(date: date)
        }
        return ""
    }
    
    public func getFacebookUrl() -> URL? {
        return URL(string: "https://www.facebook.com/\(id ?? "")")
    }
    
    public mutating func setIdentifier(idenfier: String){
        self.identifier = idenfier
    }
}

extension FacebookItem: ImmutableMappable {
    public init(map: Map) throws {
        self.full_picture   = try? map.value("full_picture")
        self.message        = try? map.value("message")
        self.created_time   = try? map.value("created_time")
        self.link           = try? map.value("link")
        self.privacy        = try? map.value("privacy")
        self.id             = try? map.value("id")
        self.date           = DateUtils.shared().facebookDate(time: self.created_time ?? "")
    }
}
