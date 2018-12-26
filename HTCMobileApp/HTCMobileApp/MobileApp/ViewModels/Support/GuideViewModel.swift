//
//  GuideViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/1/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class GuideViewModel: BaseViewModel {
    
    public func transform(source: GuideViewModel.Source) -> GuideViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
                
        let warantiesSource: Variable<[WarrantyPolicyModel]> = Variable([])
        
        let technicalsSource: Variable<[TechnicalGuidanceModel]> = Variable([])
        
        let guideBooksSource: Variable<[BookGuidanceModel]> = Variable([])
        
        let isLoadingTechnicals: Variable<Bool> = Variable(false)
        let isLoadingBooks: Variable<Bool> = Variable(false)
        
        let canLoadmore: Variable<Bool> = Variable(true)
        
        //  Load warranties
        let warranties = source.segmentIndex.asDriver()
            .filter{$0 == 2}
            .withLatestFrom(warantiesSource.asDriver())
            .filter{$0.count == 0}
            .flatMap { _ -> Driver<[WarrantyPolicyModel]> in
                
                return self.service.getItems(WarrantyPolicyModel.self, Api.default.getWarrantyList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        warranties.asObservable()
            .subscribe(onNext: { (items) in
                warantiesSource.value.removeAll()
                if items.count > 0 {
                    warantiesSource.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        //  Load technical guide
        
        let technicals = Driver.combineLatest(source.segmentIndex, source.technicalSearchText)
            .filter{$0.0 == 0 && $0.1.isEmpty}
            .flatMap({ _ -> Driver<[TechnicalGuidanceModel]> in
                
                if isLoadingTechnicals.value == true {
                    return Driver.empty()
                }
                
                isLoadingTechnicals.value = true
                canLoadmore.value = true
                technicalsSource.value.removeAll()
                
                return self.service.getItems(TechnicalGuidanceModel.self, Api.default.getTechnicalGuideList(name: "", skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        })
        
        technicals.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    technicalsSource.value.append(contentsOf: items)
                    //  Change first items
                    var firstItem = items[0]
                    firstItem.setIdentifier(TechnicalGuidanceCell.identifier)
                    technicalsSource.value[0] = firstItem
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadmore.value = false
                    }
                }
                
                isLoadingTechnicals.value = false
                
            }).disposed(by: disposeBag)
        
        let loadMoreTechnicals = source.loadMoreTechicalAction
            .skip(1)
            .throttle(1)
            .withLatestFrom(source.technicalSearchText)
            .flatMap { (name) -> Driver<[TechnicalGuidanceModel]> in
                
                if canLoadmore.value == false || isLoadingTechnicals.value == true {
                    return Driver.empty()
                }
                
                isLoadingTechnicals.value = true
                print("Loadmore technical")
                
                return self.service.getItems(TechnicalGuidanceModel.self, Api.default.getTechnicalGuideList(name: name, skipCount: technicalsSource.value.count, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        loadMoreTechnicals.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    technicalsSource.value.append(contentsOf: items)
                }
                if items.count < Constants.maxLoadMoreNumber {
                    canLoadmore.value = false
                }
                isLoadingTechnicals.value = false
            }).disposed(by: disposeBag)
        
        //  Technical search
        let technicalInputs = Driver.combineLatest(source.segmentIndex, source.technicalSearchText)
        
        let technicalSearch = Driver.merge(source.searchAction, source.endEditingAction)
            .withLatestFrom(technicalInputs)
            .filter{$0.0 == 0 && !$0.1.trimmingCharacters(in: .whitespaces).isEmpty}
            .flatMap { (args) -> Driver<[TechnicalGuidanceModel]> in
                
                isLoadingTechnicals.value = true
                canLoadmore.value = true
                technicalsSource.value.removeAll()
                
                let (_, name) = args
                let textTrimed = name.trimmingCharacters(in: .whitespaces)
                
                return self.service.getItems(TechnicalGuidanceModel.self, Api.default.getTechnicalGuideList(name: textTrimed, skipCount: technicalsSource.value.count, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        technicalSearch.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    technicalsSource.value.append(contentsOf: items)
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadmore.value = false
                    }
                }
                isLoadingTechnicals.value = false
            }).disposed(by: disposeBag)
        
        //  Refresh
        let refresh = source.technicalRefresh
            .withLatestFrom(Driver.combineLatest(source.segmentIndex, source.technicalSearchText))
            .filter{$0.0 == 0}
            .flatMap({ (args) -> Driver<[TechnicalGuidanceModel]> in
                
                if isLoadingTechnicals.value == true {
                    return Driver.empty()
                }
                
                isLoadingTechnicals.value = true
                canLoadmore.value = true
                technicalsSource.value.removeAll()
                
                return self.service.getItems(TechnicalGuidanceModel.self, Api.default.getTechnicalGuideList(name: args.1, skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
            })
        refresh.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    technicalsSource.value.append(contentsOf: items)
                    //  Change first items
                    var firstItem = items[0]
                    firstItem.setIdentifier(TechnicalGuidanceCell.identifier)
                    technicalsSource.value[0] = firstItem
                    
                    if items.count < Constants.maxLoadMoreNumber {
                        canLoadmore.value = false
                    }
                }
                
                isLoadingTechnicals.value = false
                
            }).disposed(by: disposeBag)
        
        //  Load guide books source
        
        let books = source.segmentIndex.asDriver()
            .filter{$0 == 1}
            .flatMap { (_) -> Driver<BookGuidancesModel> in
                
                canLoadmore.value = true
                isLoadingBooks.value = true
                guideBooksSource.value.removeAll()
                
                return self.service.getItem(BookGuidancesModel.self, Api.default.getGuidebookList(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, keySearch: ""))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        books.asObservable()
            .subscribe(onNext: { (model) in
                if let items = model.items, items.count > 0 {
                    guideBooksSource.value.append(contentsOf: items)
                    
                    if items.count < Constants.maxLoadMoreNumber{
                        canLoadmore.value = false
                    }
                }
                isLoadingBooks.value = false
            }).disposed(by: disposeBag)
        
        //  Guide book load more
        let bookMoreInputs = Driver.combineLatest(isLoadingBooks.asDriver(), canLoadmore.asDriver())
        let loadMoreBooks = source.loadMoreGuideBookAction
            .skip(1)
            .throttle(1)
            .withLatestFrom(bookMoreInputs)
            .filter{$0.0 == false && $0.1 == true}
            .flatMap { (args) -> Driver<BookGuidancesModel> in
                
                isLoadingBooks.value = true
                
                return self.service.getItem(BookGuidancesModel.self, Api.default.getGuidebookList(skipCount: guideBooksSource.value.count, maxResultCount: Constants.maxLoadMoreNumber, keySearch: ""))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        loadMoreBooks.asObservable()
            .subscribe(onNext: { (model) in
                if let items = model.items, items.count > 0 {
                    guideBooksSource.value.append(contentsOf: items)
                    
                    if items.count < Constants.maxLoadMoreNumber{
                        canLoadmore.value = false
                    }
                }
                isLoadingBooks.value = false
                
            }).disposed(by: disposeBag)
        
        //  Guide book search
        let bookSearch = Driver.combineLatest(source.segmentIndex, source.guideBookSearchText, guideBooksSource.asDriver())
            .filter{$0.0 == 1}
            .flatMap { (args) -> Driver<[BookGuidanceModel]> in
                let (_, searchText, books) = args
                let textTrimed = searchText.trimmingCharacters(in: .whitespaces)
                if textTrimed.isEmpty {
                    return Driver.just(books)
                }else{
                    let result = books.filter{$0.title?.localizedCaseInsensitiveContains(textTrimed) == true}
                    return Driver.just(result)
                }
        }
        
        //  Refresh books
        let guideRefresh = source.guideBookRefresh
            .withLatestFrom(Driver.combineLatest(source.segmentIndex, source.guideBookSearchText))
            .filter{$0.0 == 1}
            .flatMap({ (args) -> Driver<BookGuidancesModel> in
                    
                    canLoadmore.value = true
                    isLoadingBooks.value = true
                    guideBooksSource.value.removeAll()
                    
                    return self.service.getItem(BookGuidancesModel.self, Api.default.getGuidebookList(skipCount: 0, maxResultCount: Constants.maxLoadMoreNumber, keySearch: ""))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                })
                
        guideRefresh.asObservable()
            .subscribe(onNext: { (model) in
                if let items = model.items, items.count > 0 {
                    guideBooksSource.value.append(contentsOf: items)
                    
                    if items.count < Constants.maxLoadMoreNumber{
                        canLoadmore.value = false
                    }
                }
                isLoadingBooks.value = false
            }).disposed(by: disposeBag)
        
        return Sink(warantiesSource: warantiesSource.asDriver(), technicalsSource: technicalsSource.asDriver(), guideBooksSource: bookSearch, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension GuideViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let segmentIndex: Driver<Int>
        public let searchAction: Driver<Void>
        public let endEditingAction: Driver<Void>
        public let technicalRefresh: Driver<Void>
        public let guideBookRefresh: Driver<Void>
        public let technicalSearchText: Driver<String>
        public let guideBookSearchText: Driver<String>
        public let loadMoreTechicalAction: Driver<Void>
        public let loadMoreGuideBookAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    segmentIndex: Driver<Int>,
                    searchAction: Driver<Void>,
                    endEditingAction: Driver<Void>,
                    technicalRefresh: Driver<Void>,
                    guideBookRefresh: Driver<Void>,
                    technicalSearchText: Driver<String>,
                    guideBookSearchText: Driver<String>,
                    loadMoreTechicalAction: Driver<Void>,
                    loadMoreGuideBookAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.segmentIndex = segmentIndex
            self.searchAction = searchAction
            self.endEditingAction = endEditingAction
            self.technicalRefresh = technicalRefresh
            self.guideBookRefresh = guideBookRefresh
            self.technicalSearchText = technicalSearchText
            self.guideBookSearchText = guideBookSearchText
            self.loadMoreTechicalAction = loadMoreTechicalAction
            self.loadMoreGuideBookAction = loadMoreGuideBookAction
        }
    }
    
    public struct Sink: SinkType
    {
        public var warantiesSource: Driver<[WarrantyPolicyModel]>
        public var technicalsSource: Driver<[TechnicalGuidanceModel]>
        public var guideBooksSource: Driver<[BookGuidanceModel]>
        
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
