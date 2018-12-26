//
//  AddAppointmentViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class AddAppointmentViewModel: BaseViewModel {
    
    public func transform(source: AddAppointmentViewModel.Source) -> AddAppointmentViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
//        let serviceItems = source.viewWillAppear
//            .flatMap { (_) -> Driver<[ServiceItem]> in
//                return self.service.getItems(ServiceItem.self, Api.default.)
//        }
        var serviceItems: [ServiceItem] = []
        serviceItems.append(ServiceItem(id: 0, name: "Bảo hành"))
        serviceItems.append(ServiceItem(id: 1, name: "Bảo dưỡng"))
        serviceItems.append(ServiceItem(id: 2, name: "Sửa chữa chung"))
        serviceItems.append(ServiceItem(id: 3, name: "Sửa thân xe và sơn"))
        serviceItems.append(ServiceItem(id: 2, name: "Kiểm tra và triệu hồi"))
        
        return Sink(serviceItems: Driver.just(serviceItems) ,fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension AddAppointmentViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let doneAction: Driver<Void>
        
        public init(viewWillAppear:Driver<Void>,
                    doneAction: Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
            self.doneAction = doneAction
        }
    }
    
    public struct Sink: SinkType
    {
        public var serviceItems: Driver<[ServiceItem]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
