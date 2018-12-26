//
//  CarUserCell.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import Kingfisher

protocol CarUserCellDelegate {
    func deleteCar(_ userCar: UserCarModel)
}

class CarUserCell: BaseTableViewCell {
    // MARK: - Outlet
    @IBOutlet weak var imageTypeCar: UIImageView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var deleteCarButton: UIButton!
    @IBOutlet weak var carVINNOLabel: UILabel!
    @IBOutlet weak var carLicensePlateLabel: UILabel!
    
    //MARK: - Variable
    var userCarModel: UserCarModel?
    var delegate: CarUserCellDelegate?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let carInfor = data as? UserCarModel {
            userCarModel = carInfor
            self.selectionStyle = .none
            carNameLabel.text = carInfor.getCarName()
            carVINNOLabel.text = carInfor.getCarAgencyName()
            carLicensePlateLabel.text = carInfor.getCarLicensePlate()
            
            if let url = carInfor.getCarImage() {
                self.imageTypeCar.kf.setImage(with: url, placeholder: R.image.no_image_bg_small())
            } else {
                self.imageTypeCar.image = R.image.no_image_bg_small()
            }
        }
    }
    
    @IBAction func tapDeleteCarAction(_ sender: Any) {
        if let car = self.userCarModel {
            delegate?.deleteCar(car)
        }
    }
}
