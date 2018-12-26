//
//  LevelCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

protocol LevelCellDelegate {
    func getLevelResult(_ id:Int,_ page: Int, _ question: String, _ answer: String,_ surveyType: String)
}

class LevelCell: BaseTableViewCell {
    
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var questionLabel: UILabel!
    var point: Int = 0
    var delegate: LevelCellDelegate?
    var id: Int?
    var page: Int?
    var question: String?
    var answer: String?
    var surveyType: String?
    
    var questionModel: QuestionModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        
        if let model = data as? QuestionModel {
            self.question = model.getQuestion()
            self.id = model.getId()
            self.surveyType = model.getSurveyType()
            self.page = model.getPage()
            questionLabel.text = model.getQuestion()
            setQuestionStyle(model.getQuestion())
            
            //get Results
            let results: [ResultModel] = ServiceResult.shared.getResult(index: model.getPage())
        
            //update UI
            self.setStatusButton(results: results, id: model.getId(), surveyType: model.getSurveyType())
        
        }
    }
    func setStatusButton(results: [ResultModel], id: Int, surveyType: String) {
        for result in results {
            if id == result.getId() && surveyType == result.getSurveyType() {
                if result.getAnswer() != "" {
                    for button in self.buttons {
                        if "\(button.tag)" ==  result.getAnswer() {
                            button.isSelected = true
                            button.setTitleColor(Colours.white, for: .normal)
                        } else {
                            button.isSelected = false
                            button.setTitleColor(Colours.textColor, for: .normal)
                        }
                    }
                }else {
                    for button in self.buttons {
                        button.isSelected = false
                        button.setTitleColor(Colours.textColor, for: .normal)
                    }
                }
            }
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // set button border
        for button in self.buttons {
            button.layer.borderWidth = 0.5
            button.layer.borderColor = Colours.borderSurveyColor.cgColor
        }
    }
    
    @IBAction func onSelectedPoint(_ sender: UIButton) {
        self.answer = "\(sender.tag)"
        self.delegate?.getLevelResult(self.id ?? -1, self.page ?? -1, self.question ?? "", self.answer ?? "", self.surveyType ?? "")
        
        for button in self.buttons {
            if sender.tag == button.tag {
                button.isSelected = true
                button.setTitleColor(Colours.white, for: .normal)
            }else{
                button.isSelected = false
                button.setTitleColor(Colours.textColor, for: .normal)
            }
        }
    }
    // set question title
    func setQuestionStyle(_ question: String) {
        let string_to_color = "*"
        let range = (question as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: question)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.questionLabel.attributedText = attribute
    }
    
    
}
