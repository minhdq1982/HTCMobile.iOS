//
//  UsingIncentiveCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/20/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class UsingIncentiveCell: BaseTableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var promotionNameLabel: UILabel!
    @IBOutlet weak var transactionCodeLabel: UILabel!
    @IBOutlet weak var promotionCodeLabel: UILabel!
    var historyModel: HistoryIncentiveModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let model = data as? HistoryIncentiveModel {
            historyModel = model
            titleLabel.text = "\(model.getTypeIncentive())"
            promotionNameLabel.text = model.getProgramName()
            if model.getTransactionDate() != "" {
                let milisecond = model.getTransactionDate().convertStringToMilisecond(format: "yyyy-MM-dd'T'hh:mm:ss")
                let dateString = milisecond.convertToDateString()
                self.dateLabel.text = dateString
            } else {
                self.dateLabel.text = ""
            }
            transactionCodeLabel.text = model.getTransactionCode()
            promotionCodeLabel.text = model.getProgramCode()
        }
    }
    
}
