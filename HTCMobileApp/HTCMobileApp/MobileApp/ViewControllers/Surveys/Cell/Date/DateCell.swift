//
//  DateCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift
import ActionSheetPicker_3_0

protocol DateCellDelegate {
    func getDateResult(_ id:Int,_ page: Int, _ question: String, _ answer: String, _ surveyType: String)
}

class DateCell: BaseTableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var answerTextField: UITextField!
    @IBAction func onSelectDate(_ sender: Any) {
        let datePicker = ActionSheetDatePicker(title: "CHỌN NGÀY", datePickerMode: .date, selectedDate: Date(), target: self, action: #selector(datePicked(_:)), origin: sender)
        datePicker?.show()
    }
    var question: String?
    var answer: String?
    var id: Int?
    var page: Int?
    var surveyType: String?
    var questionModel: QuestionModel?
    var delegate: SpinnerCellDelegate?
    let results: Variable<[ResultModel]> = Variable([])
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        
        if let model = data as? QuestionModel {
            questionModel = model
            // set UI
//            let datasourceType = model.getDataSourceType()
            self.id = model.getId()
            self.page = model.getPage()
            self.question = model.getQuestion()
            self.surveyType = model.getSurveyType()
            setQuestionStyle(model.getQuestion())
            
            self.questionLabel.text = model.getQuestion()
            
            // get Result
            self.results.value = ServiceResult.shared.getResult(index: self.page ?? 0)
            
            for result in results.value {
                if model.getId() == result.getId() && model.getSurveyType() == result.getSurveyType() {
                    if result.getAnswer() != "" {
                        answerTextField.text = result.getAnswer()
                    } else {
                        answerTextField.text = ""
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.borderView.layer.borderWidth =  1.0
        self.borderView.layer.borderColor = Colours.borderSurveyColor.cgColor
        
    }
   
    
    @objc func datePicked(_ obj: Date) {
        print(obj.description)
        let str = obj.convertToString()
        self.answerTextField.text = str
        self.answer = str
        self.delegate?.getSpinnerResult(self.id ?? -1, self.page ?? -1, self.question ?? "", self.answer ?? "", self.surveyType ?? "")
        print(str)
    }
    
    func setQuestionStyle(_ question: String) {
        let string_to_color = "*"
        let range = (question as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: question)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.questionLabel.attributedText = attribute
    }
  
    
}
