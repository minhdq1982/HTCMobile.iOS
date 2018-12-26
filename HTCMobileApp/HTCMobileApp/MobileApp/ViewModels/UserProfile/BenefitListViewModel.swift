//
//  BenefitListViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class BenefitListViewModel: BaseViewModel {
    func transform(source: BenefitListViewModel.Source) -> BenefitListViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let itemsSource: Variable<[CardModel]> = Variable([])
      
        
        source.cards.asObservable()
            .subscribe(onNext: { (cards) in
                itemsSource.value.removeAll()
                if cards.count > 0 {
                    itemsSource.value += cards
                }
            }).disposed(by: disposeBag)
        
        
        
        return Sink(itemsSource: itemsSource.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension BenefitListViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let cards: Driver<[CardModel]>
        
        public init(viewWillAppear:Driver<Void>, cards: Driver<[CardModel]>)
        {
            self.viewWillAppear = viewWillAppear
            self.cards = cards
        }
    }
    
    public struct Sink: SinkType {
        public var itemsSource: Driver<[CardModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
