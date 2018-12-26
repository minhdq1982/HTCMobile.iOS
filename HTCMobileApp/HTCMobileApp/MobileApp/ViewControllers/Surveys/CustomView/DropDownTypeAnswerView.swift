//
//  DropDownTypeAnswerView.swift
//  HTCMobileApp
//
//  Created by admin on 11/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import DropDown
import RxCocoa
import RxSwift

class DropDownTypeAnswerView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var answerTextField: UITextField!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    let dropDown = DropDown()
    
    let arr = ["Hyundai Thành Công", "Hyundai Bà Rịa Vũng Tàu", "Hyundai Dương Nội"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.borderView.layer.borderWidth = 1.0
        self.borderView.layer.borderColor = Colours.borderSurveyColor.cgColor
    }
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        initView()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        super.init(coder: aDecoder)
//        initView()
//    }
//
//    fileprivate func initView() {
//        self.dropDownButton.rx.tap
//            .asObservable()
//            .subscribe(onNext: { (_) in
//                self.showMenuDropDown()
//            })
//
//    }
    
    @IBAction func onSelect(_ sender: Any) {
        self.showMenuDropDown()
    }
    
    func showMenuDropDown() {
        dropDown.anchorView = borderView
        dropDown.direction = .bottom
        dropDown.dataSource = arr
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.answerTextField.text = item
        }
        dropDown.show()
    }
    
}
