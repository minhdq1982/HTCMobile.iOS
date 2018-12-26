//
//  ItemModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
public protocol ItemModel : BaseModel
{
    var title:String? {set get}
    var description:String? {set get}
    var thumbnail:String? {set get}
    var detailIdentifier: String? {set get}
    var id:Int? {set get}
}
