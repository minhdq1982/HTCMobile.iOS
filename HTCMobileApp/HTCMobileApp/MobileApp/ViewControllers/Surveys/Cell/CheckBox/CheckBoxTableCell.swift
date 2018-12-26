//
//  CheckBoxTableCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class CheckBoxTableCell: BaseTableViewCell {
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var otherTextField: UITextField!
    @IBOutlet weak var answerLabel: UILabel!
    let disposeBag = DisposeBag()
    var answerModel: AnswerModel?
    @IBOutlet weak var otherLabel: UILabel!
    let otherAnswer: Variable<String> = Variable("")
    var answer: String?
    
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as? AnswerModel {
            answerLabel.text = model.getAnswer()
            if model.getAnswer() == "" {
                otherTextField.isHidden = false
                otherLabel.isHidden = false
            } else {
                otherTextField.isHidden = true
                otherLabel.isHidden = true
            }
            
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        
    }
    func setStatusButton() {
        if checkBoxButton.isSelected == true {
            checkBoxButton.isSelected = false
        } else {
            checkBoxButton.isSelected = true
            
        }
    }

    
//    func getAnwser(){
//        if checkBoxButton.isSelected == true {
//            self.answer = answerLabel.text ?? ""
//        } else {
//            self.answer = ""
//        }
//    }
    
    
}
