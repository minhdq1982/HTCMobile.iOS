//
//  MenuViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class MenuViewModel: BaseViewModel {
    
    public func transform(source: MenuViewModel.Source) -> MenuViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        //  Call API login and handle response
//        source.logoutAction
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension MenuViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let logoutAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    logoutAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.logoutAction = logoutAction
        }
    }
    
    public struct Sink: SinkType
    {
//        public var logoutResponse: Driver<Any>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
