//
//  BaseViewController+Rx.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
extension Reactive where Base: BaseViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var showError: Binder<Error> {
        return Binder(self.base) { viewController, error in
            viewController.executeError(error:error)
            
        }
    }
    
}

extension Reactive where Base: BaseTableViewController {
    
    /// Bindable sink for `startAnimating()`, `stopAnimating()` methods.
    public var showError: Binder< Error> {
        return Binder(self.base) { viewController, error in
            viewController.executeError(error:error)
            
        }
    }
    
}
