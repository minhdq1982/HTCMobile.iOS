//
//  HistoryCardViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/8/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class HistoryCardViewModel: BaseViewModel {
    let segment: Variable<Int> = Variable(0)
    
    func transform(source: HistoryCardViewModel.Source) -> HistoryCardViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let canLoadMoreUsingPoint: Variable<Bool> = Variable(true)
        let canLoadMoreNoUsingPoint: Variable<Bool> = Variable(true)
        let canLoadMoreIncentive: Variable<Bool> = Variable(true)
        
        let isLoading: Variable<Bool> = Variable(false)
        
        let usingPointsHistory: Variable<[HistoryPointModel]> = Variable([])
        let noUsingPointsHistory: Variable<[HistoryNoUsePointModel]> = Variable([])
        let incentiveHistory: Variable<[HistoryIncentiveModel]> = Variable([])
        
//        source.segmentIndex.drive(self.segment)
        
        let inputs =  Driver.combineLatest(source.beginDate, source.endDate, source.membershipCode)
        let refreshInputs = Driver.combineLatest(source.segmentIndex, source.beginDate, source.endDate,source.membershipCode)
        let dateInputs = Driver.combineLatest(source.beginDate, source.endDate)
        let loadMoreInputs = Driver.combineLatest(source.segmentIndex, source.beginDate, source.endDate,source.membershipCode, canLoadMoreNoUsingPoint.asDriver(), canLoadMoreUsingPoint.asDriver(), canLoadMoreIncentive.asDriver())
        
        
    
        
        // MARK: - incentive
