//
//  CarDetailCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class CarDetailCell: BaseTableViewCell {
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var carImageView: UIImageView!
    @IBOutlet weak var purchaseDateLabel: UILabel!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var vinnoLabel: UILabel!
    var carDetailCardModel: CarDetailCardModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        self.selectionStyle = .none
        if let model = data as? CarDetailCardModel {
            carDetailCardModel = model
            carNameLabel.text = model.getCarName()
            vinnoLabel.text = model.getVinno()
            purchaseDateLabel.text = model.getPurchaseDate()
            licensePlateLabel.text = model.getLicensePlate()
        }
    }
    
    
}
