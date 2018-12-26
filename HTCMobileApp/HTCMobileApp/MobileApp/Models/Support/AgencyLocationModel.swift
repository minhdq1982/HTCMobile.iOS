//
//  AgencyLocationModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
import MapKit

public struct AgencyLocationModel: BaseModel {
    public var identifier: String = "AgencyListCell"
    let code: String?
    let name: String?
    let cityId: Int?
    let cityName: String?
    let hotline: String?
    let latitude: Double?
    let longitude: Double?
    let image: String?
    let email: String?
    let website: String?
    let detail: String?
    let phone: String?
    let address: String?
    let display: Bool?
    let isActive: Bool?
    let hotlineSale: String?
    let hotlineService: String?
    let id: Int?
    
    public func getAgencyId() -> Int {
        return id ?? 0
    }
    public func getDisplay() -> Bool {
        return display ?? false
    }
    
    public func getEmail() -> String {
        return email ?? ""
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    
    public func getAddress() -> String {
        return address ?? ""
    }
    
    public func getPhoneNumber() -> String {
        return phone ?? ""
    }
    
    public func getWebsite() -> String {
        return website ?? ""
    }
    
    public func getLatitude() -> Double {
        return latitude ?? 0
    }
    
    public func getLongitude() -> Double {
        return longitude ?? 0
    }
    
    public func getHotline() -> String {
        return hotline ?? ""
    }
    
    public func getHotlineSale() -> String {
        return hotlineSale ?? ""
    }
    
    public func getHotlineService() -> String {
        return hotlineService ?? ""
    }
    
    public func getLocation() -> CLLocation {
        return CLLocation(latitude: self.getLatitude(), longitude: self.getLongitude())
    }
    
    init(name: String, address:String, phone: String, website: String, lat: Double, long: Double) {
        self.cityId = 0
        self.cityName = ""
        self.code = ""
        self.address = address
        self.phone = phone
        self.hotline = ""
        self.website = website
        self.image = ""
        self.longitude = long
        self.latitude = lat
        self.display = true
        self.name = name
        self.detail = ""
        self.isActive = true
        self.id = 0
        self.email = ""
        self.hotlineSale = ""
        self.hotlineService = ""
    }
}

extension AgencyLocationModel: ImmutableMappable {
    public init(map: Map) throws {
        self.code               = try? map.value("code")
        self.name               = try? map.value("name")
        self.cityId             = try? map.value("cityId")
        self.cityName           = try? map.value("cityName")
        self.hotline            = try? map.value("hotline")
        self.latitude           = try? map.value("latitude")
        self.longitude          = try? map.value("longitude")
        self.image              = try? map.value("image")
        self.website            = try? map.value("website")
        self.detail             = try? map.value("detail")
        self.phone              = try? map.value("phone")
        self.address            = try? map.value("address")
        self.display            = try? map.value("display")
        self.isActive           = try? map.value("isActive")
        self.id                 = try? map.value("id")
        self.email              = try? map.value("email")
        self.hotlineSale        = try? map.value("hotlineSale")
        self.hotlineService     = try? map.value("hotlineService")
    }
}
