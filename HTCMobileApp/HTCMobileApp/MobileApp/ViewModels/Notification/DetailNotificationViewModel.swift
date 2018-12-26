//
//  DetailNotificationViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailNotificationViewModel: BaseViewModel {
    func transform(source: DetailNotificationViewModel.Source) -> DetailNotificationViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension DetailNotificationViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType {
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
