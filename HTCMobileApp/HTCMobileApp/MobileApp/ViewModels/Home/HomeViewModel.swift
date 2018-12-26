//
//  HomeViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class HomeViewModel: BaseViewModel {
    
    public func transform(source: HomeViewModel.Source) -> HomeViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let memberships: Variable<[CardModel]> = Variable([])
        let news: Variable<[GroupNewsModel]> = Variable([])
        
        //  Get setting
        let setting = source.viewWillAppear
            .filter{appDelegate.setting == nil}
            .flatMap { (_) -> Driver<SettingsModel> in
                return self.service.getItem(SettingsModel.self, Api.default.getSettings())
//                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        setting.asObservable()
            .subscribe(onNext: { (model) in
                appDelegate.setting = model
            }).disposed(by: disposeBag)
        
        
        let membershipList =  source.viewWillAppear
            .withLatestFrom(source.forceUpdate)
            .filter{$0 == true && UserPrefsHelper.shared.isLoggedIn()}
            .flatMap { _ -> Driver<[CardModel]> in
                return self.service.getItems(CardModel.self, Api.default.getMembershipList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        membershipList.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    memberships.value.removeAll()
                    memberships.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        let groupNews = source.viewWillAppear
            .withLatestFrom(source.forceUpdate)
            .filter{$0 == true}
            .flatMap { _ -> Driver<[GroupNewsModel]> in
                return self.service.getItems(GroupNewsModel.self, Api.default.getNewsGroupList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        groupNews.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    news.value.removeAll()
                    news.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        //  Refresh datas
        let members =  source.refreshAction
            .filter{UserPrefsHelper.shared.isLoggedIn()}
            .flatMap { _ -> Driver<[CardModel]> in
                return self.service.getItems(CardModel.self, Api.default.getMembershipList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        
        members.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    memberships.value.removeAll()
                    memberships.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        let groups = source.refreshAction
            .flatMap { _ -> Driver<[GroupNewsModel]> in
                return self.service.getItems(GroupNewsModel.self, Api.default.getNewsGroupList())
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }
        groups.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    news.value.removeAll()
                    news.value.append(contentsOf: items)
                }
            }).disposed(by: disposeBag)
        
        
        
        let surveys = source.viewWillAppear
            .filter{UserPrefsHelper.shared.isLoggedIn()}
            .flatMap { _ -> Driver<HomeSurveyModel> in
                return self.service.getItem(HomeSurveyModel.self, Api.default.getSurvey(phone: UserPrefsHelper.shared.getUserPhone()))
//                    .trackActivity(activityIndicator)
//                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }.startWith(HomeSurveyModel(surveyType: -1))
        
        let sections:Variable<[Section]> = Variable([])
        let checkLogin = Driver.combineLatest(source.isLoggedIn, memberships.asDriver(), news.asDriver(), surveys)
            .flatMap { (args) -> Driver<[Section]> in
                
                let (isLoggedIn, cards, groupNews, survey) = args
                
                sections.value.removeAll()
                
                if isLoggedIn == true {
                    if cards.count > 0 {
                        sections.value.append(Section(header: "", items: [GroupCardModel(cards: cards)]))
                    }else{
                        sections.value.append(Section(header: "", items: [HomeAddCardModel()]))
                    }
                    
                }else {
                    if UserPrefsHelper.shared.isDisableLoginSection() == false {
                        //  Add login section
                        sections.value.append(Section(header: "", items: [HomeLoginModel()]))
                    }
                }
                
                //  banner section
                sections.value.append(Section(header: "", items: [BannerModel()]))
                
                //  News
                if groupNews.count > 0 {
                    for group in groupNews {
                        let items: [BaseModel] = [GroupNewsHeaderModel(id: group.getId(), name: group.getName()), group]
                        let newsSection = Section(header: "", items: items)
                        sections.value.append(newsSection)
                    }
                }
                
                //  Survey section
//                if survey.surveyType != -1 {
//                    let surveySection = Section(header: "", items: [survey])
//                    sections.value.append(surveySection)
//                }
                
                //  Hard code survey
                let surveySection = Section(header: "", items: [HomeSurveyModel(surveyType: 0)])
                sections.value.append(surveySection)
                
                //  Contact section
                let contact = ContactUsModel()
                let contactSection = Section(header: "", items: [contact])
                sections.value.append(contactSection)
                
                return sections.asDriver()
        }
        
        checkLogin.asObservable()
            .subscribe(onNext: { _ in
                
            }).disposed(by: disposeBag)
        
        //  Observer if user disable login
        source.isDisableLogin
            .asObservable()
            .subscribe(onNext: { (isDisable) in
                if isDisable == true && sections.value.count > 0{
                    let section = sections.value.first
                    if (section?.items[0] as? HomeLoginModel) != nil {
                        sections.value.removeFirst()
                    }
                }
            }).disposed(by: disposeBag)
        
        return Sink(itemsSource: sections.asDriver(), listMembership: membershipList, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension HomeViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let isLoggedIn: Driver<Bool>
        public let isDisableLogin: Driver<Bool>
        public let refreshAction: Driver<Void>
        public let forceUpdate: Driver<Bool>
        
        public init(viewWillAppear:Driver<Void>,
                    isLoggedIn: Driver<Bool>,
                    isDisableLogin: Driver<Bool>,
                    refreshAction: Driver<Void>,
                    forceUpdate: Driver<Bool>)
        {
            self.viewWillAppear = viewWillAppear
            self.isLoggedIn = isLoggedIn
            self.isDisableLogin = isDisableLogin
            self.refreshAction = refreshAction
            self.forceUpdate = forceUpdate
        }
    }
    
    public struct Sink: SinkType
    {
        public var itemsSource: Driver<[Section]>
        public var listMembership: Driver<[CardModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
