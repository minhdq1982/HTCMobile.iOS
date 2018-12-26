//
//  DropdownButton.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
class DropdownButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        layer.borderColor = Colours.borderColor.cgColor
        layer.borderWidth = 0.5
        contentHorizontalAlignment = .left
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        setTitleColor(Colours.textColor, for: .normal)
        self.titleLabel?.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 17)
    }
    
}
