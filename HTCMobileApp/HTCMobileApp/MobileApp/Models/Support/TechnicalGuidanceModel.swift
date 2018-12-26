//
//  TechnicalGuidanceModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct TechnicalGuidanceModel: BaseModel {
    public var identifier: String = "TechnicalGuidanceCommonCell"
    
    let id: Int?
    let title: String?
    let image: String?
    let shortContent: String?
    let content: String?
    let isActive: Bool?
    let orderNumber: Int?
    let creationTime: String?
    let lastModificationTime: String?
    
    mutating func setIdentifier(_ identifier: String) {
        self.identifier = identifier
    }
    
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getImageName() -> String{
        return image ?? ""
    }
    
    public func getImageUrl() -> URL? {
        return URL(string: "\(Constants.imageBaseUrl)\(image ?? "")")
    }
    
    public func getCreationTime() -> String {
        return creationTime ?? ""
    }
    
    public func getLastModifiedTime() -> String {
        return lastModificationTime ?? ""
    }
    
    public func getCreationTimeDisplay() -> String {
        return DateUtils.shared().creationTimeDisplay(time: getCreationTime())
    }
    
    public func getLastModifedTimeDisplay() -> String {
        return DateUtils.shared().creationTimeDisplay(time: getLastModifiedTime())
    }
    
    public func getShortContent() -> String {
        return shortContent ?? ""
    }
    
    public func getContent() -> String {
        return content ?? ""
    }
    
    init(title: String, creationTime: String, shortContent: String, image: String) {
        self.id = 0
        self.title = title
        self.image = image
        self.shortContent = shortContent
        self.content = ""
        self.isActive = true
        self.orderNumber = 0
        self.creationTime = creationTime
        self.lastModificationTime = ""
    }
}

extension TechnicalGuidanceModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id             = try? map.value("id")
        self.title          = try? map.value("title")
        self.image          = try? map.value("image")
        self.shortContent   = try? map.value("shortContent")
        self.content        = try? map.value("content")
        self.isActive       = try? map.value("isActive")
        self.orderNumber    = try? map.value("orderNumber")
        self.creationTime   = try? map.value("creationTime")
        self.lastModificationTime   = try? map.value("lastModificationTime")
    }
}
