//
//  BannerPagerViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/20/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

protocol BannerPagerViewCellDelegate {
    func didSelectBanner(_ banner: BannerModel?)
}

class BannerPagerViewCell: BaseFSPagerViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    var bannerModel: BannerModel?
    var delegate: BannerPagerViewCellDelegate?
    
    override public func setDataContext(index: Int, data: Any) {
        super.setDataContext(index: index, data: data)
        
        if let model = data as? BannerModel
        {
            bannerModel = model
            //  Localization
//            learnMoreButton.setTitle("Learn more", for: .normal)
//            carImageView.image = UIImage(named: model.getImageName())
        }
    }
    
    @IBAction func tapBannerAction(_ sender: Any) {
        self.delegate?.didSelectBanner(bannerModel)
    }
}
