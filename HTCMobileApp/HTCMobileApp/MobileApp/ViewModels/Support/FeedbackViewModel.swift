//
//  FeedbackViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class FeedbackViewModel: BaseViewModel {
    public func transform(source: FeedbackViewModel.Source) -> FeedbackViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension FeedbackViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let sendAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    sendAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.sendAction = sendAction
        }
    }
    
    public struct Sink: SinkType
    {
//        public var actionSend: Driver<>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
