//
//  ConfirmAlertView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/15/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ConfirmAlertView: UIViewController {
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cancelButton: CustomButton!
    @IBOutlet weak var okButton: CustomButton!
    var message: String = ""
    
    let onCancel: Variable<Bool> = Variable(false)
    let onConfirm: Variable<Bool> = Variable(false)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.messageLabel.text = self.message
        }
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
    
    @IBAction func onDismiss(_ sender: Any) {
        onCancel.value = true
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onOK(_ sender: Any) {
        onConfirm.value = true
        self.dismiss(animated: true, completion: nil)
    }
}
