//
//  HomeAddCardCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol HomeAddCardCellDelegate {
    func didTapAddTheFirstCard()
}

class HomeAddCardCell: BaseTableViewCell {
    
    @IBOutlet weak var addCardLabel: UILabel!
    @IBOutlet weak var addCardGuideLabel: UILabel!
    @IBOutlet weak var addCardButton: UIButton!
    @IBOutlet weak var imageHeightContraint: NSLayoutConstraint!
    
    @IBOutlet weak var bgHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var bgTopContraint: NSLayoutConstraint!
    
    var delegate:HomeAddCardCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        bgTopContraint.constant = UIApplication.shared.statusBarFrame.height + 50
        bgHeightContraint.constant = UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - 50
        self.setNeedsLayout()
        self.layoutIfNeeded()
    }
    
    @IBAction func tapAddTheFirstCard(_ sender: Any) {
        delegate?.didTapAddTheFirstCard()
    }
    
}
