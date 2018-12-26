//
//  ChooseCarViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class ChooseCarViewModel: BaseViewModel {
    
    var itemsSource:Variable<[CarModel]> = Variable([])
    
    public func transform(source: ChooseCarViewModel.Source) -> ChooseCarViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let categories = [CategoryModel(name: "Tất cả"),
                        CategoryModel(name: "Xe du lịch"),
                        CategoryModel(name: "Xe SUV, xe MVP"),
                        CategoryModel(name: "Xe thương mại")]
        source.categoryIndex
            .asObservable()
            .subscribe(onNext: {[weak self] (index) in
                guard let s = self else {return}
                s.itemsSource.value.removeAll()
                
                if index == 0 {
                    for _ in 0...20 {
                        s.itemsSource.value.append(CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "", shortDescription: "", image: [""], price: 500000000, unit: "VND"))
                    }
                    
                }else{
                    s.itemsSource.value.append(CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "", shortDescription: "", image: [""], price: 500000000, unit: "VND"))
                    s.itemsSource.value.append(CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "", shortDescription: "", image: [""], price: 500000000, unit: "VND"))
                    s.itemsSource.value.append(CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "", shortDescription: "", image: [""], price: 500000000, unit: "VND"))
                }
            }).disposed(by: disposeBag)
        
        return Sink(categoriesSource: Driver.just(categories), itemsSource: itemsSource.asDriver(),fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension ChooseCarViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let categoryIndex: Driver<Int>
        public let priceOption: Driver<Int>
        public let capacityOption: Driver<Int>
        public let gearOption: Driver<Int>
        public let searchAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    categoryIndex: Driver<Int>,
                    priceOption: Driver<Int>,
                    capacityOption: Driver<Int>,
                    gearOption: Driver<Int>,
                    searchAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.categoryIndex = categoryIndex
            self.priceOption = priceOption
            self.capacityOption = capacityOption
            self.gearOption = gearOption
            self.searchAction = searchAction
        }
    }
    
    public struct Sink: SinkType
    {
        public var categoriesSource: Driver<[CategoryModel]>
        public var itemsSource: Driver<[CarModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
