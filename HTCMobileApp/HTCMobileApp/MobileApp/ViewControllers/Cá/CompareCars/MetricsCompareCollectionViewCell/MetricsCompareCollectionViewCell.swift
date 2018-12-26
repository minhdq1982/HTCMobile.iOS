//
//  MetricsCompareCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/15/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class MetricsCompareCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var value1Label: UILabel!
    @IBOutlet weak var value2Label: UILabel!
    @IBOutlet weak var bottomLineView: UIView!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? CompareItem {
            value1Label.text = model.getValue1()
            value2Label.text = model.getValue2()
        }
    }
}
