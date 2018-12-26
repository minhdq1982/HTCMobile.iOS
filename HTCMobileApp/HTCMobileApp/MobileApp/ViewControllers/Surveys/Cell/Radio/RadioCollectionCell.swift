//
//  RadioCollectionCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RadioCollectionCell: BaseCollectionViewCell {
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    let disposeBag = DisposeBag()
    var isSelecButton: Bool?
    var answersModel: AnswerModel?
    

    
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as? AnswerModel {
            answersModel = model
            answerLabel.text = model.getAnswer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func getAnswer() -> String {
        if radioButton.isSelected == true {
            return answerLabel.text ?? ""
        } else {
           return ""
        }
        
        
    }
    func setSelected(_ isSelected: Bool) {
        radioButton.isSelected = isSelected
    }
    
    
}
