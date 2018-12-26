//
//  UIAlertViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

public extension UIAlertController {
    func show() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.backgroundColor = .clear
        window.rootViewController = vc
        window.windowLevel = UIWindow.Level.alert + 1
        window.makeKeyAndVisible()
        vc.present(self, animated: true, completion: nil)
    }
}
