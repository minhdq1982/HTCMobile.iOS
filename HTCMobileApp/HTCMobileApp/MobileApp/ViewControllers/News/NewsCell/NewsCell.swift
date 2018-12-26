//
//  NewsCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import Kingfisher

class NewsCell: BaseTableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var titleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var createTimeLabel: UILabel!
//    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        
        if let new = data as? NewsModel {
            typeImageView.isHidden = true
            self.titleLabel.text = new.getTitle()

            if let url = new.getImageUrl(){
                self.titleImageView.kf.setImage(with: url, placeholder: R.image.no_image_bg_big())
            }else{
                self.titleImageView.image = R.image.no_image_bg_big()
            }
            self.createTimeLabel.text = new.getCreationTimeDisplay()
//            self.contentLabel.text = new.getShortContent()
            
        }else if let new = data as? YoutubeItem {
            typeImageView.isHidden = false
            typeImageView.image = UIImage(resource: R.image.youtube)
            
            self.titleLabel.text = new.getTitle()
            if let url = new.getImageUrl(){
                self.titleImageView.kf.setImage(with: url, placeholder: R.image.no_image_bg_big())
            }
            self.createTimeLabel.text = new.getCreationTimeDisplay()
//            self.contentLabel.text = new.getShortContent()
            
        }else if let new = data as? FacebookItem{
            typeImageView.isHidden = false
            typeImageView.image = UIImage(resource: R.image.facebook)

            self.titleLabel.text = new.getShortContent()
            if let url = new.getImageUrl(){
                self.titleImageView.kf.setImage(with: url, placeholder: R.image.no_image_bg_big())
            }
            self.createTimeLabel.text = new.getCreationTimeDisplay()
//            self.contentLabel.text = new.getShortContent()
        }
    }
    
    
}
