//
//  HeadDetailModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct HeadDetailModel: BaseModel {
    public var identifier: String = "HeadDetailCell"
    
    public let cards: [CardModel]
    
    public init(cards: [CardModel])
    {
        self.cards = cards
    }
    
    
}
