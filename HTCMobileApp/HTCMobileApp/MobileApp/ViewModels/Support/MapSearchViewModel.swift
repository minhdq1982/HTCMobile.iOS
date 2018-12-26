//
//  MapSearchViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class MapSearchViewModel: BaseViewModel {
    public func transform(source: MapSearchViewModel.Source) -> MapSearchViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        return Sink(fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension MapSearchViewModel: ViewModelType {
    
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
