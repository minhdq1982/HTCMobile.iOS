//
//  HomeBannerModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
public struct HomeBannerModel: BaseModel {
    public var identifier = "BannerAutoScrollCell"
    
    public let banners: [BannerModel]
    
    public init(banners: [BannerModel])
    {
        self.banners = banners
    }
}
