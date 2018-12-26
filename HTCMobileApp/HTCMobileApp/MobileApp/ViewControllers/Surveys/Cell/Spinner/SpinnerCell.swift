//
//  SpinnerCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import DropDown
import RxCocoa
import RxSwift

protocol SpinnerCellDelegate {
    func getSpinnerResult(_ id:Int,_ page: Int, _ question: String, _ answer: String, _ surveyType: String)
}

class SpinnerCell: BaseTableViewCell {
//    let arr = ["Hyundai Thành Công", "Hyundai Bà Rịa Vũng Tàu", "Hyundai Dương Nội"]
    let dropDown = DropDown()
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var dropDownButton: UIButton!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var answerTextField: UITextField!
    var question: String?
    var answer: String?
    var id: Int?
    var page: Int?
    var surveyType: String?
    var arr: [String] = []
    let results: Variable<[ResultModel]> = Variable([])
    var delegate: SpinnerCellDelegate?
    var questionModel: QuestionModel?
    let disposeBag = DisposeBag()
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        
        if let model = data as? QuestionModel {
            questionModel = model
            // set UI
            let datasourceType = model.getDataSourceType()
            self.id = model.getId()
            self.page = model.getPage()
            self.question = model.getQuestion()
            self.surveyType = model.getSurveyType()
            setQuestionStyle(model.getQuestion())
            
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
            
            if datasourceType == "car" {
                arr = MenuSpinner.shared.cars
            } else if datasourceType == "work" {
                arr = ["Bảo dưỡng định kì", "Sửa chữa", "Bảo hành"]
            } else if datasourceType == "brand" {
                arr = MenuSpinner.shared.agencys
            } else if datasourceType == "yes/no" {
                arr = ["Chắc chắn không", "Có thể không", "Có thể có", "Chắc chắn có"]
            } else if datasourceType == "select_time" {
                arr = ["Ngay lập tức", "1 - 2 phút", "3 - 5  phút", "Hơn 5 phút"]
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.borderView.layer.borderWidth =  1.0
        self.borderView.layer.borderColor = Colours.borderSurveyColor.cgColor
        
        self.dropDownButton.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.answerTextField.resignFirstResponder()
                self?.showMenuDropDown()
            }).disposed(by: disposeBag)
    }
    
    func showMenuDropDown() {
       
        dropDown.anchorView = borderView
        dropDown.direction = .bottom
        dropDown.dataSource = arr
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.answerTextField.text = item
            self.answer = item
            self.delegate?.getSpinnerResult(self.id ?? -1, self.page ?? -1, self.question ?? "", self.answer ?? "", self.surveyType ?? "")
        }
        dropDown.show()
    }
    
    func setQuestionStyle(_ question: String) {
        let string_to_color = "*"
        let range = (question as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: question)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.questionLabel.attributedText = attribute
    }
    
}
