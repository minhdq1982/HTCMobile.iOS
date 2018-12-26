//
//  BirthdayTextField.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/27/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class BirthdayTextField: UITextField {
    
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
        self.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 17)
        textColor = Colours.textColor
        
        self.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
    }
    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return bounds.inset(by: UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8))
//    }
    
    @objc func textFieldDidChange(sender: UITextField!) {
        if (sender.text?.isEmpty)! {
            return
        }
        
        let ddmmyyyy = Constants.enterDateFormat
        
        guard var text = sender.text?.digits,
            text.count > 0 else {
                sender.text = ""//ddmmyyyy
                if let newPosition = sender.position(from: sender.beginningOfDocument, offset: 0) {
                    let newSelectedRange = sender.textRange(from: newPosition, to: newPosition)
                    sender.selectedTextRange = newSelectedRange
                }
                return
        }
        
        var dd = ""
        var mm = ""
        var yyyy = ""
        var string = ""
        
        if text.count > 8 {
            text = text.substring(with: 0..<8)
        }
        if text.count > 4 {
            dd = text.substring(with: 0..<2)
            mm = text.substring(with: 2..<4)
            yyyy = text.substring(from: 4)
            string = "\(dd)/\(mm)/\(yyyy)"
        }else if text.count == 4 {
            dd = text.substring(with: 0..<2)
            mm = text.substring(with: 2..<4)
            string = "\(dd)/\(mm)"
        }else if text.count > 2 {
            dd = text.substring(with: 0..<2)
            mm = text.substring(from: 2)
            string = "\(dd)/\(mm)"
        }else {
            string = text
        }
        
        sender.text = "\(string)\(ddmmyyyy.substring(from: string.count))"
        if let newPosition = sender.position(from: sender.beginningOfDocument, offset: string.count) {
            let newSelectedRange = sender.textRange(from: newPosition, to: newPosition)
            sender.selectedTextRange = newSelectedRange
        }
    }
}
