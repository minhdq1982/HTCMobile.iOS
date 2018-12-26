//
//  UserProfileViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class UserProfileViewModel: BaseViewModel {
    
    func transform(source: UserProfileViewModel.Source) -> UserProfileViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        // get profile
        let getProfile = source.viewWillAppear
            .flatMap { (_) -> Driver<User> in
                return self.service.getItem(User.self, Api.default.getProfileDetail())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        return Sink(itemsSource: getProfile,
                    fetching: activityIndicator.asDriver(),
                    error: errorTracker.asDriver())
    }
    
}

extension UserProfileViewModel: ViewModelType {
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let segmentIndex: Driver<Int>
        
        public init(viewWillAppear:Driver<Void>,
                    segmentIndex: Driver<Int>)
        {
            self.viewWillAppear = viewWillAppear
            self.segmentIndex = segmentIndex
        }
    }
    
    public struct Sink: SinkType
    {
        public var itemsSource: Driver<User>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
