//
//  CustomButton.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        backgroundColor = Colours.themeColor
        setTitleColor(UIColor.white, for: .normal)
        self.titleLabel?.font = UIFont(name: "HyundaiSansVNHeadOffice-Bold", size: 17)
    }
    
}
