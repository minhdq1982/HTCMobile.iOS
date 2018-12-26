//
//  GoodNewsCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import Kingfisher

class GoodNewsCell: BaseTableViewCell {
    
    @IBOutlet weak var timeCreateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let new = data as? NewsModel {
            self.titleLabel.text = new.getTitle()
            self.timeCreateLabel.text = new.getCreationTimeDisplay()
            if let url = new.getImageUrl(){
                self.titleImageView.kf.setImage(with: url, placeholder: R.image.no_image_bg_big())
            }
        }
    }
    
}
