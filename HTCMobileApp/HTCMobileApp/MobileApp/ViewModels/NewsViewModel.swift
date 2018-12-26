//
//  NewsViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class NewsViewModel: BaseViewModel {
    
    let segment: Variable<Int> = Variable(0)
    
    public func transform(source: NewsViewModel.Source) -> NewsViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let canLoadMoreHtcNews: Variable<Bool> = Variable(true)
        let canLoadMoreMarketNews: Variable<Bool> = Variable(true)
//        let canLoadMoreNewsFeed: Variable<Bool> = Variable(true)
        
        let isLoading: Variable<Bool> = Variable(false)
        
        let htcNews: Variable<[NewsModel]> = Variable([])
        let marketAndProducts: Variable<[NewsModel]> = Variable([])
        let newsFeed: Variable<[BaseModel]> = Variable([])
        let isLoadingYoutube: Variable<Bool> = Variable(false)
        let isLoadingFacebook: Variable<Bool> = Variable(false)
        
        let nextYoutubePage: Variable<String> = Variable("")
        let nextFacebookPage: Variable<String> = Variable("")
        
        
        source.segmentIndex.drive(self.segment)
            .disposed(by: disposeBag)
        
        //  HTC news
        let htc = source.segmentIndex
            .filter{$0 == 0}
            .withLatestFrom(htcNews.asDriver())
            .filter{$0.count == 0}
            .flatMap { (index) -> Driver<NewsListModel> in
                if isLoading.value == true {
                    return Driver.empty()
                }
                htcNews.value.removeAll()
                canLoadMoreHtcNews.value = true
                isLoading.value = true
                
                return self.service.getItem(NewsListModel.self, Api.default.getNewsHTC(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        htc.asObservable()
            .subscribe(onNext: { (model) in
                isLoading.value = false
                if let items = model.items, items.count > 0 {
                    
                    var array:[NewsModel] = []
                    for i in 0..<items.count {
                        var model = items[i]
                        if i == 0 {
                            model.setIdentifier(idenfier: NewsCell.identifier)
                        }else {
                            model.setIdentifier(idenfier: LaterNewsCell.identifier)
                        }
                        array.append(model)
                    }
                    htcNews.value.append(contentsOf: array)
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMoreHtcNews.value = false
                    }
                }
            }).disposed(by: disposeBag)
        
        //  Market and products
        let products = source.segmentIndex
            .filter{$0 == 1}
            .withLatestFrom(marketAndProducts.asDriver())
            .filter{$0.count == 0}
            .flatMap {(index) -> Driver<NewsListModel> in
                
                if isLoading.value == true {
                    return Driver.empty()
                }
                marketAndProducts.value.removeAll()
                canLoadMoreMarketNews.value = true
                isLoading.value = true
                
                return self.service.getItem(NewsListModel.self, Api.default.getNewsMarketAndProduct(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        products.asObservable()
            .subscribe(onNext: { (model) in
                isLoading.value = false
                if let items = model.items, items.count > 0 {
                    var array:[NewsModel] = []
                    for i in 0..<items.count {
                        var model = items[i]
                        if i == 0 {
                            model.setIdentifier(idenfier: NewsCell.identifier)
                        }else {
                            model.setIdentifier(idenfier: LaterNewsCell.identifier)
                        }
                        array.append(model)
                    }
                    marketAndProducts.value.append(contentsOf: array)
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadMoreMarketNews.value = false
                    }
                }
            }).disposed(by: disposeBag)
        
        //  Newsfeed
        let youtube = source.segmentIndex
            .filter{$0 == 2}
            .withLatestFrom(newsFeed.asDriver())
            .filter{$0.count == 0}
            .flatMap { _ -> Driver<YoutubeModel> in
                return self.service.getNewsFeedItem(YoutubeModel.self, Api.default.getYoutubeFeed(maxResults: Constants.maxLoadMoreNumber, nextToken: ""))
                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        let facebook = source.segmentIndex
            .filter{$0 == 2}
            .withLatestFrom(newsFeed.asDriver())
            .filter{$0.count == 0}
            .flatMap { _ -> Driver<FacebookModel> in
                return self.service.getNewsFeedItem(FacebookModel.self, Api.default.getFacebookFeed(maxResults: Constants.maxLoadMoreNumber, after: ""))
                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        let feeds = Driver.combineLatest(youtube, facebook)
            .flatMap { (args) -> Driver<[BaseModel]> in
                let (youtubeModel, facebookModel) = args
                
                var results = self.sortNewsfeed(youtubeModel: youtubeModel, facebookModel: facebookModel)
                
                nextYoutubePage.value = youtubeModel.getNextPageToken()
                nextFacebookPage.value = facebookModel.getAfter()
                
                //  Change identifier of the first item
                if results.count > 0 {
                    if var model = results.first as? FacebookItem {
                        model.setIdentifier(idenfier: NewsCell.identifier)
                        results[0] = model
                    }else if var model = results.first as? YoutubeItem {
                        model.setIdentifier(idenfier: NewsCell.identifier)
                        results[0] = model
                    }
                }
                
                return Driver.just(results)
        }
        
        feeds.asObservable()
            .subscribe(onNext: { (items) in
                newsFeed.value.removeAll()
                if items.count > 0 {
                    newsFeed.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        //  Newsfeed refresh
        let refreshYoutube = source.refresh
            .withLatestFrom(source.segmentIndex)
            .filter{$0 == 2}
            .flatMap { _ -> Driver<YoutubeModel> in
                return self.service.getNewsFeedItem(YoutubeModel.self, Api.default.getYoutubeFeed(maxResults: Constants.maxLoadMoreNumber, nextToken: ""))
                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        let refreshFacebook = source.refresh
            .withLatestFrom(source.segmentIndex)
            .filter{$0 == 2}
            .flatMap { _ -> Driver<FacebookModel> in
                return self.service.getNewsFeedItem(FacebookModel.self, Api.default.getFacebookFeed(maxResults: Constants.maxLoadMoreNumber, after: ""))
                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        let refreshNewsfeed = Driver.combineLatest(refreshYoutube, refreshFacebook)
            .flatMap { (args) -> Driver<[BaseModel]> in
                let (youtubeModel, facebookModel) = args
                
                var results = self.sortNewsfeed(youtubeModel: youtubeModel, facebookModel: facebookModel)
                
                nextYoutubePage.value = youtubeModel.getNextPageToken()
                nextFacebookPage.value = facebookModel.getAfter()
                
                //  Change identifier of the first item
                if results.count > 0 {
                    if var model = results.first as? FacebookItem {
                        model.setIdentifier(idenfier: NewsCell.identifier)
                        results[0] = model
                    }else if var model = results.first as? YoutubeItem {
                        model.setIdentifier(idenfier: NewsCell.identifier)
                        results[0] = model
                    }
                }
                
                return Driver.just(results)
        }
        
        refreshNewsfeed.asObservable()
            .subscribe(onNext: { (items) in
                newsFeed.value.removeAll()
                if items.count > 0 {
                    newsFeed.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        //  Loadmore newsfeed
        let youtubeInputs = Driver.combineLatest(source.segmentIndex, isLoadingYoutube.asDriver(), nextYoutubePage.asDriver())
        let loadMoreYoutube = source.loadMore
            .withLatestFrom(youtubeInputs)
            .filter{$0.0 == 2 && $0.1 == false}
            .flatMap({ (args) -> Driver<YoutubeModel> in
                
                let (_, _, nextPage) = args
                if nextPage.isEmpty {
                    return Driver.empty()
                }
                isLoadingYoutube.value = true
                
                return self.service.getNewsFeedItem(YoutubeModel.self, Api.default.getYoutubeFeed(maxResults: Constants.maxLoadMoreNumber, nextToken: nextPage))
                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        let facebookInputs = Driver.combineLatest(source.segmentIndex, isLoadingFacebook.asDriver(), nextFacebookPage.asDriver())
        let loadMoreFacebook = source.loadMore
            .withLatestFrom(facebookInputs)
            .filter{$0.0 == 2 && $0.1 == false}
            .flatMap({ (args) -> Driver<FacebookModel> in
                
                let (_, _, after) = args
                
                if after.isEmpty{
                    return Driver.empty()
                }
                isLoadingFacebook.value = true
                return self.service.getNewsFeedItem(FacebookModel.self, Api.default.getFacebookFeed(maxResults: Constants.maxLoadMoreNumber, after: after))
                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        
        loadMoreYoutube.asObservable()
            .subscribe(onNext: {[weak self] (youtubeModel) in
                
                guard let s = self else {return}
                
                if let items = youtubeModel.items, items.count > 0 {
                    nextYoutubePage.value = youtubeModel.getNextPageToken()
                    
                    var results: [BaseModel] = []
//                    results.append(contentsOf: newsFeed.value)
                    results.append(contentsOf: items)
                    
//                    newsFeed.value.removeAll()
                    newsFeed.value.append(contentsOf: s.sortedWithArray(news: results))
                }
                
                isLoadingYoutube.value = false
                
            }).disposed(by: disposeBag)
        loadMoreFacebook.asObservable()
            .subscribe(onNext: {[weak self] (facebookModel) in
                
                guard let s = self else {return}
                
                if let items = facebookModel.items, items.count > 0 {
                    nextFacebookPage.value = facebookModel.getAfter()
                    
                    var results: [BaseModel] = []
//                    results.append(contentsOf: newsFeed.value)
                    results.append(contentsOf: items)
                    
//                    newsFeed.value.removeAll()
                    newsFeed.value.append(contentsOf: s.sortedWithArray(news: results))
                }
                
                isLoadingFacebook.value = false
                
            }).disposed(by: disposeBag)
        
        //  Refresh
        let refresh = source.refresh
            .withLatestFrom(source.segmentIndex)
            .filter{$0 == 0 || $0 == 1}
            .flatMap({ (index) -> Driver<NewsListModel> in
                
                if isLoading.value == true {
                    return Driver.empty()
                }
                isLoading.value = true
                
                switch index {
                case 0:
                    htcNews.value.removeAll()
                    canLoadMoreHtcNews.value = true
                    return self.service.getItem(NewsListModel.self, Api.default.getNewsHTC(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                case 1:
                    marketAndProducts.value.removeAll()
                    canLoadMoreMarketNews.value = true
                    return self.service.getItem(NewsListModel.self, Api.default.getNewsMarketAndProduct(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                default:
                    return Driver.empty()
                }
            })
        refresh.asObservable()
            .subscribe(onNext: {[weak self] (model) in
                
                isLoading.value = false
                guard let s = self else {return}
                if let items = model.items, items.count > 0 {
                    var array:[NewsModel] = []
                    for i in 0..<items.count {
                        var model = items[i]
                        if i == 0 {
                            model.setIdentifier(idenfier: NewsCell.identifier)
                        }else {
                            model.setIdentifier(idenfier: LaterNewsCell.identifier)
                        }
                        array.append(model)
                    }
                    
                    if s.segment.value == 0 {
                        htcNews.value.append(contentsOf: array)
                        
                        if items.count < Constants.maxLoadMoreNumber {
                            canLoadMoreHtcNews.value = false
                        }
                    }else if s.segment.value == 1 {
                        marketAndProducts.value.append(contentsOf: array)
                        if items.count < Constants.maxLoadMoreNumber {
                            canLoadMoreMarketNews.value = false
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
        //  Load more
        let loadMore = source.loadMore
            .withLatestFrom(Driver.combineLatest(source.segmentIndex, canLoadMoreHtcNews.asDriver(), canLoadMoreMarketNews.asDriver()))
            .filter{($0.0 == 0 && $0.1) || ($0.0 == 1 && $0.2)}
            .flatMap({ (args) -> Driver<NewsListModel> in
                
                if isLoading.value == true {
                    return Driver.empty()
                }
                
                let (index, _, _) = args
                isLoading.value = true
                
                switch index {
                case 0:
                    return self.service.getItem(NewsListModel.self, Api.default.getNewsHTC(skipCount: htcNews.value.count, maxResultCount: Constants.maxLoadMoreNumber))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                case 1:
                    return self.service.getItem(NewsListModel.self, Api.default.getNewsMarketAndProduct(skipCount: marketAndProducts.value.count, maxResultCount: Constants.maxLoadMoreNumber))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                default:
                    return Driver.empty()
                }
        })
        
        loadMore.asObservable()
            .subscribe(onNext: {[weak self] (model) in
                isLoading.value = false
                guard let s = self else {return}
                if let items = model.items, items.count > 0 {
                    var array:[NewsModel] = []
                    for i in 0..<items.count {
                        var model = items[i]
                        model.setIdentifier(idenfier: LaterNewsCell.identifier)
                        array.append(model)
                    }
                    if s.segment.value == 0 {
                        htcNews.value.append(contentsOf: array)
                        
                        if items.count < Constants.maxLoadMoreNumber {
                            canLoadMoreHtcNews.value = false
                        }
                    }else if s.segment.value == 1 {
                        marketAndProducts.value.append(contentsOf: array)
                        if items.count < Constants.maxLoadMoreNumber {
                            canLoadMoreMarketNews.value = false
                        }
                    }
                }
            }).disposed(by: disposeBag)
        
        
        let itemsSource = Driver.combineLatest(source.segmentIndex ,htcNews.asDriver(), marketAndProducts.asDriver(), newsFeed.asDriver())
            .flatMap { (args) -> Driver<[BaseModel]> in
                let (segment, news1, news2, news3) = args
                switch segment {
                case 0:
                    return Driver.just(news1)
                case 1:
                    return Driver.just(news2)
                default:
                    print("Newsfeed count: \(news3.count)")
                    return Driver.just(news3)
                }
        }
        
        return Sink(itemsSource: itemsSource.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
    
    func sortedWithArray(news: [BaseModel]) -> [BaseModel] {
        var results: [BaseModel] = []
        results.append(contentsOf: news)
        results.sort(by: { (item1, item2) -> Bool in
            var date1: Date?
            var date2: Date?
            if let s1 = item1 as? FacebookItem {
                date1 = s1.getDate()
            }else if let s1 = item1 as? YoutubeItem {
                date1 = s1.getDate()
            }
            
            if let s2 = item2 as? FacebookItem {
                date2 = s2.getDate()
            }else if let s2 = item2 as? YoutubeItem {
                date2 = s2.getDate()
            }
            
            guard let d1 = date1, let d2 = date2 else {return false}
            return d1.compare(d2) == ComparisonResult.orderedDescending
        })
        
        //  Change identifier of the first item
//        if results.count > 0 {
//            if var model = results.first as? FacebookItem {
//                model.setIdentifier(idenfier: NewsCell.identifier)
//                results[0] = model
//            }else if var model = results.first as? YoutubeItem {
//                model.setIdentifier(idenfier: NewsCell.identifier)
//                results[0] = model
//            }
//        }
        
        return results
    }
    
    func sortNewsfeed(youtubeModel: YoutubeModel, facebookModel: FacebookModel) -> [BaseModel] {
        var results: [BaseModel] = []
        if let models = youtubeModel.items, models.count > 0 {
            results.append(contentsOf: models)
        }
        
        if let items = facebookModel.items, items.count > 0 {
            results.append(contentsOf: items)
        }
        
        results.sort(by: { (item1, item2) -> Bool in
            var date1: Date?
            var date2: Date?
            if let s1 = item1 as? FacebookItem {
                date1 = s1.getDate()
            }else if let s1 = item1 as? YoutubeItem {
                date1 = s1.getDate()
            }
            
            if let s2 = item2 as? FacebookItem {
                date2 = s2.getDate()
            }else if let s2 = item2 as? YoutubeItem {
                date2 = s2.getDate()
            }
            
            guard let d1 = date1, let d2 = date2 else {return false}
            return d1.compare(d2) == ComparisonResult.orderedDescending
        })
        return results
    }
}

extension NewsViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public var segmentIndex: Driver<Int>
        public let refresh: Driver<Void>
        public let loadMore: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    segmentIndex: Driver<Int>,
                    refresh: Driver<Void>,
                    loadMore: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.segmentIndex = segmentIndex
            self.refresh = refresh
            self.loadMore = loadMore
        }
    }
    
    public struct Sink: SinkType
    {
        public var itemsSource: Driver<[BaseModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
