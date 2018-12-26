//
//  SegmentView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/11/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class SegmentView: UIView {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    
    func setSelected(_ isSelected: Bool) {
        self.selectedView.isHidden = !isSelected
        if isSelected {
            titleLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Bold", size: 17)
        }else{
            titleLabel.font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 17)
        }
    }
}
