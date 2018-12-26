//
//  UILabelExtension.swift
//  HTCMobileApp
//
//  Created by admin on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func setBorder(_ color: UIColor, _ width: Float) {
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
    
    func addImageWith(name: String, behindText: Bool) {
        
        let attachment = NSTextAttachment()
        attachment.image = UIImage(named: name)
        let attachmentString = NSAttributedString(attachment: attachment)
        
        guard let txt = self.text else {
            return
        }
        
        if behindText {
            let strLabelText = NSMutableAttributedString(string: txt)
            strLabelText.append(attachmentString)
            self.attributedText = strLabelText
        } else {
            let strLabelText = NSAttributedString(string: txt)
            let mutableAttachmentString = NSMutableAttributedString(attributedString: attachmentString)
            mutableAttachmentString.append(strLabelText)
            self.attributedText = mutableAttachmentString
        }
    }
    
    func removeImage() {
        let text = self.text
        self.attributedText = nil
        self.text = text
    }
}
