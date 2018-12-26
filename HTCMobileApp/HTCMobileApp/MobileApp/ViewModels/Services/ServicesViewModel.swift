//
//  ServicesViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class ServicesViewModel: BaseViewModel {
    
    public func transform(source: ServicesViewModel.Source) -> ServicesViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        var items: [AppointmentScheduleModel] = []
        items.append(AppointmentScheduleModel())
        items.append(AppointmentScheduleModel())
        items.append(AppointmentScheduleModel())
        items.append(AppointmentScheduleModel())
        
        return Sink(appointmentItemsSource: Driver.just(items),fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension ServicesViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType
    {
        public var appointmentItemsSource: Driver<[AppointmentScheduleModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
