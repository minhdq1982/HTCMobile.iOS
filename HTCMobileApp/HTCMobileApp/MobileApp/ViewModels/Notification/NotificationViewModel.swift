//
//  NotificationViewModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class NotificationViewModel: BaseViewModel {
    func transform(source: NotificationViewModel.Source) -> NotificationViewModel.Sink {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        let notificationModels = [NotificationModel(id: 0,
                                                    image: "http://domainname/images/notifications/type1.jpg",
                                                    title: "Thông báo",
                                                    shortContent: "Bạn có một lịch hẹn với đại lý Huyndai Giải Phóng",
                                                    fullContent: "Bạn có một lịch hẹn với đại lý Huyndai Giải Phóng ngày 01/01/2018....",
                                                    read: false,
                                                    type: 0,
                                                    detailId: 123456,
                                                    createdDate: "2018-11-09 14:16:27",
                                                    modifiedDate: "2018-11-09 14:16:27"),
                                  NotificationModel(id: 0,
                                                    image: "http://domainname/images/notifications/type1.jpg",
                                                    title: "Thông báo",
                                                    shortContent: "Bạn có một lịch hẹn với đại lý Huyndai Giải Phóng",
                                                    fullContent: "Bạn có một lịch hẹn với đại lý Huyndai Giải Phóng ngày 01/01/2018....",
                                                    read: true,
                                                    type: 1,
                                                    detailId: 123456,
                                                    createdDate: "2018-11-10 14:16:27",
                                                    modifiedDate: "2018-11-10 14:16:27"),
                                  NotificationModel(id: 0,
                                                    image: "http://domainname/images/notifications/type1.jpg",
                                                    title: "Thông báo",
                                                    shortContent: "Bạn có một lịch hẹn với đại lý Huyndai Giải Phóng",
                                                    fullContent: "Bạn có một lịch hẹn với đại lý Huyndai Giải Phóng ngày 01/01/2018....",
                                                    read: true,
                                                    type: 2,
                                                    detailId: 123456,
                                                    createdDate: "2018-11-08 14:16:27",
                                                    modifiedDate: "2018-11-08 14:16:27")]
        var sections: [Section] = []
        for model in notificationModels {
            let milisecondInput = model.getCreatedDate().convertStringToMilisecond(format: "yyyy-MM-dd HH:mm:ss")
            let createdDate = milisecondInput.convertToDateString(format: "yyyy-MM-dd")
            let milisecondCreatedDate = createdDate.convertStringToMilisecond(format: "yyyy-MM-dd")
            print("Mili Input \(milisecondInput)")
            
            
            // get today
            let date = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            let result = formatter.string(from: date)
            let milisecondToday = result.convertStringToMilisecond(format: "yyyy-MM-dd")

            
            let dayInput = Int(milisecondCreatedDate.getDay())!
            let monthInput = Int(milisecondCreatedDate.getMonth())!
            let yearInput = Int(milisecondCreatedDate.getYear())!
            
            print("Input \(dayInput) - \(monthInput) - \(yearInput) ")
            
            let dayNow = Int(milisecondToday.getDay())!
            let monthNow = Int(milisecondToday.getMonth())!
            let yearNow = Int(milisecondToday.getYear())!
            
            print("Now \(dayNow) - \(monthNow) - \(yearNow) ")
            
            
            if yearNow == yearInput && monthNow == monthInput && dayNow == dayInput {
                 sections.append(Section(header: "Hôm nay", items: notificationModels))
            } else if yearNow == yearInput && monthNow == monthInput && dayNow - dayInput == 1 {
                 sections.append(Section(header: "Hôm qua", items: notificationModels))
            } else {
                 sections.append(Section(header: createdDate, items: notificationModels))
            }
            
            
           
            
           
            
            
            
            
          
        }
        
        return Sink(itemsSource: Driver.just(sections),fetching: activityIndicator.asDriver(), error: errorTracker.asDriver())
    }
}

extension NotificationViewModel: ViewModelType {
    public struct Source: SourceType {
        public let viewWillAppear : Driver<Void>
        
        public init(viewWillAppear:Driver<Void>)
        {
            self.viewWillAppear = viewWillAppear
        }
    }
    
    public struct Sink: SinkType {
        public var itemsSource: Driver<[Section]>
        public var fetching: Driver<Bool>?
        public var error: Driver<Error>?
    }
}
