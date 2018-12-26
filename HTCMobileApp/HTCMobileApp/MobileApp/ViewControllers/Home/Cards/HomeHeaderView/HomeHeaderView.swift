//
//  HomeHeaderView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol HomeHeaderViewDelegate {
    func didTapGroupNews(_ group: GroupNewsModel)
}

class HomeHeaderView: UITableViewHeaderFooterView {
    var section: Int = -1
    
    var groupNewsModel: GroupNewsModel?
    var delegate: HomeHeaderViewDelegate?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBAction func tapHeader(_ sender: Any) {
        if let group = self.groupNewsModel {
            delegate?.didTapGroupNews(group)
        }
    }
    
}
