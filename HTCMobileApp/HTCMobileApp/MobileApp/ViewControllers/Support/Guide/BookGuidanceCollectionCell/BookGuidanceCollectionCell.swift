//
//  BookGuidanceCollectionCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class BookGuidanceCollectionCell: BaseCollectionViewCell {
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? BookGuidanceModel {
            titleLabel.text = model.getTitle()
            bgImage.image = UIImage(named: model.getBgImageNameAtIndex(indexPath.row))
            carImage.kf.setImage(with: model.getCarImageUrl())
        }
    }
}
