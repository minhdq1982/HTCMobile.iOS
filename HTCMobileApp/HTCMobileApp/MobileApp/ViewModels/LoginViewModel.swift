//
//  LoginViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public class LoginViewModel: BaseViewModel {
    public func transform(source: LoginViewModel.Source) -> LoginViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let validation = source.loginAction
            .withLatestFrom(source.phoneNumber)
            .flatMap { (phone) -> Driver<(Bool, String)> in
                var isValid = false
                var message = ""
                
                if phone.isEmpty {
                    message = tr(L10n.loginCheck)
                }else {
                    if isValidPhone(phone) {
                        isValid = true
                    }else {
                        message = "Số điện thoại không hợp lệ."
                    }
                }
                
                return Driver.just((isValid, message))
        }
        
        let loginInputs = Driver.combineLatest(validation, source.phoneNumber)
        let login = source.loginAction
            .withLatestFrom(loginInputs)
            .filter{$0.0.0 == true}
            .flatMap({ (args) -> Driver<BaseResponse> in
                let (_, phone) = args
                return self.service.getAllResponse(BaseResponse.self, Api.default.login(phone: phone, deviceToken: "string", terminal: "string"))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        let loginResponse = login.withLatestFrom(source.phoneNumber)
            { (login, phone) -> (String, Bool) in
                return (phone, login.getCode() == "200")
        }
        
        return Sink(loginResponse: loginResponse, validation: validation, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
    
}

extension LoginViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let loginAction: Driver<Void>
        public let phoneNumber: Driver<String>
        
        public init(viewWillAppear:Driver<Void>,
                    loginAction: Driver<Void>,
                    phoneNumber: Driver<String>)
        {
            self.viewWillAppear = viewWillAppear
            self.loginAction = loginAction
            self.phoneNumber = phoneNumber
        }
    }
    
    public struct Sink: SinkType {
        
        public var loginResponse: Driver<(String, Bool)>
        public var validation: Driver<(Bool, String)>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
    
    
}
