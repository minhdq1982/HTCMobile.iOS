//
//  CategoryCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class CategoryCollectionViewCell: BaseCollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    override func awakeFromNib() {
        titleLabel.font = UIFont(name: "HyundaiSansVNTextOffice-Regular", size: 17)
        super .awakeFromNib()
        layoutIfNeeded()
        setNeedsLayout()
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? CategoryModel {
            titleLabel.text = model.getName()
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setSelected(_ isSelected: Bool) {
        self.selectedView.isHidden = !isSelected
        if isSelected {
            titleLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Medium", size: 17)
        }else{
            titleLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 17)
        }
    }
}
