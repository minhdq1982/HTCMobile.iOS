//
//  ChooseAvatarAlertViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class ChooseAvatarAlertViewController: UIViewController {
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var libraryButton: UIButton!
    let chooseAction: Variable<Int> = Variable(-1)
    // MARK: - Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
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
    
    // MARK: - functions
    @IBAction func gotoCamera(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        chooseAction.value = 0
    }
    
    @IBAction func gotoLibrary(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        chooseAction.value = 1
    }
}
