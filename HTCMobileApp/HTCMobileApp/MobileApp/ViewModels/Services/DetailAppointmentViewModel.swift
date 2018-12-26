//
//  DetailAppointmentViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class DetailAppointmentViewModel: BaseViewModel {
    
    public func transform(source: DetailAppointmentViewModel.Source) -> DetailAppointmentViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension DetailAppointmentViewModel: ViewModelType {
    
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
