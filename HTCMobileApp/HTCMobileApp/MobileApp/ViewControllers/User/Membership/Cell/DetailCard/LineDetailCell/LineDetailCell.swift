//
//  LineDetailCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class LineDetailCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    var lineCommons : LineCommon?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let lineCommon = data as? LineCommon {
            lineCommons = lineCommon
            titleLabel.text = lineCommon.getTitle()
            contentLabel.text = lineCommon.getContent()
        }
    }
    

    
}
