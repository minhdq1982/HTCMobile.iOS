//
//  AgencyListCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import GoogleMaps

class AgencyListCell: BaseTableViewCell {
    
    var disposeBag = DisposeBag()
    
    let currentLocation: Variable<CLLocation> = Variable(CLLocation.init(latitude: 21.028511, longitude: 105.804817))
    var model: AgencyLocationModel?
    
    @IBOutlet weak var agencyNameLabel: UILabel!
    @IBOutlet weak var agencyAddressLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? AgencyLocationModel {
            
            self.model = model
            
            agencyNameLabel.text = model.getName()
            agencyAddressLabel.text = model.getAddress()
            distanceLabel.text = "0 Km"
            
            currentLocation.asObservable()
                .subscribe(onNext: {[weak self] (location) in
                    if let model = self?.model {
                        let target: CLLocation = CLLocation(latitude: model.getLatitude(), longitude: model.getLongitude())
                        self?.distanceLabel.text = "\(String(format: "%.1f", target.distance(from: location) / 1000)) Km"
                    }
                    
                }).disposed(by: disposeBag)
            
        }
    }
}
