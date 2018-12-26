//
//  WarrantyPolicyCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class WarrantyPolicyCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? WarrantyPolicyModel {
            titleLabel.text = model.getName()
        }
    }
}
