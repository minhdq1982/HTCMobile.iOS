//
//  AgencyBenefitCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class AgencyBenefitCell: BaseTableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let agency = data as? AgencyBenefitModel {
            nameLabel.text = agency.getName()
            addressLabel.text = agency.getAddress()
            phoneLabel.text = agency.getPhone()
        }
    }
    
    
    
}
