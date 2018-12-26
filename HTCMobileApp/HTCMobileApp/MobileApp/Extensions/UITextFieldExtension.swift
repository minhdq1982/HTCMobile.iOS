//
//  UITextFieldExtension.swift
//  HTCMobileApp
//
//  Created by admin on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBorder(_ color: UIColor, _ width: Float) {
        self.borderStyle = .none
        let border = CALayer()
        let width = CGFloat(width)
        
        border.borderColor = color.cgColor
        
        let frameWidth = self.frame.size.width
        let frameHeight = self.frame.size.height
        border.frame = CGRect(x: 0,
                              y: frame.size.height - width,
                              width: frameWidth,
                              height: frameHeight)
        border.borderWidth = width
        
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
    func setPaddingBeginText(_ width: CGFloat) {
        let padding  = UIView(frame: CGRect(x: 0, y: 0, width: width, height: self.frame.size.height))
        self.leftView = padding
        self.leftViewMode = .always
        self.layer.masksToBounds = true
    }
}
