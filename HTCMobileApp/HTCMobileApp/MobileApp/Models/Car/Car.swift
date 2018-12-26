//
//  Car.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CarModel: BaseModel {
    
    public var identifier: String = "CarCollectionViewCell"
    public let id: Int?
    public let categoryId: Int?
    public let name: String?
    public let slogan: String?
    public let shortDescription: String?
    public let image: [String]?
    public let price: Int?
    public let unit: String?
    
    //  Addition detail info
    public let highlights: String?
    public let exterior: String?
    public let furniture: String?
    public let operation: String?
    public let safe: String?
    public let convenient: String?
    public let catalog: String?
    public let specs:[CarSpecModel]?
    
    public func getHighlights() -> String {
        return highlights ?? ""
    }
    
    public func getExterior() -> String {
        return exterior ?? ""
    }
    
    public func getFurniture() -> String {
        return furniture ?? ""
    }
    
    public func getOperation() -> String {
        return operation ?? ""
    }
    
    public func getSafe() -> String {
        return safe ?? ""
    }
    
    public func getConvenient() -> String {
        return convenient ?? ""
    }
    
    public func getCatalog() -> String {
        return catalog ?? ""
    }
    
    public func getId() -> Int {
        return id ?? 0
    }
    public func getcategoryId() -> Int {
        return categoryId ?? 0
    }
    public func getName() -> String {
        return name ?? ""
    }
    public func getSlogan() -> String {
        return slogan ?? ""
    }
    public func getShortDescription() -> String {
        return shortDescription ?? ""
    }
    public func getImage() -> [String] {
        return image ?? []
    }
    public func getCarUrl() -> URL? {
        let images = getImage()
        if images.count > 0 {
            return URL(string: "\(Constants.imageBaseUrl)\(images[0])")
        }
        return nil
    }
    
    public func getPrice() -> String {
        return slogan ?? ""
    }
    public func getUnit() -> String {
        return shortDescription ?? ""
    }
    
    public func getVersions() -> [CarVersionModel] {
        var versions: [CarVersionModel] = []
        if let s = specs, s.count > 0 {
            for spec in s {
                if let version = spec.version {
                    versions.append(version)
                }
            }
        }
        return versions
    }
    
    init(id: Int, categoryId: Int, name: String, slogan: String, shortDescription: String, image: [String], price: Int, unit: String) {
        self.id = id
        self.categoryId = categoryId
        self.name = name
        self.slogan = slogan
        self.shortDescription = shortDescription
        self.image = image
        self.price = price
        self.unit = unit
        
        self.highlights = ""
        self.exterior = ""
        self.furniture = ""
        self.operation = ""
        self.safe = ""
        self.convenient = ""
        self.catalog = ""
        self.specs = []
    }
}
extension CarModel: ImmutableMappable {
    public init(map: Map) throws {
        self.id                 = try? map.value("id")
        self.categoryId         = try? map.value("categoryId")
        self.name               = try? map.value("name")
        self.slogan             = try? map.value("slogan")
        self.shortDescription  = try? map.value("shortDescription")
        self.image              = try? map.value("images")
        self.price              = try? map.value("price")
        self.unit               = try? map.value("unit")
        
        //  Addition detail info
        self.highlights         = try? map.value("highlights")
        self.exterior           = try? map.value("exterior")
        self.furniture          = try? map.value("furniture")
        self.operation          = try? map.value("operation")
        self.safe               = try? map.value("safe")
        self.convenient         = try? map.value("convenient")
        self.catalog            = try? map.value("catalog")
        self.specs              = try? map.value("specs")
    }
}
