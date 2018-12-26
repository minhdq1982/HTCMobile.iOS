//
//  BenefitDetailCardCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class  BenefitDetailCardCell: BaseTableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    var benefitModel: BenefitModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let model = data as? BenefitModel {
            benefitModel = model
            titleLabel.text = model.getContent()
            
        }
    }
}
