//
//  News.swift
//  HTCMobileApp
//
//  Created by admin on 11/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct NewsModel: BaseModel {
    public var identifier: String = "LaterNewsCell"
    public let id: Int?
    public let title: String?
    public let image: String?
    public let shortContent: String?
    public let fullContent: String?
    public let type: Int?
    public let source: String?
    public let creationTime: String?
    public let lastModificationTime: String?
    public let logoType: String?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getImage() -> String {
        return image ?? ""
    }
    
    public func getImageUrl() -> URL? {
        return URL(string: "\(Constants.imageBaseUrl)\(image ?? "")")
    }
    
    public func getShortContent() -> String {
        return shortContent ?? ""
    }
    
    public func getCreationTime() -> String {
        return creationTime ?? ""
    }
    
    public func getCreationTimeDisplay() -> String {
        return DateUtils.shared().creationTimeDisplay(time: getCreationTime())
    }
    
    public func getType() -> Int {
        return type ?? 0
    }
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getFullContent() -> String {
        return fullContent ?? ""
    }
    
    public func getLogoType() -> String {
        return logoType ?? ""
    }
    
    public mutating func setIdentifier(idenfier: String){
        self.identifier = idenfier
    }
    
    init(identifier:String, image: String, title: String, creationTime: String, shortContent: String, type: Int, id: Int, logoType: String) {
        self.id = id
        self.title = title
        self.image = image
        self.shortContent = shortContent
        self.type = type
        self.creationTime = creationTime
        self.lastModificationTime = creationTime
        self.fullContent = "html format"
        self.logoType = logoType
        self.identifier = identifier
        self.source = ""
    }
}
extension NewsModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id = try? map.value("id")
        self.title = try? map.value("title")
        self.image = try? map.value("image")
        self.shortContent = try? map.value("shortContent")
        self.type = try? map.value("type")
        self.creationTime = try? map.value("creationTime")
        self.lastModificationTime = try? map.value("lastModificationTime")
        self.fullContent =  try? map.value("fullContent")
        self.logoType = try? map.value("type")
        self.source = try? map.value("source")
    }
}
