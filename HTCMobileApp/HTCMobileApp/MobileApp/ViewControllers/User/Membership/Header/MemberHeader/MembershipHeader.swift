//
//  MembershipHeader.swift
//  HTCMobileApp
//
//  Created by admin on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

protocol MembershipHeaderDelegate: class {
    
    func touchSelection(_ section: Int, _ header: MembershipHeader)
}

class MembershipHeader: UITableViewHeaderFooterView {
    weak var delegate: MembershipHeaderDelegate?
    @IBOutlet weak var expandButton: UIButton!
    var section: Int = 0
  
    @IBOutlet weak var brandLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTouchHeader(_:))))
        // Initialization code
    }
    
    @objc func onTouchHeader(_ gesture: UITapGestureRecognizer) {
        guard  let header = gesture.view as? MembershipHeader else {
            return
        }
        delegate?.touchSelection(header.section, header)
    }
    
    @IBAction func onExpand(_ sender: Any) {
        delegate?.touchSelection(section, self)
    }

    func setIsOnExpand(_ isOnExpand: Bool) {
        if isOnExpand == true {
            expandButton.setImage(UIImage(named: "dropup"), for: .normal)
        } else {
            expandButton.setImage(UIImage(named: "dropdown"), for: .normal)
        }
    }
    
    func customInit(_ brand: String) {
        self.brandLabel.text = brand
    }
  
    
}
