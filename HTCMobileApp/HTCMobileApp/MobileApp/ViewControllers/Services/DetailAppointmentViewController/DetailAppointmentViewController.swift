//
//  DetailAppointmentViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class DetailAppointmentViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var customerInfoLabel: UILabel!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var nameValue: UILabel!
    @IBOutlet weak var phoneTitle: UILabel!
    @IBOutlet weak var phoneValue: UILabel!
    @IBOutlet weak var emailTitle: UILabel!
    @IBOutlet weak var emailValue: UILabel!
    
    @IBOutlet weak var serviceInfoLabel: UILabel!
    @IBOutlet weak var serviceTitle: UILabel!
    @IBOutlet weak var serviceValue: UILabel!
    @IBOutlet weak var carModelTitle: UILabel!
    @IBOutlet weak var carModelValue: UILabel!
    @IBOutlet weak var carVersionTitle: UILabel!
    @IBOutlet weak var carVersionValue: UILabel!
    @IBOutlet weak var lisencePlateTitle: UILabel!
    @IBOutlet weak var lisencePlateValue: UILabel!
    @IBOutlet weak var carYearTitle: UILabel!
    @IBOutlet weak var carYearValue: UILabel!
    @IBOutlet weak var timeTitle: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    @IBOutlet weak var agencyTitle: UILabel!
    @IBOutlet weak var agencyValue: UILabel!
    @IBOutlet weak var staffTitle: UILabel!
    @IBOutlet weak var staffValue: UILabel!
    @IBOutlet weak var requestTitle: UILabel!
    @IBOutlet weak var requestValue: UILabel!
    
    var appointment: AppointmentScheduleModel?
    let contentHeight: CGFloat = 586
    
    override func setupView() {
        super.setupView()
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Thứ 5, 20/09/2018")
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
