//
//  TermsOfUseViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class TermsOfUseViewModel: BaseViewModel {
    func transform(source: TermsOfUseViewModel.Source) -> TermsOfUseViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let htmlString = source.viewWillAppear
                    .flatMap { (_) -> Driver<TermOfUseModel> in
                        return self.service.getItem(TermOfUseModel.self, Api.default.getTermOfUse())
                            .trackActivity(activityIndicator)
                            .trackError(errorTracker)
                            .asDriverOnErrorJustComplete()
                }
        
        return Sink(htmlString: htmlString,fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension TermsOfUseViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType {
        public var htmlString: Driver<TermOfUseModel>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
