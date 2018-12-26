//
//  HomeHeaderViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol HomeHeaderViewCellDelegate {
    func didTapGroupNews(group: GroupNewsHeaderModel)
}

class HomeHeaderViewCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    var delegate: HomeHeaderViewCellDelegate?
    var headerModel: GroupNewsHeaderModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? GroupNewsHeaderModel {
            headerModel = model
            titleLabel.text = model.getName()
        }
    }
    
    @IBAction func tapGroupNewsAction(_ sender: Any) {
        if let model = headerModel {
            delegate?.didTapGroupNews(group: model)
        }
    }
}
