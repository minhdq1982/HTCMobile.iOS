//
//  FsCalendarAlertView.swift
//  HTCMobileApp
//
//  Created by admin on 12/13/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar
import RxCocoa
import RxSwift
protocol FsCalendarAlertViewDelegate {
    func sendBeginDate(date: String)
    func sendEndDate(date: String)
}

class FsCalendarAlertView: BaseViewController {
    @IBOutlet weak var cancelButton: UIButton!
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var alertView: FSCalendar!
    var type: String?
    var delegate: FsCalendarAlertViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cancelButton.rx.tapGesture()
            .asObservable()
            .subscribe(onNext: { [weak self] (_) in
                guard let s = self else { return }
                s.dismiss(animated: true, completion: nil)
            }).disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    override func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        alertView.delegate = self
        alertView.dataSource = self
//        titleView.roundCorners(corners: .topLeft, radius: 4.0)
//        titleView.roundCorners(corners: .topRight, radius: 4.0)
//        alertView.roundCorners(corners: .bottomLeft, radius: 4.0)
//        alertView.roundCorners(corners: .bottomRight, radius: 4.0)
       
        
    }
    
    func animateView() {
        
        view.alpha = 0;
        self.view.frame.origin.y = self.view.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.view.alpha = 1.0;
            self.view.frame.origin.y = self.view.frame.origin.y - 50
        })
    }
}

extension FsCalendarAlertView: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let dateString = date.convertToString()
        if let type = self.type {
            if type == "begindate" {
                self.delegate?.sendBeginDate(date: dateString)
            } else if type == "enddate" {
                self.delegate?.sendEndDate(date: dateString)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
extension FsCalendarAlertView: FSCalendarDataSource {
    
}
