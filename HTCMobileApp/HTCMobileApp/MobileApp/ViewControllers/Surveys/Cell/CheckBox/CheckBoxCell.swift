//
//  CheckBoxCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol CheckBoxCellDelegate {
    func getCheckBoxResult(_ id: Int,_ page: Int,_ question: String,_ answer: String, _ surveyType: String)
}

class CheckBoxCell: BaseTableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableHeightCotraint: NSLayoutConstraint!
    var questionModel: QuestionModel?
    var delegate: CheckBoxCellDelegate?
    var id: Int?
    var question: String?
    var page: Int?
    var surveyType: String?
    let disposeBag = DisposeBag()
    let itemsSource: Variable<[AnswerModel]> = Variable([])
    let answers: Variable<[AnswerModel]> = Variable([])
    let selectedIndexs: Variable<[IndexPath]> = Variable([])
    let otherAnswer: Variable<String> = Variable("")
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as? QuestionModel {
            
            questionModel = model
            self.id = model.getId()
            self.question = model.getQuestion()
            self.page = model.getPage()
            self.surveyType = model.getSurveyType()
            setQuestionStyle(model.getQuestion())
            
            // get Result
            let results = ServiceResult.shared.getResult(index: model.getPage())
    
            // update UI
            for result in results {
                if model.getId() == result.getId() && model.getSurveyType() == result.getSurveyType() {
                    updateUI(answer: result.getAnswer())
                }
            }
            
            itemsSource.value.removeAll()
            if model.getAnswers().count > 0 {
                itemsSource.value += model.getAnswers()
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.tableView.register(CheckBoxTableCell.nib, forCellReuseIdentifier: CheckBoxTableCell.identifier)
        self.selectionStyle = .none

        itemsSource.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: CheckBoxTableCell.identifier, cellType: CheckBoxTableCell.self)) {[weak self] (row, element, cell) in
                guard let s = self else{return}
                cell.setDataContext(indexPath: IndexPath(row: row, section: 0), data: element)
                
                let answerModel = s.itemsSource.value[row]
                if answerModel.getAnswer().isEmpty {
                    if row == s.itemsSource.value.count - 1 {
                        cell.otherTextField.rx.text.orEmpty.asDriver()
                            .drive(s.otherAnswer)
                            .disposed(by: s.disposeBag)
                    }
                }
            }
            .disposed(by: disposeBag)
        
//        itemsSource.asDriver()
//            .drive(self.tableView.rx.itemsSource())
//            .disposed(by: disposeBag)
        
        itemsSource.asObservable()
            .subscribe(onNext: {[weak self] (answers) in
                self?.tableHeightCotraint.constant = CGFloat(Double(50.0) * Double(answers.count))
                self?.setNeedsLayout()
                self?.layoutIfNeeded()
            }).disposed(by: disposeBag)
        
        self.tableView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (index) in
                guard let s = self else {return}
                if index.row != s.itemsSource.value.count - 1 {
                    self?.updateAnswer(index: index)
                    self?.setStateButton(index: index)
                }else{
                    self?.otherAnswer.value = ""
                }
            }).disposed(by: disposeBag)
        selectedIndexs.asObservable()
            .skip(1)
            .subscribe(onNext: {[weak self] (indexs) in
                self?.updateAnswerWithIndexs(indexs)
            }).disposed(by: disposeBag)
        
        otherAnswer.asObservable()
            .skip(1)
            .distinctUntilChanged()
            .subscribe(onNext: {[weak self] (other) in
                self?.handleOtherAnwser(otherText: other)
            }).disposed(by: disposeBag)
    }
    
    func handleOtherAnwser(otherText: String) {
        let lastIndex = IndexPath(row: itemsSource.value.count - 1, section: 0)
//        updateAnswer(index: lastIndex)
        updateAnswerWithIndexs(selectedIndexs.value)
        
        if let lastCell = tableView.cellForRow(at: lastIndex) as? CheckBoxTableCell {
            lastCell.checkBoxButton.isSelected = !otherText.isEmpty
            lastCell.otherTextField.text = otherText
        }
    }
    
    func updateAnswer(index: IndexPath)  {
        var foundIndex = -1
        for i in 0..<selectedIndexs.value.count {
            let indexPath = selectedIndexs.value[i]
            if indexPath.row == index.row {
                foundIndex = i
                break
            }
        }
        if foundIndex != -1{
            selectedIndexs.value.remove(at: foundIndex)
        }else{
            selectedIndexs.value.append(index)
        }
    }
    
    func updateAnswerWithIndexs(_ indexs: [IndexPath]) {
        var answers: [AnswerModel] = []
        if indexs.count > 0 {
            for index in indexs {
                if index.row < itemsSource.value.count {
                    answers.append(itemsSource.value[index.row])
                }
            }
        }
        
        var answer = answers.map { (model) -> String in
            return model.getAnswer()
            
        }
        
        //  Check other answer
        if !otherAnswer.value.isEmpty {
            answer.append(otherAnswer.value)
        }
        
        let joinString = answer.joined(separator: ",")
        
        self.sendAnswer(input: joinString)
        
        print("joinString: \(joinString)")
    }
    
    func sendAnswer(input: String) {
        self.delegate?.getCheckBoxResult(self.id ?? -1, self.page ?? -1, self.question ?? "", input, self.surveyType ?? "")
    }
    
    func setQuestionStyle(_ question: String) {
        let string_to_color = "*"
        let range = (question as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: question)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.questionLabel.attributedText = attribute
    }
    
    func setStateButton(index: IndexPath) {
       
        // set status Button
        if let cell = tableView.cellForRow(at: index) as? CheckBoxTableCell {
            cell.checkBoxButton.isSelected = !cell.checkBoxButton.isSelected
        }
    }

    func updateUI(answer: String) {
        let arr = answer.components(separatedBy: ",")
        if arr.count > 0 {
            for answer in arr {
                for i in 0..<itemsSource.value.count {
                    if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? CheckBoxTableCell {
                        let item = itemsSource.value[i]
                        if answer == item.getAnswer() {
                            cell.checkBoxButton.isSelected = true
                            break
                        }
                        
                    }
                }
            }
        }
       
        
    }
    
}

