//
//  BookGuidanceModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct BookGuidanceModel: BaseModel {
    public var identifier: String = "BookGuidanceCollectionCell"
    
    let carId: Int?
    let carName: String?
    let title: String?
    let orderNumber: Int?
    let isActive: Bool?
    let lastModificationTime: String?
    let image: String?
    let id: Int?
    
    //  Detail info addition
    let contents: [BookGuideContentModel]?
    
    public func getTitle() -> String {
        return title ?? ""
    }
    
    public func getName() -> String {
        return carName ?? ""
    }
    
    public func getModifiedTime() -> String {
        return lastModificationTime ?? ""
    }
    
    public func getBgImageNameAtIndex(_ index: Int) -> String {
        var retValue = "book1"
        switch (index % 7) {
        case 0:
            retValue = "book1"
        case 1:
            retValue = "book2"
        case 2:
            retValue = "book3"
        case 3:
            retValue = "book4"
        case 4:
            retValue = "book5"
        case 5:
            retValue = "book6"
        case 6:
            retValue = "book7"
        default:
            retValue = "book1"
        }
        print("book image name: \(retValue)")
        return retValue
    }
    
    public func getCarImageUrl() -> URL? {
        return URL(string: "\(Constants.imageBaseUrl)\(id ?? 0)")
    }
    
    init() {
        self.carId             = 0
        self.carName           = ""
        self.title              = ""
        self.orderNumber        = 0
        self.isActive           = true
        self.lastModificationTime    = ""
        self.image              = ""
        self.id                 = 0
        self.contents           = []
    }
}

extension BookGuidanceModel: ImmutableMappable {
    public init(map: Map) throws {
        self.carId             = try? map.value("carId")
        self.carName           = try? map.value("carName")
        self.title              = try? map.value("title")
        self.orderNumber        = try? map.value("orderNumber")
        self.isActive           = try? map.value("isActive")
        self.lastModificationTime    = try? map.value("lastModificationTime")
        self.image              = try? map.value("image")
        self.id                 = try? map.value("id")
        self.contents           = try? map.value("contents")
        
    }
}
