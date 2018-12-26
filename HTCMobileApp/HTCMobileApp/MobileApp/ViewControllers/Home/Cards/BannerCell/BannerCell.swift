//
//  BannerCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/18/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol BannerCellDelegate {
    func moveToSearchAgency()
    func moveToBuyCar()
    func moveToRegisterDrive()
    func moveToRegisterApointment()
}

class BannerCell: BaseTableViewCell {
    var delegate: BannerCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        
    }
    
    @IBAction func tapSearchAgency(_ sender: Any) {
        delegate?.moveToSearchAgency()
    }
    @IBAction func tapBuyCar(_ sender: Any) {
        delegate?.moveToBuyCar()
    }
    @IBAction func tapRegisterDrive(_ sender: Any) {
        delegate?.moveToRegisterDrive()
    }
    @IBAction func tapAppointment(_ sender: Any) {
        delegate?.moveToRegisterApointment()
    }
}
