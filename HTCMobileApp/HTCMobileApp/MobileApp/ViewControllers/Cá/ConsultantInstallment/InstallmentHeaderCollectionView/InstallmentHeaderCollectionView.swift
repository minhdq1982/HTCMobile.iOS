//
//  InstallmentHeaderCollectionView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class InstallmentHeaderCollectionView: UICollectionReusableView {
    
    let disposeBag = DisposeBag()
    @IBOutlet weak var carPriceTextField: CommonTextField!
    @IBOutlet weak var loanTextField: CommonTextField!
    @IBOutlet weak var percentageTextField: CommonTextField!
    @IBOutlet weak var monthsTextField: CommonTextField!
    @IBOutlet weak var interestFirstYearTextField: CommonTextField!
    @IBOutlet weak var interestSecondYearTextField: CommonTextField!
    
    @IBOutlet weak var exportPdfButton: UIButton!
    @IBOutlet weak var calculateButton: CustomButton!
    
    var carPrice: Variable<String> = Variable("")
    var loan: Variable<String> = Variable("")
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let formater = NumberFormatter()
        formater.groupingSeparator = "."
        formater.numberStyle = NumberFormatter.Style.decimal

        carPriceTextField.rx.text.orEmpty.asDriver()
            .drive(carPrice)
            .disposed(by: disposeBag)
        
        loanTextField.rx.text.orEmpty.asDriver()
            .drive(loan)
            .disposed(by: disposeBag)

        interestFirstYearTextField.rx.text.orEmpty
            .asObservable()
            .subscribe(onNext: {[weak self] (text) in
                if !text.isEmpty {
                    if let number = Int(text) {
                        if number < 0 || number > 100 {
                            self?.interestFirstYearTextField.resignFirstResponder()
                        }
                    }
                }
            }).disposed(by: disposeBag)

        interestSecondYearTextField.rx.text.orEmpty
            .asObservable()
            .subscribe(onNext: {[weak self] (text) in
                if !text.isEmpty {
                    if let number = Int(text) {
                        if number < 0 || number > 100 {
                            self?.interestSecondYearTextField.resignFirstResponder()
                        }
                    }
                    
                }
            }).disposed(by: disposeBag)        
        exportPdfButton.layer.borderColor = Colours.themeColor.cgColor
        exportPdfButton.layer.borderWidth = 2.0
    }
}

