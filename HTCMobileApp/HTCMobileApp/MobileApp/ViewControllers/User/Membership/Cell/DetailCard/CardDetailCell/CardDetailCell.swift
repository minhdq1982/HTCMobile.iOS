//
//  CardDetailCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class CardDetailCell: BaseTableViewCell {
    
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var activeDateLabel: UILabel!
    @IBOutlet weak var expiredDateLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var brandAddressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    var cardDetailModel: CardDetailModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        self.selectionStyle = .none
        if let model = data as? CardDetailModel {
            cardDetailModel = model
            pointLabel.text = "\(model.getPoint())"
            setDate(date: model.getActiveDate(), label: activeDateLabel)
            setDate(date: model.getExpiredDate(), label: expiredDateLabel)
            brandLabel.text = model.getBrand()
            phoneLabel.text = model.getPhone()
        }
    }
    
    func setDate(date: String, label: UILabel) {
        if date != "" {
            let milisecond = date.convertStringToMilisecond(format: "yyyy-MM-dd'T'hh:mm:ss")
            let dateString = milisecond.convertToDateString()
            label.text = dateString
        } else {
            label.text = ""
        }
        
    }
    
    
}
