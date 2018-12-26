//
//  ContactUsCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol ContactUsCellDelegate {
    func didTapHotline()
    func didTapFacebook()
    func didTapYoutube()
}

class ContactUsCell: BaseTableViewCell {

    var delegate: ContactUsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2)
    }
    
    @IBAction func onHotline(_ sender: Any) {
        delegate?.didTapHotline()
    }
    
    @IBAction func onFacebook(_ sender: Any) {
        delegate?.didTapFacebook()
    }
    
    @IBAction func onYoutube(_ sender: Any) {
        delegate?.didTapYoutube()
    }
}
