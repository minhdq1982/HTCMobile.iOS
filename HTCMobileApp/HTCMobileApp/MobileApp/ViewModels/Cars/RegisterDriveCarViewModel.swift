//
//  RegisterDriveCarViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class RegisterDriveCarViewModel: BaseViewModel {
    
    public func transform(source: RegisterDriveCarViewModel.Source) -> RegisterDriveCarViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension RegisterDriveCarViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let registerAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    registerAction:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.registerAction = registerAction
        }
    }
    
    public struct Sink: SinkType
    {
//        public var registerAction: Driver<Any>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
