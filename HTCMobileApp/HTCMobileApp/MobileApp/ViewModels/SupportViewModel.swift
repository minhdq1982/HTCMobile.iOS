//
//  SupportViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class SupportViewModel: BaseViewModel {
    
    public func transform(source: SupportViewModel.Source) -> SupportViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension SupportViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType
    {
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
