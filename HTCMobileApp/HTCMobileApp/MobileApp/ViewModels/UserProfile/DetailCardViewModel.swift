//
//  DetailCardViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DetailCardViewModel: BaseViewModel {
    func transform(source: DetailCardViewModel.Source) -> DetailCardViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
     
        let listMembership = source.membershipCards
        let indexItem = source.indexItem
        
        let sources = Driver.combineLatest(listMembership, indexItem)
            .flatMap {(args) -> Driver<[Section]> in
                var sources: [Section] = []
                let (list, indexItem) = args
                
                let cards: [CardModel] = list
                
                let itemHeaders = [HeadDetailModel(cards: cards)]
                let cardInfors = [CardDetailModel(point: list[indexItem].getPointsInThePeriod() , activeDate: list[indexItem].getActiveDate(), expiredDate: list[indexItem].getRankExpiredDate(), brand: list[indexItem].getBrand(), addressBrand: list[indexItem].getAddress(), phone: list[indexItem].getPhone())]
                let carInfors = [CarDetailCardModel(carName: list[indexItem].getModel(), vinno: list[indexItem].getVINNO(), licensePlate: list[indexItem].getLicensePlate(), purchaseDate: list[indexItem].getPurchaseDate())]
                let benefits = list[indexItem].getBenefits()
                let bottomDetails = [BottomDetailCardModel()]
                
                let itemHeaderSection = Section(header: "", items: itemHeaders)
                let cardSection = Section(header: "", items: cardInfors)
                let carSection = Section(header: "", items: carInfors)
                let tableSection = Section(header: "", items: benefits)
                let bottomDetailSection = Section(header: "", items: bottomDetails)
                
                sources.append(itemHeaderSection)
                sources.append(cardSection)
                sources.append(carSection)
                sources.append(tableSection)
                sources.append(bottomDetailSection)
                
                
                return Driver.just(sources)
        }
       
  
        return Sink(itemsSource: sources, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension DetailCardViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let membershipCards: Driver<[CardModel]>
        public let indexItem: Driver<Int>
        
        public init(viewWillAppear:Driver<Void>, membershipCard: Driver<[CardModel]>, indexItem: Driver<Int>)
        {
            self.viewWillAppear = viewWillAppear
            self.membershipCards = membershipCard
            self.indexItem = indexItem
        }
    }
    
    public struct Sink: SinkType {
        
        public var itemsSource: Driver<[Section]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
