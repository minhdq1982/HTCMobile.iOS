//
//  DetailCarProfileViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DetailCarProfileViewModel: BaseViewModel {
    func transform(source: DetailCarProfileViewModel.Source) -> DetailCarProfileViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        //  GET car list if needed
        let cars: Variable<[CarModel]> = Variable([])
        if appDelegate.cars.value.count == 0 {
            let items = source.viewWillAppear
                .flatMap { _ -> Driver<[CarModel]> in
                    return self.service.getItems(CarModel.self, Api.default.getCarsList())
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
            }
            
            items.asObservable()
                .subscribe(onNext: { (items) in
                    if items.count > 0 {
                        cars.value.append(contentsOf: items)
                        appDelegate.cars.value += items
                    }
                }).disposed(by: disposeBag)
        }
        
        //  GET agency list if needed
//        if appDelegate.agencies.value.count == 0 {
//            let items = source.viewWillAppear
//                .flatMap { _ -> Driver<[AgencyLocationModel]> in
//                    return self.service.getItems(AgencyLocationModel.self, Api.default.getAgenciesList())
//                        .trackActivity(activityIndicator)
//                        .trackError(errorTracker)
//                        .asDriverOnErrorJustComplete()
//            }
//
//            items.asObservable()
//                .subscribe(onNext: { (items) in
//                    if items.count > 0 {
//                        appDelegate.agencies.value += items
//                    }
//                }).disposed(by: disposeBag)
//        }
        
        let inputs = Driver.combineLatest(source.vinNo, source.lisencePlate, source.carId, source.isAddCar)
        let validateInput = source.saveAction
            .withLatestFrom(inputs)
            .flatMap { (vinno, licensePlate, carId, isAddCar) -> Driver<(Bool, String)> in

                var isValid = true
                var message = ""
                if carId == -1 {
                    message = "Tên xe không được để trống."
                } else if licensePlate.isEmpty  {
                    message = "Biển số xe không được để trống."
                } else if vinno.count > 0 && (!isSpecialCharacter(vinno) || vinno.count != 17) {
                    message = "Số VIN không hợp lệ."
                } else if !isSpecialCharacter(licensePlate) {
                    message = "Biển số xe không hợp lệ."
                }
                
                if !message.isEmpty {
                    isValid = false
                }
                return Driver.just((isValid, message))
        }
        
        //  Add car
        let addInputs = Driver.combineLatest(inputs, validateInput)
        let addCar = source.saveAction
            .withLatestFrom(addInputs)
            .filter{$0.0.3 == true && $0.1.0 == true}
            .flatMap { (args) -> Driver<UserCarModel> in
                
                let (params, _) = args
                let (vinno, licensePlate, carId, isAddCar) = params
                
                if  isAddCar == false {
                    return Driver.empty()
                } else {
                    return self.service.getItem(UserCarModel.self, Api.default.addCar(carId: carId, vinno: vinno, licensePlate: licensePlate))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }
        }
        
        //  Edit car info
        let editInputs = Driver.combineLatest(source.id, inputs, validateInput)
        let editCar = source.saveAction
            .withLatestFrom(editInputs)
            .filter{$0.1.3 == false && $0.2.0 == true}
            .flatMap({ (args) -> Driver<UserCarModel> in
                let (id, params, _) = args
                let (vinno, licensePlate, carId, isAddCar) = params
                
                if isAddCar == true  {
                    return Driver.empty()
                }  else {
                    return self.service.getItem(UserCarModel.self, Api.default.editCar(id: id, carId: carId, vinno: vinno, licensePlate: licensePlate))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }
            })
        
        return Sink(validateInput: validateInput, cars: cars.asDriver(), editCarResponse: editCar, addCarResponse: addCar, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
    
}
extension DetailCarProfileViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let carId : Driver<Int>
        public let id : Driver<Int>
        public let vinNo : Driver<String>
        public let lisencePlate : Driver<String>
//        public let agencyId : Driver<Int>
//        public let boughtDate : Driver<String>
        public let isAddCar : Driver<Bool>
        public let saveAction: Driver<Void>
        
        public init(
            viewWillAppear:Driver<Void>,
            id: Driver<Int>,
            carId : Driver<Int>,
            vinNo : Driver<String>,
            lisencePlate : Driver<String>,
//            agencyId : Driver<Int>,
//            boughtDate : Driver<String>,
            isAddCar : Driver<Bool>,
            saveAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.id = id
            self.carId = carId
            self.vinNo = vinNo
            self.lisencePlate = lisencePlate
//            self.agencyId = agencyId
//            self.boughtDate = boughtDate
            self.isAddCar = isAddCar
            self.saveAction = saveAction
        }
    }
    
    public struct Sink: SinkType {
        public var validateInput: Driver<(Bool, String)>
        public var cars: Driver<[CarModel]>
        public var editCarResponse: Driver<UserCarModel>
        public var addCarResponse: Driver<UserCarModel>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}

