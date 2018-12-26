//
//  MapViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MapKit
public class MapViewModel: BaseViewModel {
    public func transform(source: MapViewModel.Source) -> MapViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let agencies: Variable<[AgencyLocationModel]> = Variable([])
        let isSearching: Variable<Bool> = Variable(false)

        //  Find agency near by
        let nearbyInputs = Driver.combineLatest(source.currentLocation, source.type)
        let nearByAgencies = Driver.merge(source.nearByAction, source.viewWillAppear)
            .withLatestFrom(nearbyInputs)
            .flatMap({ (args) -> Driver<[AgencyLocationModel]> in
                
                isSearching.value = false
                let (location, type) = args
                
                return self.service.getItems(AgencyLocationModel.self, Api.default.getAgenciesNearBy(latitude: location.coordinate.latitude, longgitude: location.coordinate.longitude, type: type))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
                
            })

        nearByAgencies.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    agencies.value.removeAll()
                    agencies.value += items
                }
            }).disposed(by: disposeBag)

        //  For searching agencies
        let searches = Driver.combineLatest( source.searchAgency, source.searchCity, source.currentLocation, source.type)
        let searchModel = source.searchAction
            .withLatestFrom(searches)
//            .filter{(!$0.0.isEmpty || $0.1 != -1)}
            .flatMap { (args) -> Driver<[AgencyLocationModel]> in
                isSearching.value = true
                let (name, city, location, type) = args

                return self.service.getItems(AgencyLocationModel.self, Api.default.getListByCity(agencyName: name, cityId: city, latitude: location.coordinate.latitude, longgitude: location.coordinate.longitude, type: type))
                    .trackActivity(activityIndicator)
                    .trackError(errorTracker)
                    .asDriverOnErrorJustComplete()
        }

        searchModel.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    agencies.value.removeAll()
                    agencies.value += items
                }

            }).disposed(by: disposeBag)
        
        //  Filter action
        let filterInputs = Driver.combineLatest(searches, isSearching.asDriver())
        let filterAction = Driver.merge(source.filterWorkshopAction, source.filterExhibitionAction)
            .withLatestFrom(filterInputs)
            .flatMap { (args) -> Driver<[AgencyLocationModel]> in
                let ((name, city, location, type), searching) = args
                if searching {
                    return self.service.getItems(AgencyLocationModel.self, Api.default.getListByCity(agencyName: name, cityId: city, latitude: location.coordinate.latitude, longgitude: location.coordinate.longitude, type: type))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }else {
                    return self.service.getItems(AgencyLocationModel.self, Api.default.getAgenciesNearBy(latitude: location.coordinate.latitude, longgitude: location.coordinate.longitude, type: type))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }
        }
        filterAction.asObservable()
            .subscribe(onNext: { (items) in
                if items.count > 0 {
                    agencies.value.removeAll()
                    agencies.value += items
                }
            }).disposed(by: disposeBag)
        
        
        //  Get cities if need
        let cities: Variable<[CityModel]> = Variable([])
        if appDelegate.cities.value.count > 0 {
            cities.value += appDelegate.cities.value
        }else{
            let items = source.viewWillAppear
                .flatMap { _ -> Driver<[CityModel]> in
                    return self.service.getItems(CityModel.self, Api.default.getCities())
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
            }
            
            items.asObservable()
                .subscribe(onNext: { (items) in
                    if items.count > 0 {
                        cities.value.removeAll()
                        cities.value += items
                        appDelegate.cities.value += items
                    }
                }).disposed(by: disposeBag)
        }
        
        return Sink(agencyItems: agencies.asDriver(), cities: cities.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension MapViewModel: ViewModelType {
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let nearByAction: Driver<Void>
        public let currentLocation: Driver<CLLocation>
        public let type: Driver<Int>
        public let searchAction: Driver<Void>
        public let searchCity: Driver<Int>
        public let searchAgency: Driver<String>
        public let filterWorkshopAction: Driver<Void>
        public let filterExhibitionAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    nearByAction: Driver<Void>,
                    currentLocation: Driver<CLLocation>,
                    type: Driver<Int>,
                    searchAction: Driver<Void>,
                    searchCity: Driver<Int>,
                    searchAgency: Driver<String>,
                    filterWorkshopAction: Driver<Void>,
                    filterExhibitionAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.nearByAction = nearByAction
            self.currentLocation = currentLocation
            self.type = type
            self.searchAction = searchAction
            self.searchCity = searchCity
            self.searchAgency = searchAgency
            self.filterWorkshopAction = filterWorkshopAction
            self.filterExhibitionAction = filterExhibitionAction
        }
    }
    
    public struct Sink: SinkType
    {
        public var agencyItems: Driver<[AgencyLocationModel]>
        public var cities: Driver<[CityModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
