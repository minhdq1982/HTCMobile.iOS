//
//  NoUsingPointCell.swift
//  HTCMobileApp
//
//  Created by admin on 12/14/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class NoUsingPointCell: BaseTableViewCell {
    @IBOutlet weak var actionButton: UIButton!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var transactionCodeLabel: UILabel!
    @IBOutlet weak var cardNoLabel: UILabel!
    var historyModel: HistoryNoUsePointModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let model = data as? HistoryNoUsePointModel {
            historyModel = model
            if model.getPoints() == 0 {
                pointLabel.text = "0 điểm"
            } else {
                pointLabel.text = "\(model.getPoints()) điểm"
            }
            
            rankLabel.text = model.getBenefitTypeName()
            
            if model.getTransactionDate() != "" {
                let milisecond = model.getTransactionDate().convertStringToMilisecond(format: "yyyy-MM-dd'T'hh:mm:ss")
                let dateString = milisecond.convertToDateString()
                self.dateCreateLabel.text = dateString
            } else {
                self.dateCreateLabel.text = ""
            }
            transactionCodeLabel.text = model.getTransactionCode()
            cardNoLabel.text = model.getMembershipCardNumber()
        }
    }
    
}
