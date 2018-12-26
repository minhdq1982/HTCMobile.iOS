//
//  NotificationCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class NotificationCollectionViewCell: BaseCollectionViewCell {
    @IBOutlet weak var topSeparatorView: UIView!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var fullContentLabel: UILabel!
    @IBOutlet weak var timeReceivedLabel: UILabel!
    @IBOutlet weak var checkReadImageView: UIImageView!
    var notitficationModel: NotificationModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let model = data  as? NotificationModel{
            notitficationModel = model
            fullContentLabel.text = model.getFullContent()
            
            if model.getType() == 0 {
                typeLabel.text = "Thông báo"
                typeImageView.image = UIImage(named: "report")
            } else if model.getType() == 1 {
                typeLabel.text = "Sinh nhật"
                typeImageView.image = UIImage(named: "gift")
            } else {
                typeLabel.text = "Khuyến mãi"
                typeImageView.image = UIImage(named: "discount")
            }
            
            if model.getRead() == true {
                checkReadImageView.isHidden = true
            } else {
                checkReadImageView.isHidden = false
            }
            
//            // setdate
//            let date = Date()
//            let formatter = DateFormatter()
//            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            let result = formatter.string(from: date)
//            print(result)
            
        }
    }
    
    
}
