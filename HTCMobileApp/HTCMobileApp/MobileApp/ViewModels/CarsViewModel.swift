//
//  CarsViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class CarsViewModel: BaseViewModel {
    
    public func transform(source: CarsViewModel.Source) -> CarsViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
//        let titles: [String] = ["Xe du lịch", "Xe SUV, xe MVP", "Xe thương mại"]
        var sections: [Section] = []
        
        sections.append(Section(header: "", items: [
            CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "NHẤN NÚT KHỞI ĐỘNG CUỘC SỐNG MỚI", shortDescription: "- Thiết kế hiện đại, thể thao \n- Nội thất cao cấp, sang trọng và phong cách", image: ["https://image-us.24h.com.vn/upload/2-2018/images/2018-04-17/1523940026-901-img_9927_vlyo-1523778128-width660height495.jpg"], price: 500000000, unit: "VND"),
            CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "NHẤN NÚT KHỞI ĐỘNG CUỘC SỐNG MỚI", shortDescription: "- Thiết kế hiện đại, thể thao \n- Nội thất cao cấp, sang trọng và phong cách", image: ["https://image-us.24h.com.vn/upload/2-2018/images/2018-04-17/1523940026-901-img_9927_vlyo-1523778128-width660height495.jpg"], price: 500000000, unit: "VND"),
            CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "NHẤN NÚT KHỞI ĐỘNG CUỘC SỐNG MỚI", shortDescription: "- Thiết kế hiện đại, thể thao \n- Nội thất cao cấp, sang trọng và phong cách", image: ["https://image-us.24h.com.vn/upload/2-2018/images/2018-04-17/1523940026-901-img_9927_vlyo-1523778128-width660height495.jpg"], price: 500000000, unit: "VND"),
            CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "NHẤN NÚT KHỞI ĐỘNG CUỘC SỐNG MỚI", shortDescription: "- Thiết kế hiện đại, thể thao \n- Nội thất cao cấp, sang trọng và phong cách", image: ["https://image-us.24h.com.vn/upload/2-2018/images/2018-04-17/1523940026-901-img_9927_vlyo-1523778128-width660height495.jpg"], price: 500000000, unit: "VND")]))
        
        
        return Sink(itemsSource: Driver.just(sections),fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension CarsViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType
    {
        public var itemsSource: Driver<[Section]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
