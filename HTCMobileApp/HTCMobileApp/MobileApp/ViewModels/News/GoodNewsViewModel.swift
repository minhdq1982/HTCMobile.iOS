//
//  GoodNewsViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class GoodNewsViewModel: BaseViewModel {
    func transform(source: GoodNewsViewModel.Source) -> GoodNewsViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let isLoading: Variable<Bool> = Variable(false)
        let canLoadMore: Variable<Bool> = Variable(true)
        let itemsSource: Variable<[NewsModel]> = Variable([])
        
        let newsList = Driver.merge(source.viewWillAppear, source.refresh)
            .withLatestFrom(source.groupNews)
            .flatMap { (model) -> Driver<NewsListModel> in
                if isLoading.value == true {
                    return Driver.empty()
                }
                canLoadMore.value = true
                isLoading.value = true
                itemsSource.value.removeAll()
                
                return self.service.getItem(NewsListModel.self, Api.default.getNewsFromHome(groupId: model.getId(), skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                .trackActivity(activityIndicator)
                .trackError(errorTracker)
                .asDriverOnErrorJustComplete()
        }
        
        newsList.asObservable()
            .subscribe(onNext: { (model) in
                isLoading.value = false
                if var items = model.items, items.count > 0 {
                    //  Change identifier of the first item
                    var array:[NewsModel] = []
                    for i in 0..<items.count {
                        var model = items[i]
                        if i == 0 {
                            model.setIdentifier(idenfier: NewsCell.identifier)
                        }
                        array.append(model)
                    }
                    itemsSource.value.append(contentsOf: array)
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMore.value = false
                    }
                }
            }).disposed(by: disposeBag)
        errorTracker.asObservable()
            .subscribe(onNext: { (_) in
                isLoading.value = false
            }).disposed(by: disposeBag)
        
        //  load more
        let loadMore = source.loadMore
            .skip(1)
            .filter{itemsSource.value.count > 0}
            .withLatestFrom(Driver.combineLatest(source.groupNews, canLoadMore.asDriver()))
            .filter{$0.1 == true}
            .flatMap({ (args) -> Driver<NewsListModel> in
                let (model, _) = args
                if isLoading.value == true {
                    return Driver.empty()
                }
                isLoading.value = true
                canLoadMore.value = true
                
                return self.service.getItem(NewsListModel.self, Api.default.getNewsFromHome(groupId: model.getId(), skipCount: itemsSource.value.count, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
                
        })
        
        loadMore.asObservable()
            .subscribe(onNext: { (model) in
                isLoading.value = false
                if let items = model.items, items.count > 0 {
                    itemsSource.value.append(contentsOf: items)
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMore.value = false
                    }
                }
            }).disposed(by: disposeBag)
        
        return Sink(itemSource: itemsSource.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension GoodNewsViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let groupNews : Driver<GroupNewsHeaderModel>
        public let loadMore: Driver<Void>
        public let refresh: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    groupNews : Driver<GroupNewsHeaderModel>,
                    loadMore: Driver<Void>,
                    refresh: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.groupNews = groupNews
            self.loadMore = loadMore
            self.refresh = refresh
        }
    }
    
    public struct Sink: SinkType {
        public var itemSource: Driver<[NewsModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
