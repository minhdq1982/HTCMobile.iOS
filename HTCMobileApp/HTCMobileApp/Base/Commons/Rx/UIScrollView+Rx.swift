//
//  UIScrollView+Rx.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIScrollView {
    public var reachedBottom: ControlEvent<Void> {
        let observable = contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                return y > threshold ? Observable.just({}()) : Observable.empty()
        }
        
        return ControlEvent(events: observable)
    }
    
    
    public var reachedBottomWithoutBounces: ControlEvent<Void> {
        let observable = contentOffset
            .flatMap { [weak base] contentOffset -> Observable<Void> in
                guard let scrollView = base else {
                    return Observable.empty()
                }
                
                let visibleHeight = scrollView.frame.height - scrollView.contentInset.top - scrollView.contentInset.bottom
                let y = contentOffset.y + scrollView.contentInset.top + 0.001
                let threshold = max(0.0, scrollView.contentSize.height - visibleHeight)
                return y > threshold ? Observable.just({}()) : Observable.empty()
        }
        
        return ControlEvent(events: observable)
    }
    
}
