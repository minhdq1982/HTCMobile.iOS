//
//  ContentCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class ContentCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? CategoryModel {
            titleLabel.text = model.getName()
            titleLabel.textColor = Colours.white.withAlphaComponent(0.6)
        }
    }
    
    func setSelected(_ isSelected: Bool) {
        if isSelected {
            titleLabel.textColor = Colours.white
        }else{
            titleLabel.textColor = Colours.white.withAlphaComponent(0.6)
        }
    }
}
