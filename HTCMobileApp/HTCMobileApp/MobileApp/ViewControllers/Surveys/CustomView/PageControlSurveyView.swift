//
//  PageControlSurveyView.swift
//  HTCMobileApp
//
//  Created by admin on 12/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

enum StatusPage: String {
    case NORMAL
    
    case CURRENT
    
    case SELECTED
    
    func typeValue() -> String {
        return self.rawValue
    }
}

class PageControlSurveyView: UIView {
    @IBOutlet var buttons: [UIButton]!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func setStatusButton(index: Int, status: String) {
        for button in buttons {
            if button.tag == index {
                if status == StatusPage.CURRENT.typeValue() {
                    button.setImage(R.image.page_current(), for: .normal)
                    button.isUserInteractionEnabled = true
                } else if status == StatusPage.SELECTED.typeValue() {
                    button.setImage(R.image.page_selected(), for: .normal)
                    button.isUserInteractionEnabled = true
                } else {
                    button.setImage(R.image.page_normal(), for: .normal)
                    button.isUserInteractionEnabled = false
                }
            }
        }
    }
    
    
}
