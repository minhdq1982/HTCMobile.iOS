//
//  MessageView+Rx.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMessages

extension Reactive where Base: MessageView {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var show: Binder< Error> {
        return Binder(self.base) { messageView, error in
            print(error)
            
        }
    }
    
}
