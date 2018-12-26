//
//  PaddingTextField.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/24/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class PaddingTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        borderStyle = .none
        returnKeyType = .done
        //        layer.borderWidth = 0.5
        //        layer.borderColor = Colours.borderColor.cgColor
        self.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 17)
        textColor = Colours.textColor
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
    }
}
