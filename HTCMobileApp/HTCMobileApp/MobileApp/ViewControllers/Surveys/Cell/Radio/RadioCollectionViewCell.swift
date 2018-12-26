//
//  RadioCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RadioCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var radioButton: UIButton!
    @IBOutlet weak var answerLabel: UILabel!
    @IBOutlet weak var widthContraint: NSLayoutConstraint!
    let disposeBag = DisposeBag()
    
    var isSelecButton: Bool?
    var answersModel: AnswerModel?
    var widthSize: Variable<Int> = Variable(0)
    
    //    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
    //        setNeedsLayout()
    //        layoutIfNeeded()
    //        let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
    //        var newFrame = layoutAttributes.frame
    //        newFrame.size.width = CGFloat(ceilf(Float(size.width)))
    //        layoutAttributes.frame = newFrame
    //
    //        return layoutAttributes
    //    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as? AnswerModel {
            answersModel = model
            answerLabel.text = model.getAnswer()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.contentView.translatesAutoresizingMaskIntoConstraints = false
        let screenWidth = UIScreen.main.bounds.size.width
        widthContraint.constant = screenWidth - (2 * 12)
        
        self.radioButton.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] (_) in
                self?.checkStatusButton()
                print("radio click")
            }).disposed(by: disposeBag)
    }
    
    func checkStatusButton() {
        if radioButton.isSelected == true {
            radioButton.isSelected = false
        } else {
            radioButton.isSelected = true
        }
    }
    
    
}

