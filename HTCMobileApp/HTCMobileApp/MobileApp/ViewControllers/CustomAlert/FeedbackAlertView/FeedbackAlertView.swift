//
//  FeedbackAlertView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/20/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FeedbackAlertView: UIViewController {
    
    var message: String = ""
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var callLabel: UILabel!
    @IBOutlet weak var sendFeedbackButton: UIButton!
    @IBOutlet weak var sendFeedbackLabel: UILabel!
    
    let chooseAction: Variable<Int> = Variable(-1)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    func setupView() {
        //        alertView.layer.cornerRadius = 9
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func onContact(_ sender: Any) {
        chooseAction.value = 0
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSendFeedback(_ sender: Any) {
        chooseAction.value = 1
        self.dismiss(animated: true, completion: nil)
    }
}
