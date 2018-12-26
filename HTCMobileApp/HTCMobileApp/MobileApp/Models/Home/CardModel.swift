//
//  CardModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct CardModel: BaseModel {
    public var identifier: String = ""
    let id: Int?
    let membershipID, cardNo: String?
    var rank: String?
    let pointsInThePeriod, valueInThePeriod, customerID: Int?

    let customerName, gender, phone, address: String?
    let licensePlates, vinNo, brand, model: String?
    let activeDate, rankExpiredDate: String?

    let cardStatus, membershipStatus: Int?
    
    let description, purchasedDate: String?
    
    let membershipCode: String?
    
    public let agency: AgencyLocationModel?
    public let benefits: [BenefitModel]?
    
    public mutating func setRank(_ rank: String) {
        self.rank = rank
    }
    
    public func getBenefits() -> [BaseModel] {
        return benefits ?? []
    }
    
    public func getMembershipCode() -> String {
        return membershipCode ?? ""
    }
    
    public func getPurchaseDate() -> String {
        return purchasedDate ?? ""
    }
    public func getModel() -> String {
        return model ?? ""
    }
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getActiveDate() -> String {
        return activeDate ?? ""
    }
    
    public func getPointsInThePeriod() -> Int {
        return pointsInThePeriod ?? 0
    }
    
    public func getRankExpiredDate() -> String {
        return rankExpiredDate ?? ""
    }
    
    public func getAddress() -> String {
        return address ?? ""
    }
    
    public func getPhone() -> String {
        return phone ?? ""
    }
    
    public func getVINNO() -> String {
        return vinNo ?? ""
    }
    public func getUsername() -> String {
        return customerName ?? ""
    }
    public func getBrand() -> String {
        return brand ?? ""
    }
    public func getLicensePlate() -> String {
        return licensePlates ?? ""
    }
    public func getRank() -> String {
        return rank ?? ""
    }
    
    public func getMembershipStatus() -> Int {
        return membershipStatus ?? 0
    }
    
    public func getDescription() -> String {
        return description ?? ""
    }
    
    public func getCustomerName() -> String {
        return customerName ?? ""
    }
    
    public func getCardNo() -> String {
        return cardNo ?? ""
    }
    
    public func getAgencyName() -> String {
        if let name = agency?.name  {
            return name
        }
        return ""
    }
    
    public func getAgencyNameDisplay() -> String {
        if let name = agency?.name  {
            let components = name.components(separatedBy: CharacterSet(charactersIn: " "))
            if components.count > 0 {
                let brand = components[0]
                return "\(brand)\r\n\(name.substring(from: brand.count + 1))"
            }
        }
        return ""
    }
    
    init(idenfier: String, rank: String, customerName: String, licensePlates: String, vINNo: String, brand: String, agency: AgencyLocationModel, benefits: [BenefitModel]) {
        self.licensePlates = licensePlates
        self.vinNo = vINNo
        self.brand = brand
        self.customerName = customerName
        self.rank = rank
        self.membershipID = "000123"
        self.cardNo = "ABC123"
        self.pointsInThePeriod = 150
        self.valueInThePeriod = 150
        self.customerID = 1234
        self.gender = "Male"
        self.phone = "033246989"
        self.address = "Hanoi"
        self.model = "Accent"
        self.activeDate = "20/10/2018"
        self.rankExpiredDate = "20/10/2018"
        self.cardStatus = 0
        self.membershipStatus = 0
        self.description = ""
        self.agency = agency
        self.benefits = benefits
        self.identifier = idenfier
        self.id = 0
        self.purchasedDate = "30/12/2018"
        self.membershipCode = ""
    }
    
}

extension CardModel: ImmutableMappable {
    public init(map: Map) throws {
        self.membershipID       = try? map.value("membershipId")
        self.cardNo             = try? map.value("cardNo")
        self.rank               = try? map.value("rank")
        self.pointsInThePeriod  = try? map.value("pointsInThePeriod")
        self.valueInThePeriod   = try? map.value("valueInThePeriod")
        self.customerID         = try? map.value("customerId")
        self.customerName       = try? map.value("customerName")
        self.gender             = try? map.value("gender")
        self.phone              = try? map.value("phone")
        self.address            = try? map.value("address")
        self.licensePlates      = try? map.value("licensePlates")
        self.vinNo              = try? map.value("viNNo")
        self.brand              = try? map.value("brand")
        self.model              = try? map.value("model")
        self.activeDate         = try? map.value("activeDate")
        self.rankExpiredDate    = try? map.value("rankExpiredDate")
        self.cardStatus         = try? map.value("cardStatus")
        self.description        = try? map.value("description")
        self.membershipStatus   = try? map.value("membershipStatus")
        self.agency             = try? map.value("agency")
        self.benefits           = try? map.value("benefits")
        self.id                 = try? map.value("id")
        self.purchasedDate      = ""
        self.membershipCode     = try? map.value("membershipCode")
    }
}
