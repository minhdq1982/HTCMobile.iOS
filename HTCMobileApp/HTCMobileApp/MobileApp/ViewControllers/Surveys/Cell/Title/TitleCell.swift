//
//  TitleCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class TitleCell: BaseTableViewCell {

    @IBOutlet weak var firstNoteLabel: UILabel!
    @IBOutlet weak var thirdNoteLabel: UILabel!
    @IBOutlet weak var secondNoteLabel: UILabel!
    
    var question: QuestionModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
            if let model = data as? QuestionModel {
                question = model
                if model.getQuestion() == "" {
                    secondNoteLabel.text = ""
                    thirdNoteLabel.text = ""
                } else {
                    secondNoteLabel.text = "(Mức: 1 = Kém nhất, 10 = Tốt nhất)"
                    thirdNoteLabel.text = "Vui lòng đánh giá các mục dưới đây"
                }
            }
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
}
