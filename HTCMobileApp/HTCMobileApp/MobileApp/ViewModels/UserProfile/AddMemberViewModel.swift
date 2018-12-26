//
//  AddMemberViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class AddMemberViewModel: BaseViewModel {
    func transform(source: AddMemberViewModel.Source) -> AddMemberViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let validate: Variable<String> = Variable("")
        
        let addMemberResponse = source.addMemberAction
            .withLatestFrom(source.code)
            .flatMap { (code) -> Driver<CardModel> in
                
                //  validate code
                let cleanText = code.trimmingCharacters(in: .whitespacesAndNewlines)
                if cleanText.isEmpty {
                    validate.value = "Mã thẻ hội viên trống"
                    return Driver.empty()
                }else {
                    if !isValidCardId(code) {
                        validate.value = "Mã thẻ hội viên không hợp lệ"
                        return Driver.empty()
                    }
                }
                
                return self.service.getItem(CardModel.self, Api.default.addMembership(cardNumber: cleanText))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        return Sink(validateCode: validate.asDriver(), addMemberResponse: addMemberResponse, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension AddMemberViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let code : Driver<String>
        public let addMemberAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    code : Driver<String>,
                    addMemberAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.code = code
            self.addMemberAction = addMemberAction
        }
    }
    
    public struct Sink: SinkType {
        public var validateCode: Driver<String>
        public var addMemberResponse: Driver<CardModel>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
