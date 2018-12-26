//
//  ConfirmLoginViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ConfirmLoginViewModel: BaseViewModel {
    public func transform(source: ConfirmLoginViewModel.Source) -> ConfirmLoginViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let isVerifying: Variable<Bool> = Variable(false)
        let verifyLogin = Driver.combineLatest(source.phoneNumber, source.verifyCode)
            .filter{$0.1.count == Constants.verifyCodeNumber}
            .flatMap({ (args) -> Driver<User> in
                let (phone, verifyCode) = args
                
                if isVerifying.value == true {
                    return Driver.empty()
                }
                isVerifying.value = true
    
                return self.service.getItem(User.self, Api.default.verifyLogin(phone: phone, code: verifyCode))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        verifyLogin.asObservable()
            .subscribe(onNext: { _ in
                isVerifying.value = false
            }).disposed(by: disposeBag)
        
        errorTracker.asObservable()
            .subscribe(onNext: { (_) in
                isVerifying.value = false
            }).disposed(by: disposeBag)
    
        let login = source.loginAgainAction
            .withLatestFrom(source.phoneNumber)
            .flatMap { (phone) -> Driver<BaseResponse> in
                return self.service.getAllResponse(BaseResponse.self, Api.default.login(phone: phone, deviceToken: "deviceToken", terminal: "terminal"))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        let resendCodeResponse = login.withLatestFrom(source.phoneNumber)
        { (login, phone) -> (String, Bool) in
            return (phone, login.getCode() == "200")
        }
        
        return Sink(verifyResponse: verifyLogin, resendCodeResponse: resendCodeResponse, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension ConfirmLoginViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let loginAgainAction: Driver<Void>
        public var phoneNumber: Driver<String>
        public var verifyCode: Driver<String>
        
        public init(viewWillAppear:Driver<Void>,
                    loginAgainAction: Driver<Void>,
                    phoneNumber: Driver<String>,
                    verifyCode: Driver<String>)
        {
            self.viewWillAppear = viewWillAppear
            self.loginAgainAction = loginAgainAction
            self.phoneNumber = phoneNumber
            self.verifyCode = verifyCode
        }
    }
    
    public struct Sink: SinkType {
        public var verifyResponse: Driver<User>
        public var resendCodeResponse: Driver<(String, Bool)>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
