//
//  UserInforViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserInforViewModel: BaseViewModel {
    func transform(source: UserInforViewModel.Source) -> UserInforViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let arr = [UserItem(ItemUserType.phone.rawValue, "01643246989"),
                    UserItem(ItemUserType.dateOfBirh.rawValue, "09/08/1996"),
                    UserItem(ItemUserType.CMND.rawValue, "017174453"),
                    UserItem(ItemUserType.email.rawValue, "tund@tinhvan.com"),
                    UserItem(ItemUserType.address.rawValue, "Hanoi")]
        
        return Sink(itemSource: Driver.just(arr), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension UserInforViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        let userInfors: Driver<[UserItem]>
        
        public init(viewWillAppear:Driver<Void>, userInfors: Driver<[UserItem]>)
        {
            self.viewWillAppear = viewWillAppear
            self.userInfors = userInfors
        }
    }
    
    public struct Sink: SinkType {
        public var itemSource: Driver<[UserItem]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
