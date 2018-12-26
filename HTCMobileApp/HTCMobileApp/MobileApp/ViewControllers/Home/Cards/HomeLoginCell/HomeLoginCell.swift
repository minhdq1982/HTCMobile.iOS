//
//  HomeLoginCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol HomeLoginCellDelegate {
    func didTapLoginAction()
    func didTapDisableLoginCell()
}

class HomeLoginCell: BaseTableViewCell {
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var heightContraint:  NSLayoutConstraint!
    var delegate: HomeLoginCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        //  TODO localized strings
        heightContraint.constant = UIScreen.main.bounds.size.width * 332.0 / 553.0
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    @IBAction func tapLoginAction(_ sender: Any) {
        delegate?.didTapLoginAction()
    }
    
    @IBAction func tapCloseAction(_ sender: Any) {
        delegate?.didTapDisableLoginCell()
    }
    
}
