//
//  MembershipItem.swift
//  HTCMobileApp
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct MembershipItem: BaseModel {
    public var identifier: String = "BenefitHeaderCell"
    var isExpand: Bool
    var title: String
    var cards: [CardModel]
    
    init(isExpand: Bool, title: String,  cards: [CardModel]) {
        self.isExpand = isExpand
        self.title = title
        self.cards = cards
    }
}
