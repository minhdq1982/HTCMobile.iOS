//
//  CompareModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/15/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

public struct CompareModel: BaseModel {
    public var identifier: String = ""
    public let version: CarVersionModel?
    public let details: [CarParamModel]?
}
