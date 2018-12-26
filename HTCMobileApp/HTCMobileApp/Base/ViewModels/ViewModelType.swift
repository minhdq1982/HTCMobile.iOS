//
//  ViewModelType.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
public protocol ViewModelType {
    associatedtype Source
    associatedtype Sink
    
    func transform(source: Source) -> Sink
    
    
}
