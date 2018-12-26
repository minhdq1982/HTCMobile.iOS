//
//  UserCarModels.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct UserCarModels: BaseModel {
    public var identifier = "CarUserCell"
    public let cards : [UserCarModel]
    
    public init(cards: [UserCarModel])
    {
        self.cards = cards
    }
}

