//
//  InstallmentCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class InstallmentCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var totalOutstandingDebtTitleLabel: UILabel!
    @IBOutlet weak var originalInMonthTitleLabel: UILabel!
    @IBOutlet weak var interestOfMonthTitleLabel: UILabel!
    @IBOutlet weak var originalAndInterestTitleLabel: UILabel!
    
    @IBOutlet weak var totalOutstandingDebtValueLabel: UILabel!
    @IBOutlet weak var originalInMonthValueLabel: UILabel!
    @IBOutlet weak var interestOfMonthValueLabel: UILabel!
    @IBOutlet weak var originalAndInterestValueLabel: UILabel!
    
    @IBOutlet weak var upperLineView: UIView!
    @IBOutlet weak var dotView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        dotView.layer.masksToBounds = true
        dotView.layer.cornerRadius = 6
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? PaymentPeriodModel {
            //  TODO localize
//            totalOutstandingDebtTitleLabel.text =
//            originalInMonthTitleLabel.text =
//            interestOfMonthTitleLabel.text =
//            originalAndInterestTitleLabel.text =
            titleLabel.text = model.getName()
            totalOutstandingDebtValueLabel.text = model.getTotalDebt()
            originalInMonthValueLabel.text = model.getOriginalInMonth()
            interestOfMonthValueLabel.text = model.getInterestOfMonth()
            originalAndInterestValueLabel.text = model.getOriginalAndInterest()
        }
    }
}
