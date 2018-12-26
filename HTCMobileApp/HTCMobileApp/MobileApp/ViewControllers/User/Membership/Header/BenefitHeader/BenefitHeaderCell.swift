//
//  BenefitHeaderCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

protocol BenefitHeaderDelegate: class {
    func touchSelection(_ section: Int, _ header: BenefitHeaderCell)
}

class BenefitHeaderCell: UITableViewHeaderFooterView {
    weak var delegate: BenefitHeaderDelegate?
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var expandButton: UIButton!
    var section: Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTouchHeader(_:))))
        // Initialization code
    }
    
    @objc func onTouchHeader(_ gesture: UITapGestureRecognizer) {
        guard  let header = gesture.view as? BenefitHeaderCell else {
            return
        }
        delegate?.touchSelection(header.section, header)
    }
    
    func customInit(_ brand: String, name: String, licensePlate: String) {
        self.brandLabel.text = brand
        self.nameLabel.text = name
        self.licensePlateLabel.text = licensePlate
    }
    
    func setIsOnExpand(_ isOnExpand: Bool) {
        if isOnExpand == true {
            expandButton.setImage(UIImage(named: "user_dropup"), for: .normal)
        } else {
            expandButton.setImage(UIImage(named: "user_dropdown"), for: .normal)
        }
    }
    
    
    @IBAction func onExpand(_ sender: Any) {
        delegate?.touchSelection(section, self)
    }
}
