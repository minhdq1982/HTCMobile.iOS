//
//  UserCarViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class UserCarViewModel: BaseViewModel {
    public func transform(source: UserCarViewModel.Source) -> UserCarViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()

        let userCars: Variable<[UserCarModel]> = Variable([])

        let deleteInputs = Driver.combineLatest(source.isDeletingCar, source.deleteCarId)
        let deleteCarResponse = deleteInputs.flatMap { (args) -> Driver<BaseResponse> in
                let (isDeleting, deleteCarId) = args
            
             print("ID: \(deleteCarId)")
             print("Deleting Car: \(isDeleting)")
            
                if isDeleting == true && deleteCarId != -1 {
                    return self.service.getAllResponse(BaseResponse.self, Api.default.deleteCar(id: deleteCarId))
                        .trackActivity(activityIndicator)
                        .trackError(errorTracker)
                        .asDriverOnErrorJustComplete()
                }else{
                    return Driver.empty()
                }
        }
            source.cars.asObservable()
            .subscribe(onNext: { (cars) in
                userCars.value.removeAll()
                if cars.count > 0 {
                    userCars.value += cars
                }
            }).disposed(by: disposeBag)
        
        return Sink(deleteCarResponse: deleteCarResponse, itemsSource: userCars.asDriver(), fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
    
}
extension UserCarViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        public let cars: Driver<[UserCarModel]>
        public let deleteCarId: Driver<Int>
        public let isDeletingCar: Driver<Bool>
        
        public init(viewWillAppear:Driver<Void>,
                    cars: Driver<[UserCarModel]>,
                    deleteCarId: Driver<Int>,
                    isDeletingCar: Driver<Bool>)
        {
            self.viewWillAppear = viewWillAppear
            self.cars = cars
            self.deleteCarId = deleteCarId
            self.isDeletingCar = isDeletingCar
        }
    }
    
    public struct Sink: SinkType {
        public var deleteCarResponse: Driver<BaseResponse>
        public var itemsSource: Driver<[UserCarModel]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
    
    
}
