//
//  CarVersionCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class CarVersionCell: BaseTableViewCell {
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var versionNameLabel: UILabel!
    
    func setStatus(_ isSelected: Bool) {
        checkButton.isSelected = isSelected
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? CarVersionModel {
            versionNameLabel.text = model.getName()
        }
    }
}
