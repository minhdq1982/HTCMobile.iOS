//
//  ContentCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class ContentCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? ContentMenuModel {
            titleLabel.text = model.getTitle()
            if model.getIsParrent() {
                titleLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Bold", size: 15)
            }else{
                titleLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 15)
            }
        }
    }
    
}
