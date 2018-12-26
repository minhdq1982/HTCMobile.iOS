//
//  GroupCardModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct GroupCardModel: BaseModel {
    public var identifier = "GroupCardCell"
    public let cards : [CardModel]
    
    public init(cards: [CardModel])
    {
        self.cards = cards
    }
}
