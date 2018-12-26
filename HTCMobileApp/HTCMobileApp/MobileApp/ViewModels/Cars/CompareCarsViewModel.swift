//
//  CompareCarsViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/8/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
public class CompareCarsViewModel: BaseViewModel {
    
    public func transform(source: CompareCarsViewModel.Source) -> CompareCarsViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let sections = Driver.combineLatest(source.car1, source.car2, source.segmentIndex)
            .flatMap { (args) -> Driver<[Section]> in
                
                let (car1, car2, segment) = args
                
                var sections: [Section] = []
                //  Header section
                sections.append(Section(header: "", items: []))
                
                switch segment {
                case 0:
                    sections.append(Section(header: "Kích thước lòng thùng (D X R X C)", items: [CompareItem(value1: "3,765 x 1,660 x 1,505", value2: "3,765 x 1,660 x 1,505")]))
                    sections.append(Section(header: "Khoảng nhô trước/sau", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Góc nâng tối đa", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Chiều dài cơ sở (mm)", items: [CompareItem(value1: "2,425", value2: "2,600")]))
                    sections.append(Section(header: "Khoảng sáng gầm xe (mm)", items: [CompareItem(value1: "2,425", value2: "2,600")]))
                case 1:
                    sections.append(Section(header: "Kích thước lòng thùng (D X R X C)", items: [CompareItem(value1: "3,765 x 1,660 x 1,505", value2: "3,765 x 1,660 x 1,505")]))
                    sections.append(Section(header: "Khoảng nhô trước/sau", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Góc nâng tối đa", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Chiều dài cơ sở (mm)", items: [CompareItem(value1: "2,425", value2: "2,600")]))
                    sections.append(Section(header: "Khoảng sáng gầm xe (mm)", items: [CompareItem(value1: "2,425", value2: "2,600")]))
                case 2:
                    sections.append(Section(header: "Kích thước lòng thùng (D X R X C)", items: [CompareItem(value1: "3,765 x 1,660 x 1,505", value2: "3,765 x 1,660 x 1,505")]))
                    sections.append(Section(header: "Khoảng nhô trước/sau", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Góc nâng tối đa", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                case 3:
                    sections.append(Section(header: "Kích thước lòng thùng (D X R X C)", items: [CompareItem(value1: "3,765 x 1,660 x 1,505", value2: "3,765 x 1,660 x 1,505")]))
                    sections.append(Section(header: "Khoảng nhô trước/sau", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Góc nâng tối đa", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                case 4:
                    sections.append(Section(header: "Kích thước lòng thùng (D X R X C)", items: [CompareItem(value1: "3,765 x 1,660 x 1,505", value2: "3,765 x 1,660 x 1,505")]))
                    sections.append(Section(header: "Khoảng nhô trước/sau", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                    sections.append(Section(header: "Góc nâng tối đa", items: [CompareItem(value1: "3,765 x 1,660", value2: "3,765 x 1,660")]))
                default:
                    break
                }
                
                return Driver.just(sections)
        }
        
        return Sink(itemsSource: sections, fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension CompareCarsViewModel: ViewModelType {
    
    public struct Source :SourceType{
        public let viewWillAppear : Driver<Void>
        public let car1: Driver<CarModel>
        public let car2: Driver<CarModel>
        public let segmentIndex: Driver<Int>
        
        public init(viewWillAppear:Driver<Void>,
                    car1: Driver<CarModel>,
                    car2: Driver<CarModel>,
                    segmentIndex: Driver<Int>)
        {
            self.viewWillAppear = viewWillAppear
            self.car1 = car1
            self.car2 = car2
            self.segmentIndex = segmentIndex
        }
    }
    
    public struct Sink: SinkType
    {
        public var itemsSource: Driver<[Section]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
