//
//  PromotionCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class PromotionCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var proImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var newsModel: NewsModel?
    var indexPath: IndexPath = IndexPath(row: -1, section: 0)
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let news = data as? NewsModel {
            self.newsModel = news
            if let url = news.getImageUrl(){
                self.proImageView.kf.setImage(with: url, placeholder: R.image.home_no_image())
            }else{
                self.proImageView.image = R.image.home_no_image()
            }
            self.titleLabel.text = news.getTitle()
            self.dateLabel.text = news.getCreationTimeDisplay()
        }
    }
}
