//
//  AddCardAlertViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AddCardAlertViewController: UIViewController {
   
    // MARK: - outlet and variable
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var vinnoLabel: UILabel!
    @IBOutlet weak var carnameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var licensePlateLabel: UILabel!
    
    var brand: String?
    var cardNo: String?
    var carname: String?
    var username: String?
    var licensePlate: String?
    
    let completeAction: Variable<Bool> = Variable(false)
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(true)
        setupView()
        animateView()
    }
    
    // MARK: - functions
    func setupView() {
        
      
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        guard let brand = brand,
            let cardNo = cardNo,
            let carname = carname,
            let username = username,
            let licensePlate = licensePlate else {
            return
        }
        titleLabel.text = "Thêm thẻ hội viên thành công"
        brandLabel.text = brand
        vinnoLabel.text = cardNo
        carnameLabel.text = carname
        usernameLabel.text = username
        licensePlateLabel.text = licensePlate
        
    }
    
   
    @IBAction func onDone(_ sender: Any) {
        completeAction.value = true
        self.dismiss(animated: true, completion: nil)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
}
