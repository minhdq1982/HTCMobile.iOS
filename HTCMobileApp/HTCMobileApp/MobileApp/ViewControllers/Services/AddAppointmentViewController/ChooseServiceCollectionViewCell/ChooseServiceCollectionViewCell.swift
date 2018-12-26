//
//  ChooseServiceCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class ChooseServiceCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var serviceImage: UIImageView!
    
    @IBOutlet weak var serviceNameLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? ServiceItem {
            serviceNameLabel.text = model.getName()
        }
    }
}
