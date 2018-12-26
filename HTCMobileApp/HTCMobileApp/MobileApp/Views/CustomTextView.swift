//
//  CustomTextView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class CustomTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        layer.borderWidth = 0.5
        layer.borderColor = Colours.borderColor.cgColor
        self.font = UIFont(name: "HyundaiSansVNHeadOffice-Bold", size: 17)
        textContainerInset = UIEdgeInsets(top: 5, left: 8, bottom: 5, right: 8)
        toolbarPlaceholder = "Chú thích"
        textColor = Colours.textColor
    }
}
