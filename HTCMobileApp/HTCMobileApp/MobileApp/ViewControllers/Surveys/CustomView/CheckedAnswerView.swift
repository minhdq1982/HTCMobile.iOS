//
//  CheckedAnswerView.swift
//  HTCMobileApp
//
//  Created by admin on 11/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class CheckedAnswerView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    @IBOutlet var ortherButton: UIButton!
    @IBOutlet var ortherLabel: UILabel!
    
    var answer: String = ""
    let disposeBag = DisposeBag()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.yesButton.rx.tap
            .asObservable()
            .subscribe(onNext: { (_) in
                self.answer = "Có"
                self.yesButton.isSelected = true
                self.noButton.isSelected = false
            }).disposed(by: disposeBag)
        
        self.noButton.rx.tap
            .asObservable()
            .subscribe(onNext: { (_) in
                self.answer = "Không"
                self.noButton.isSelected = true
                self.yesButton.isSelected = false
            }).disposed(by: disposeBag)
    }
}

