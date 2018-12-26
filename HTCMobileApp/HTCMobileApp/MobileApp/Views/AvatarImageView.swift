//
//  AvatarImageView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/24/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class AvatarImageView: UIImageView {
    
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
        layer.cornerRadius = min(self.frame.size.width, self.frame.size.height) / 2
        backgroundColor = .white
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
    }
}
