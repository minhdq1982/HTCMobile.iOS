//
//  SinkType.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public protocol SinkType {
    var fetching: Driver<Bool>? {set get}
    var error: Driver<Error>? {set get}
}

public protocol ListSinkType : SinkType {
    var itemsSource : Driver<[Any]>? {set get}
    var refresh : Driver<Bool>? {set get}
}

public protocol DetailSinkType: SinkType{
    var item : Driver<ItemModel>? {set get}
}
