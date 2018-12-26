//
//  CarCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class CarCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var carNameLabel: UILabel!
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? CarModel {
            carNameLabel.text = model.getName()
        }
    }
}
