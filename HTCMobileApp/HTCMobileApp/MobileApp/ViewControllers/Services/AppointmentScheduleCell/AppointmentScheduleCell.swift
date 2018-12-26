//
//  AppointmentScheduleCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class AppointmentScheduleCell: BaseTableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var carModel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var modelImageView: UIImageView!
    @IBOutlet weak var parkingImageView: UIImageView!
    
    override func awakeFromNib() {
        self.selectionStyle = .none
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
//        if let model = data as? AppointmentScheduleModel {
//            
//        }
    }
    
    func setAvailable(_ isAvailable: Bool)  {
        if isAvailable {
            dayLabel.backgroundColor = Colours.activeColor
            dayLabel.textColor = Colours.textColor
            modelImageView.image = R.image.service_car_model()
            parkingImageView.image = R.image.service_car_parking()

            titleLabel.textColor = Colours.textColor
            addressLabel.textColor = Colours.textColor
            dateLabel.textColor = Colours.textColor
            timeLabel.textColor = Colours.textColor
            carModel.textColor = Colours.textColor
        }else{
            dayLabel.backgroundColor = Colours.inactiveColor
            dayLabel.textColor = Colours.white.withAlphaComponent(0.6)
            modelImageView.image = R.image.service_car_model_inactive()
            parkingImageView.image = R.image.service_car_parking_inactive()
            
            titleLabel.textColor = Colours.inactiveColor
            addressLabel.textColor = Colours.inactiveColor
            dateLabel.textColor = Colours.inactiveColor
            timeLabel.textColor = Colours.inactiveColor
            carModel.textColor = Colours.inactiveColor
        }
    }
}
