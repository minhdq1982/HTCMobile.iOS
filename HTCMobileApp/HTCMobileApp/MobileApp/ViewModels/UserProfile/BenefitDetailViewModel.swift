//
//  BenefitDetailViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class BenefitDetailViewModel: BaseViewModel {
    func transform(source: BenefitDetailViewModel.Source) -> BenefitDetailViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        
        // out put
        let sources = Driver.combineLatest(source.cards, source.benefitId)
            .flatMap {(args) -> Driver<[AgencyBenefitModel]> in
                var sources: [AgencyBenefitModel] = []
                let (cards, benefitId) = args

                    for card in cards {
                        for benefit in card.benefits ?? [] {
                            if benefitId == benefit.getId() {
                                let agency = card.agency
                                sources.append(AgencyBenefitModel(identifier: "AgencyBenefitCell", name: agency?.getName() ?? "", address: agency?.getAddress() ?? "", phone: agency?.getPhoneNumber() ?? ""))
                            }
                        }
                    
                }
                
                return Driver.just(sources)
        }
        
        return Sink(itemSource: sources, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension BenefitDetailViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let benefitId: Driver<Int>
        public let cards: Driver<[CardModel]>
        
        public init(viewWillAppear:Driver<Void>, benefitId: Driver<Int>, cards: Driver<[CardModel]>)
        {
            self.viewWillAppear = viewWillAppear
            self.benefitId = benefitId
            self.cards = cards
        }
    }
    
    public struct Sink: SinkType {
        public var itemSource: Driver<[AgencyBenefitModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
    
}
