//
//  PointAnswerView.swift
//  HTCMobileApp
//
//  Created by admin on 11/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift
import UIKit

class PointAnswerView: UIView {
    @IBOutlet var buttons: [UIButton]!
    @IBOutlet weak var titleLabel: UILabel!
    var point: Int = 0
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // set button border
        for button in self.buttons {
            button.layer.borderWidth = 0.5
            button.layer.borderColor = Colours.borderSurveyColor.cgColor
        }
    }
    
    @IBAction func onSelectedPoint(_ sender: UIButton) {
        point = sender.tag
        
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
    

}
