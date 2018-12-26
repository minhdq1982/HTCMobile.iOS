//
//  RoundedImageView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/18/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class RoundedImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initView()
    }
    
    fileprivate func initView() {
        clipsToBounds = true
        layer.cornerRadius = 4
    }
}
