//
//  ConsultantInstallmentViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class ConsultantInstallmentViewModel: BaseViewModel {
    
    public func transform(source: ConsultantInstallmentViewModel.Source) -> ConsultantInstallmentViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let items = [PaymentPeriodModel(name: "Kỳ thanh toán 1", totalDebt: "5,000,000", originalInMonth: "5,000,000", interestOfMonth: "83,333", originalAndInterest: "5,083,000"),
                     PaymentPeriodModel(name: "Kỳ thanh toán 2", totalDebt: "5,000,000", originalInMonth: "5,000,000", interestOfMonth: "83,333", originalAndInterest: "5,083,000"),
                     PaymentPeriodModel(name: "Kỳ thanh toán 3", totalDebt: "5,000,000", originalInMonth: "5,000,000", interestOfMonth: "83,333", originalAndInterest: "5,083,000")]
        let section = Section(header: "", items: items)
        
        return Sink(itemsSource: Driver.just([section]) ,fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension ConsultantInstallmentViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType
    {
        public var itemsSource: Driver<[Section]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
