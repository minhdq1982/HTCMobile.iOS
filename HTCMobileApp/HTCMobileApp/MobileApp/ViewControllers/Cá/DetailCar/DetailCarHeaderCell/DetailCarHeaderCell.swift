//
//  DetailCarHeaderCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

protocol DetailCarHeaderCellDelegate {
    func didTapCompareAction(car: CarModel)
    func didTapRegisterDrive(car: CarModel)
    func didTapPriceAdvice(car: CarModel)
    func didTapDownloadCatalog(car: CarModel)
    func didTapBackAction()
}

class DetailCarHeaderCell: BaseTableViewCell {
    
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var compareLabel: UILabel!
    @IBOutlet weak var registerDriveLabel: UILabel!
    @IBOutlet weak var priceAdviceLabel: UILabel!
    @IBOutlet weak var topContraint: NSLayoutConstraint!
    
    var delegate: DetailCarHeaderCellDelegate?
    var carModel: CarModel?
    
    @IBAction func tapCompareButton(_ sender: Any) {
        if let car = carModel {
            delegate?.didTapCompareAction(car: car)
        }
    }
    @IBAction func tapRegisterDriveButton(_ sender: Any) {
        if let car = carModel {
            delegate?.didTapRegisterDrive(car: car)
        }
    }
    @IBAction func tapPriceAdviceButton(_ sender: Any) {
        if let car = carModel {
            delegate?.didTapPriceAdvice(car: car)
        }
    }
    
    @IBAction func tapDownloadCatalogButton(_ sender: Any) {
        if let car = carModel {
            delegate?.didTapDownloadCatalog(car: car)
        }
    }
    
    @IBAction func tapBackButton(_ sender: Any) {
        delegate?.didTapBackAction()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        topContraint.constant = UIApplication.shared.statusBarFrame.height
    }
}