//        let refreshIncentive = source.refresh
//            .withLatestFrom(refreshInputs)
//            .flatMap({ (args) -> Driver<HistoryIncentiveListModel> in
//
////                if isLoading.value == true {
////                    return Driver.empty()
////                }
//                isLoading.value = true
//
//                switch args.0 {
//                case 2:
//                    incentiveHistory.value.removeAll()
//                    canLoadMoreIncentive.value = true
//                    return self.service.getItem(HistoryIncentiveListModel.self, Api.default.getIncentiveHistory(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.3, fromDate: args.1, toDate: args.2))
//                        .trackActivity(activityIndicator)
//                        .trackError(errorTracker)
//                        .asDriverOnErrorJustComplete()
//                default:
//                    //                    newsFeed.value.removeAll()
//                    //                    canLoadMoreNewsFeed.value = true
//                    return Driver.empty()
//                }
//            })
//        refreshIncentive.asObservable()
//            .subscribe(onNext: {[weak self] (model) in
//                isLoading.value = false
//                if let items = model.items, items.count > 0 {
//                    for item in items {
//                        incentiveHistory.value.append(item)
//                    }
//                    if items.count < Constants.maxLoadMoreNumber {
//                        canLoadMoreIncentive.value = false
//                    }
//                }
//            }).disposed(by: disposeBag)
//
//
//        let changeIndexIncentive = dateInputs
//            .withLatestFrom(inputs)
//            .flatMap({ (args) -> Driver<HistoryIncentiveListModel> in
////                if isLoading.value == true {
////                    return Driver.empty()
////                }
//                incentiveHistory.value.removeAll()
//                canLoadMoreIncentive.value = true
////                isLoading.value = true
//
//                return self.service.getItem(HistoryIncentiveListModel.self, Api.default.getIncentiveHistory(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.2, fromDate: args.0, toDate: args.1))
//                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
//                    .asDriverOnErrorJustComplete()
//            })
//
//        changeIndexIncentive.asObservable()
//            .subscribe(onNext: { [weak self] (model) in
//                isLoading.value = false
//                if let items = model.items, items.count > 0 {
//                    for item in items {
//                        incentiveHistory.value.append(item)
//                    }
//                    if items.count < Constants.maxLoadMoreNumber {
//                        canLoadMoreIncentive.value = false
//                    }
//                }
//            }).disposed(by: disposeBag)
        
        let incentive = source.segmentIndex
            .filter{$0 == 2}
            .withLatestFrom(inputs)
            .flatMap({ (args) -> Driver<HistoryIncentiveListModel> in
                if isLoading.value == true {
                    return Driver.empty()
                }
                incentiveHistory.value.removeAll()
                canLoadMoreIncentive.value = true
                isLoading.value = true
                
                return self.service.getItem(HistoryIncentiveListModel.self, Api.default.getIncentiveHistory(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.2, fromDate: args.0, toDate: args.1))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        incentive.asObservable()
            .subscribe(onNext: {(model) in
                isLoading.value = false
                if let items = model.items, items.count > 0 {
                    for item in items {
                        incentiveHistory.value.append(item)
                    }
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMoreIncentive.value = false
                    }
                }
            }).disposed(by: disposeBag)
        
        // MARK: - using points
//        let refreshUsePoint = source.refresh
//            .withLatestFrom(refreshInputs)
//            .flatMap({ (args) -> Driver<HistoryPointListModel> in
//
////                if isLoading.value == true {
////                    return Driver.empty()
////                }
//                isLoading.value = true
//
//                switch args.0 {
//                case 1:
//                    usingPointsHistory.value.removeAll()
//                    canLoadMoreUsingPoint.value = true
//                    return self.service.getItem(HistoryPointListModel.self, Api.default.getHistoryUsingPoint(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.3, fromDate: args.1, toDate: args.2))
//                        .trackActivity(activityIndicator)
//                        .trackError(errorTracker)
//                        .asDriverOnErrorJustComplete()
//                default:
//                    //                    newsFeed.value.removeAll()
//                    //                    canLoadMoreNewsFeed.value = true
//                    return Driver.empty()
//                }
//            })
//        refreshUsePoint.asObservable()
//            .subscribe(onNext: {[weak self] (model) in
//                isLoading.value = false
//                if let items = model.items, items.count > 0 {
//                    for item in items {
//                        usingPointsHistory.value.append(item)
//                    }
//                    if items.count < Constants.maxLoadMoreNumber {
//                        canLoadMoreUsingPoint.value = false
//                    }
//                }
//            }).disposed(by: disposeBag)
//
//        let changeIndexUsingPoint = dateInputs
//            .withLatestFrom(inputs)
//            .flatMap({ (args) -> Driver<HistoryPointListModel> in
////                if isLoading.value == true {
////                    return Driver.empty()
////                }
//                usingPointsHistory.value.removeAll()
//                canLoadMoreUsingPoint.value = true
//                isLoading.value = true
//
//                return self.service.getItem(HistoryPointListModel.self, Api.default.getHistoryUsingPoint(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.2, fromDate: args.0, toDate: args.1))
//                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
//                    .asDriverOnErrorJustComplete()
//            })
//
//        changeIndexUsingPoint.asObservable()
//            .subscribe(onNext: { [weak self] (model) in
//                isLoading.value = false
//                if let items = model.items, items.count > 0 {
//                    for item in items {
//                        usingPointsHistory.value.append(item)
//                    }
//                    if items.count < Constants.maxLoadMoreNumber {
//                        canLoadMoreUsingPoint.value = false
//                    }
//                }
//            }).disposed(by: disposeBag)
        
        let usingPoint = source.segmentIndex
            .filter{$0 == 1}
            .withLatestFrom(inputs)
            .flatMap({ (args) -> Driver<HistoryPointListModel> in
                if isLoading.value == true {
                    return Driver.empty()
                }
                usingPointsHistory.value.removeAll()
                canLoadMoreUsingPoint.value = true
                isLoading.value = true
                
                return self.service.getItem(HistoryPointListModel.self, Api.default.getHistoryUsingPoint(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.2, fromDate: args.0, toDate: args.1))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
  
        usingPoint.asObservable()
            .subscribe(onNext: {(model) in
                isLoading.value = false
                if let items = model.items, items.count > 0 {
                    for item in items {
                        usingPointsHistory.value.append(item)
                    }
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMoreUsingPoint.value = false
                    }
                }
         }).disposed(by: disposeBag)
        
        // MARK: - no using points
//        let refreshNoUsePoint = source.refresh
//            .withLatestFrom(refreshInputs)
//            .flatMap({ (args) -> Driver<HistoryNoUsePointListModel> in
//
////                if isLoading.value == true {
////                    return Driver.empty()
////                }
//                isLoading.value = true
//
//                switch args.0 {
//                case 0:
//                    noUsingPointsHistory.value.removeAll()
//                    canLoadMoreNoUsingPoint.value = true
//                    return self.service.getItem(HistoryNoUsePointListModel.self, Api.default.getHistoryNoUsingPoint(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.3, fromDate: args.1, toDate: args.2))
//                        .trackActivity(activityIndicator)
//                        .trackError(errorTracker)
//                        .asDriverOnErrorJustComplete()
//                default:
//                    //                    newsFeed.value.removeAll()
//                    //                    canLoadMoreNewsFeed.value = true
//                    return Driver.empty()
//                }
//            })
//        refreshNoUsePoint.asObservable()
//            .subscribe(onNext: {[weak self] (model) in
//                isLoading.value = false
//                if let items = model.items, items.count > 0 {
//                    for item in items {
//                        noUsingPointsHistory.value.append(item)
//                    }
//                    if items.count < Constants.maxLoadMoreNumber {
//                        canLoadMoreNoUsingPoint.value = false
//                    }
//                }
//            }).disposed(by: disposeBag)
//        let changeIndexNoUsingPoint = dateInputs
//            .withLatestFrom(inputs)
//            .flatMap({ (args) -> Driver<HistoryNoUsePointListModel> in
////                if isLoading.value == true {
////                    return Driver.empty()
////                }
//                noUsingPointsHistory.value.removeAll()
//                canLoadMoreNoUsingPoint.value = true
//                isLoading.value = true
//
//                return self.service.getItem(HistoryNoUsePointListModel.self, Api.default.getHistoryNoUsingPoint(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.2, fromDate: args.0, toDate: args.1))
//                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
//                    .asDriverOnErrorJustComplete()
//            })
//
//        changeIndexNoUsingPoint.asObservable()
//            .subscribe(onNext: { [weak self] (model) in
//                isLoading.value = false
//                if let items = model.items, items.count > 0 {
//                    for item in items {
//                        noUsingPointsHistory.value.append(item)
//                    }
//                    if items.count < Constants.maxLoadMoreNumber {
//                        canLoadMoreNoUsingPoint.value = false
//                    }
//                }
//            }).disposed(by: disposeBag)
        let noUsingPoint = source.segmentIndex
            .filter{$0 == 0}
            .withLatestFrom(inputs)
            .flatMap({ (args) -> Driver<HistoryNoUsePointListModel> in
                if isLoading.value == true {
                    return Driver.empty()
                }
                noUsingPointsHistory.value.removeAll()
                canLoadMoreNoUsingPoint.value = true
                isLoading.value = true
                
                return self.service.getItem(HistoryNoUsePointListModel.self, Api.default.getHistoryNoUsingPoint(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: args.2, fromDate: args.0, toDate: args.1))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        noUsingPoint.asObservable()
            .subscribe(onNext: { [weak self] (model) in
                isLoading.value = false
                if let items = model.items, items.count > 0 {
                    //                    let arr: [HistoryUsePointModel] = items
                    for item in items {
                        noUsingPointsHistory.value.append(item)
                    }
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMoreNoUsingPoint.value = false
                    }
                }
            }).disposed(by: disposeBag)
      
        
        // load More
//        let loadMoreInputs = Driver.combineLatest(source.segmentIndex, source.beginDate, source.endDate,source.membershipCode, canLoadMoreNoUsingPoint.asDriver(), canLoadMoreUsingPoint.asDriver(), canLoadMoreIncentive.asDriver())
//        let loadMoreNoUsingPoint = source.loadMore
//            .withLatestFrom(loadMoreInputs)
//            .filter{($0.0 == 0)}
//            .flatMap({ (args) -> Driver<HistoryNoUsePointListModel> in
//
//                if isLoading.value == true {
//                    return Driver.empty()
//                }
//
//                let (index, beginDate, endDate, membershipCode, canLoadMore, _, _) = args
//                isLoading.value = true
//
//                switch index {
//                case 0:
//                    return self.service.getItem(HistoryNoUsePointListModel.self, Api.default.getHistoryNoUsingPoint(skipCount: noUsingPointsHistory.value.count, maxResultCount: Constants.maxLoadMoreNumber, membershipCode: membershipCode, fromDate: beginDate, toDate: endDate))
//                        .trackActivity(activityIndicator)
//                        .trackError(errorTracker)
//                        .asDriverOnErrorJustComplete()
//
//                default:
//                    return Driver.empty()
//                }
//            })
//
//        loadMoreNoUsingPoint.asObservable()
//            .subscribe(onNext: {[weak self] (model) in
//                isLoading.value = false
//                guard let s = self else {return}
//                if let items = model.items, items.count > 0 {
//                    var array:[HistoryNoUsePointModel] = items
//                    if s.segment.value == 0 {
//                        noUsingPointsHistory.value.append(contentsOf: array)
//
//                        if items.count < Constants.maxLoadMoreNumber {
//                            canLoadMoreNoUsingPoint.value = false
//                        }
//                    }
//                }
//            }).disposed(by: disposeBag)
        
        // control itemsource
        let itemsSource = Driver.combineLatest(source.segmentIndex ,usingPointsHistory.asDriver(), noUsingPointsHistory.asDriver(), incentiveHistory.asDriver())
            .flatMap { (args) -> Driver<[BaseModel]> in
                let (segment, usingPoints, noUsingPoint, incentiveHistory) = args
                switch segment {
                case 0:
                    return Driver.just(noUsingPoint)
                case 1:
                    return Driver.just(usingPoints)
                default:
                    return Driver.just(incentiveHistory)
                }
        }
  
        return Sink(itemsSource: itemsSource.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}
extension HistoryCardViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let segmentIndex: Driver<Int>
        public let refresh: Driver<Void>
        public let loadMore: Driver<Void>
        public let beginDate: Driver<String>
        public let endDate: Driver<String>
        public let membershipCode: Driver<String>
        
        public init(viewWillAppear:Driver<Void>, segmentIndex: Driver<Int>, beginDate: Driver<String>, endDate: Driver<String>, refresh: Driver<Void>, loadMore: Driver<Void>, membershipCode: Driver<String>)
        {
            self.viewWillAppear = viewWillAppear
            self.segmentIndex = segmentIndex
            self.beginDate = beginDate
            self.endDate = endDate
            self.loadMore = loadMore
            self.refresh = refresh
            self.membershipCode = membershipCode
        }
    }
    
    public struct Sink: SinkType {
        public var itemsSource: Driver<[BaseModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
