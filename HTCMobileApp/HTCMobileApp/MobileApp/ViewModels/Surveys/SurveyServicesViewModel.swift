//
//  SurveyServicesViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/28/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class SurveyServicesViewModel: BaseViewModel{
    func transform(source: SurveyServicesViewModel.Source) -> SurveyServicesViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let listAgencyResponse = source.viewWillAppear
            .flatMap { (_) -> Driver<[AgencyLocationModel]> in
                return self.service.getItems(AgencyLocationModel.self, Api.default.getAgenciesList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        let listCarResponse = source.viewWillAppear
            .flatMap { (_) -> Driver<[CarModel]> in
                return self.service.getItems(CarModel.self, Api.default.getCarsList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        return Sink(listCarResponse: listCarResponse, listAgencyResponse: listAgencyResponse, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension SurveyServicesViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType {
        public var listCarResponse: Driver<[CarModel]>
        public var listAgencyResponse: Driver<[AgencyLocationModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
