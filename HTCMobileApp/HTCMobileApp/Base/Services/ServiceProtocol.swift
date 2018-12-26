//
//  ServiceProtocol.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import ObjectMapper

public protocol ServiceProtocol {
    func get(_ request:RequestProtocol)-> Observable<String>
    func getItem<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<T>
    func getNewsFeedItem<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<T>
    func getItems<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<[T]>
    func getAllResponse<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<T>
    func getMessage(_ request:RequestProtocol) -> Observable<String>
    func cancelService(id:String)
    
}
