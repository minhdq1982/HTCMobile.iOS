//
//  TextCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol TextCellDelegate {
    func getTextResult(_ id:Int,_ page: Int, _ question: String, _ answer: String,_ surveyType: String)
}

class TextCell: BaseTableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var answerTextField: UITextField!
    let disposeBag = DisposeBag()
    var delegate: TextCellDelegate?
    var questionModel: QuestionModel?
    var question: String?
    var page: Int?
    var id: Int?
    var surveyType: String?
    var answer: String?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as?  QuestionModel {
            self.page = model.getPage()
            self.id = model.getId()
            self.question = model.getQuestion()
            self.surveyType = model.getSurveyType()
            setQuestionStyle(model.getQuestion())
            
               // get Result
            let results = ServiceResult.shared.getResult(index: model.getPage())
            
            // update UI
            for result in results {
                if id == result.getId() && surveyType == result.getSurveyType() {
                    self.answerTextField.text = result.getAnswer()
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.borderView.layer.borderWidth =  1.0
        self.borderView.layer.borderColor = Colours.borderSurveyColor.cgColor
        
        
        self.answerTextField.rx.text.orEmpty
            .asObservable()
            .subscribe(onNext: { [weak self] (text) in
                self?.delegate?.getTextResult(self?.id ?? -1, self?.page ?? -1, self?.question ?? "", text, self?.surveyType ?? "")
            }).disposed(by: disposeBag)
    }
    
    func setQuestionStyle(_ question: String) {
        let string_to_color = "*"
        let range = (question as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: question)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.questionLabel.attributedText = attribute
    }
    
}
