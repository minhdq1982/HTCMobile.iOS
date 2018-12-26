//
//  ChooseButton.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class ChooseButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        layer.borderWidth = 0.5
        layer.borderColor = UIColor.darkText.cgColor
        setTitleColor(UIColor.darkText, for: .normal)
        self.titleLabel?.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 15)
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            layer.borderColor = Colours.choosenColor.cgColor
            setTitleColor(Colours.choosenColor, for: .normal)
            self.titleLabel?.font = UIFont(name: "HyundaiSansVNHeadOffice-Medium", size: 15)
        }else{
            layer.borderColor = Colours.textColor.cgColor
            setTitleColor(UIColor.darkText, for: .normal)
            self.titleLabel?.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 15)
        }
    }
    
}
