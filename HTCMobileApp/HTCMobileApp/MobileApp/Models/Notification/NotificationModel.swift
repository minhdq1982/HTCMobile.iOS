//
//  NotificationModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct NotificationModel: BaseModel {
    public var identifier: String = "NotificationCollectionViewCell"
    public let id: Int?
    public let image: String?
    public let title: String?
    public let shortContent: String?
    public let fullContent: String?
    public let read: Bool?
    public let type: Int?
    public let detailId: Int?
    public let createdDate: String?
    public let modifiedDate: String?
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getImage() -> String {
        return image ?? ""
    }
    
    public func getShortContent() -> String {
        return shortContent ?? ""
    }
    public func getFullContent() -> String {
        return fullContent ?? ""
    }
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getRead() -> Bool {
        return read ?? false
    }
    
    
    public func getDetailId() -> Int {
        return detailId ?? 0
    }
    
    public func getType() -> Int {
        return type ?? 0
    }
    
    public func getCreatedDate() -> String {
        return createdDate ?? ""
    }
    public func getModifiedDate() -> String {
        return modifiedDate ?? ""
    }
   
    
    init(id: Int, image: String, title: String, shortContent: String, fullContent: String, read: Bool, type: Int, detailId: Int, createdDate: String, modifiedDate: String) {
        self.id = id
        self.image = image
        self.title = title
        self.shortContent = shortContent
        self.fullContent = fullContent
        self.read = read
        self.type = type
        self.detailId = detailId
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
    }
    
}
extension NotificationModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id = try? map.value("id")
        self.image = try? map.value("image")
        self.title = try? map.value("title")
        self.shortContent = try? map.value("shortContent")
        self.fullContent = try? map.value("fullContent")
        self.read = try? map.value("read")
        self.type = try? map.value("type")
        self.detailId = try? map.value("detailId")
        self.createdDate = try? map.value("createdDate")
        self.modifiedDate = try? map.value("modifiedDate")
    }
}
