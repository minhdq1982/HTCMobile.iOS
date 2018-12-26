//
//  FeedbackSuccessAlertView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/20/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class FeedbackSuccessAlertView: UIViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var newFeedbackButton: UIButton!
    
    let onAgree: Variable<Bool> = Variable(false)
    let onCreateNewFeedback: Variable<Bool> = Variable(false)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    func setupView() {
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
    
    @IBAction func onAgree(_ sender: Any) {
        onAgree.value = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCreateNewFeedback(_ sender: Any) {
        onCreateNewFeedback.value = true
        self.dismiss(animated: true, completion: nil)
    }
}
