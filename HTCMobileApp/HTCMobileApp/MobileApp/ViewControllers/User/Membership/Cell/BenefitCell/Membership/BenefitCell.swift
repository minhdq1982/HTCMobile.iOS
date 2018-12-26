//
//  BenefitCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit



class BenefitCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var benefitModel: BenefitModel?
    
    override func awakeFromNib() {
        
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        
        if let benefit = data as? BenefitModel {
            benefitModel = benefit
            titleLabel.text = benefit.getContent()
        }
    }
    
    func customInit(title: String) {
        titleLabel.text = title
    }
    
    
}
