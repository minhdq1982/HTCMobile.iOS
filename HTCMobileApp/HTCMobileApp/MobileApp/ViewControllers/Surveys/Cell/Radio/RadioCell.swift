//
//  RadioCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

protocol RadioCellDelegate {
    func getRadioResult(_ id: Int,_ page: Int,_ question: String,_ answer: String, _ surveyType: String)
}
class RadioCell: BaseTableViewCell {
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    var delegate: RadioCellDelegate?
    var id: Int?
    var page: Int?
    var question: String?
    var answer: String?
    var surveyType: String?
    
    var questionModel: QuestionModel?
    let disposeBag = DisposeBag()
    let itemsSource: Variable<[AnswerModel]> = Variable([])
    var count: Variable<Int> = Variable(0)
    
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as? QuestionModel {
            questionModel = model
            setQuestionStyle(model.getQuestion())
            
            self.id = model.getId()
            self.page = model.getPage()
            self.question = model.getQuestion()
            self.surveyType = model.getSurveyType()
            
            // get Result
            let results = ServiceResult.shared.getResult(index: model.getPage())
            for item in results {
                print(item.getAnswer())
            }
            
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
        self.selectionStyle = .none
        self.layoutIfNeeded()
        self.setNeedsLayout()
        self.collectionView.register(RadioCollectionCell.nib, forCellWithReuseIdentifier: RadioCollectionCell.identifier)
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        

        // set collection layout
        collectionLayout.itemSize = CGSize(width: CGFloat(self.collectionView.frame.size.width - 24) / 2 + 24, height: 48)
        collectionLayout.minimumInteritemSpacing = 1
        collectionLayout.minimumLineSpacing = 1
        self.collectionView.collectionViewLayout = collectionLayout
      
        // set datasource for collection view
        itemsSource.asDriver()
            .drive(self.collectionView.rx.itemsSource())
            .disposed(by: disposeBag)
        
        itemsSource.asObservable()
            .subscribe(onNext: { [weak self] (answers) in
                let count: Int = (answers.count - 1)/2 + 1
                if answers.count < 3 {
                    self?.collectionViewHeight.constant = CGFloat(Double(50.0))
                } else {
                    self?.collectionViewHeight.constant = CGFloat(Double(50.0) * Double(count))
                }
                
                self?.setNeedsLayout()
                self?.layoutIfNeeded()
            })
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (index) in
                guard let s = self else { return }
                s.setStateButton(index: index)
                s.sendAnswer(input: s.itemsSource.value[index.row].getAnswer())
                print(s.itemsSource.value[index.row].getAnswer())
            }).disposed(by: disposeBag)
        
    }
    
    
   
    
    func setQuestionStyle(_ question: String) {
        let string_to_color = "*"
        let range = (question as NSString).range(of: string_to_color)
        
        let attribute = NSMutableAttributedString.init(string: question)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor.red , range: range)
        self.questionLabel.attributedText = attribute
    }
    
    func setStateButton(index: IndexPath) {
        for i in 0..<itemsSource.value.count {
            if let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? RadioCollectionCell {
                cell.setSelected(index.row == i)
            }
        }
        
        
    }
    
    func sendAnswer(input: String){
        self.delegate?.getRadioResult(self.id ?? -1, self.page ?? -1, self.question ?? "", input, self.surveyType ?? "")
    }
    
    func updateUI(answer: String) {
        for i in 0..<itemsSource.value.count {
            if let cell = collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? RadioCollectionCell {
                    let item = itemsSource.value[i]
                    if item.getAnswer() == answer {
                        cell.radioButton.isSelected = true
                    } else {
                        cell.radioButton.isSelected = false
                    }
                }
            }
        }

}


