//
//  User.swift
//  HTCMobileApp
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct User: BaseModel {
    public var identifier: String = ""
    public let accessToken: String?
    public let encryptedAccessToken: String?
    public let expireInSeconds: Int?
    public let id: Int?
    public let name: String?
    public let surname: String?
    public let avatar: String?
    public let phone: String?
    public let birthday: String?
    public let email: String?
    public let address: String?
    public let identifyCard: String?
    public let isActive: Bool?
    public let desctiption: String?
    
    public let isDeleted: Bool?
    public let deleterUserId: Int?
    public let deletionTime: String?
    public let lastModificationTime: String?
    public let lastModifierUserId: Int?
    public let creationTime: String?
    public let creatorUserId: Int?
    public let isProfileFull: Bool?
    
    public let cars: [UserCarModel]?
    public let cards: [CardModel]?
    
    public func isFullInfo() -> Bool {
        return isProfileFull ?? false
    }
    
    public func getCars() -> [UserCarModel] {
        return cars ?? []
    }
    
    public func getCards() -> [CardModel] {
        return cards ?? []
    }
    
    public func getIdentifyCard() -> String {
        return identifyCard ?? ""
    }
    
    public func getIsDeleted() -> Bool {
        return isDeleted ?? false
    }
    public func getDeleterUserId() -> Int {
        return deleterUserId ?? 0
    }
    public func getDeletionTime() -> String {
        return creationTime ?? ""
    }
    public func getLastModificationTime() -> String {
        return lastModificationTime ?? ""
    }
    public func getLastModifierUserId() -> Int {
        return lastModifierUserId ?? 0
    }
 
    public func getCreationTime() -> String {
        return creationTime ?? ""
    }
    
    
    public func getCreatorUserId() -> Int {
        return creatorUserId ?? 0
    }
        
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    
    public func getAccessToken() -> String {
        return accessToken ?? ""
    }
    
    public func getEncryptedAccessToken() -> String {
        return encryptedAccessToken ?? ""
    }
    public func getExpireInSeconds() -> Int {
        return expireInSeconds ?? 0
    }
    
    public func getSurname() -> String {
        return surname ?? ""
    }
    
    public func getIsActive() -> Bool {
        return isActive ?? false
    }
    
    public func getDestiption() -> String {
        return desctiption ?? ""
    }
    
    public func getName() -> String {
        return name ?? ""
    }
    
    public func getAvatar() -> String {
        return avatar ?? ""
    }
    
    public func getAvatarUrl() -> URL? {
        return URL(string: "\(Constants.imageBaseUrl)/\(avatar ?? "")")
    }
    
    public func getPhone() -> String {
        return phone ?? ""
    }
    public func getBirthday() -> String {
        return birthday ?? ""
    }

    public func getBirthdayDisplay() -> String {
        return DateUtils.shared().birthDay(from: birthday ?? "")
    }
    
    public func getEmail() -> String {
        return email ?? ""
    }
    
    public func getAddress() -> String {
        return address ?? ""
    }
    
    init(name: String, avatar: String, phone: String, birthday: String, email: String, idenfierId: String, address: String, cars: [UserCarModel], cards: [CardModel]) {
        self.accessToken = ""
        self.name = name
        self.avatar = avatar
        self.phone = phone
        self.birthday = birthday
        self.identifyCard = idenfierId
        self.email = email
        self.address = address
        self.cars = cars
        self.cards = cards
        self.id = 0
        self.desctiption = ""
        self.surname =  ""
        self.expireInSeconds = 0
        self.encryptedAccessToken = ""
        self.isActive = true
        self.isDeleted = true
        self.deleterUserId = 0
        self.deletionTime = ""
        self.lastModificationTime = ""
        self.lastModifierUserId = 0
        self.creationTime = ""
        self.creatorUserId = 0
        self.isProfileFull = false
        }
}

extension User: ImmutableMappable {
   public init(map: Map) throws {
    self.accessToken          = try? map.value("accessToken")
    self.name                 = try? map.value("name")
    self.avatar               = try? map.value("avatar")
    self.phone                = try? map.value("phoneNumber")
    self.birthday             = try? map.value("birthday")
    self.identifyCard         = try? map.value("identityCard")
    self.email                = try? map.value("emailAddress")
    self.address              = try? map.value("address")
    self.cars                 = try? map.value("cars")
    self.cards                = try? map.value("cards")
    self.id                   = try? map.value("id")
    self.expireInSeconds      = try? map.value("expireInSeconds")
    self.encryptedAccessToken = try? map.value("encryptedAccessToken")
    self.surname              = try? map.value("surname")
    self.isActive             = try? map.value("isActive")
    self.desctiption          = try? map.value("desctiption")
    
    self.isDeleted            = try? map.value("isDeleted")
    self.deleterUserId        = try? map.value("deleterUserId")
    self.deletionTime         = try? map.value("deletionTime")
    self.lastModificationTime = try? map.value("lastModificationTime")
    self.lastModifierUserId   = try? map.value("lastModifierUserId")
    self.creationTime         = try? map.value("creationTime")
    self.creatorUserId        = try? map.value("creatorUserId")
    
    self.isProfileFull        = try? map.value("isProfileFull")
    
    }
}
