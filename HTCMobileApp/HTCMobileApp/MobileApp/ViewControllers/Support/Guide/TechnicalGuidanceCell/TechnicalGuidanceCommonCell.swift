//
//  TechnicalGuidanceCommonCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/20/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class TechnicalGuidanceCommonCell: BaseTableViewCell {
    
    @IBOutlet weak var technicalImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var shortDesLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? TechnicalGuidanceModel {
            titleLabel.text = model.getTitle()
            dateLabel.text = model.getLastModifedTimeDisplay()
            shortDesLabel.text = model.getShortContent()
            
            if let url = model.getImageUrl() {
                technicalImageView.kf.setImage(with: url, placeholder: R.image.no_image_bg_small())
            }else{
                technicalImageView.image = R.image.no_image_bg_small()
            }
        }
    }
}
