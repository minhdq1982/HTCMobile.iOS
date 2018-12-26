//
//  HTCCustomTabBarController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/9/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class HTCCustomTabBarController: UITabBarController {
    
//    let centerButtonSize = CGSize(width: 60, height: 60)
//    var button: UIButton = UIButton(type: .custom)
    
    override open func viewDidLoad() {
        super.viewDidLoad()
//        if self.isIphoneX() {
//            self.addBiggerCenterButton(R.image.services(), offset: -40)
//        }else{
//            self.addBiggerCenterButton(R.image.services(), offset: -4)
//        }
        self.setBackgroundColor(color: Colours.tabbarColor)
        if let font = UIFont(name: "HyundaiSansVNHeadOffice-Bold", size: 9) {
            let appearance = UITabBarItem.appearance()
            let attributes: [NSAttributedString.Key:UIFont] = [NSAttributedString.Key.font : font]
            appearance.setTitleTextAttributes(attributes, for: .normal)
        }
    }
    
    public func setHidden(_ isHide: Bool) {
        self.tabBar.isHidden = isHide
//        self.button.isHidden = isHide
//        if isHide {
//            button.alpha = 1
//            UIView.animate(withDuration: 0.25, animations: {
//                self.button.alpha = 0
//            }) { _ in
//                self.button.isHidden = true
//            }
//        }else{
//            button.isHidden = false
//            button.alpha = 0
//            UIView.animate(withDuration: 0.25, animations: {
//                self.button.alpha = 1
//            }) { _ in
//                self.button.isHidden = false
//            }
//        }
    }
    
    fileprivate func setBackgroundColor(color: UIColor) {
        let frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 90)
        let view = UIView(frame: frame)
        view.backgroundColor = color
        tabBar.addSubview(view)
    }
    
//    fileprivate func isIphoneX() -> Bool {
//        var retValue = false
//        if UIDevice().userInterfaceIdiom == .phone {
//            switch UIScreen.main.nativeBounds.height {
//            case 2436, 2688, 1792:
//                retValue = true
//            default:
//                print("unknown")
//                retValue = false
//            }
//        }
//        return retValue
//    }
    
//    fileprivate func addBiggerCenterButton(_ buttonImage: UIImage?, offset: CGFloat? = nil) {
//        if let buttonImage = buttonImage {
//            button.autoresizingMask = [UIView.AutoresizingMask.flexibleRightMargin, UIView.AutoresizingMask.flexibleLeftMargin, UIView.AutoresizingMask.flexibleBottomMargin, UIView.AutoresizingMask.flexibleTopMargin]
//
//            button.frame = CGRect(x: 0.0, y: 0.0, width: centerButtonSize.width, height: centerButtonSize.height)
//            button.setBackgroundImage(buttonImage, for: .normal)
//            button.setBackgroundImage(buttonImage, for: .highlighted)
//            button.contentMode = .scaleAspectFit
//
//            print("Tabbar frame \(self.tabBar.frame)")
//
//            print("self.tabBar.center: \(self.tabBar.center)")
//            let heightDifference = centerButtonSize.height - self.tabBar.frame.size.height
//
//
//            if (heightDifference < 0) {
//                button.center = self.tabBar.center
//            }
//            else {
//                var center = self.tabBar.center
//                center.y -= heightDifference / 2.0
//
//                button.center = center
//            }
//
//            if offset != nil
//            {
//                //Add offset
//                var center = button.center
//                center.y = center.y + offset!
//                button.center = center
//            }
//
//            print("button frame: \(button.frame)")
//
//            button.addTarget(self, action: #selector(self.selectServicesAction(_:)), for: .touchUpInside)
//            self.view.addSubview(button)
//        }
//    }
    
//    @objc func selectServicesAction(_ sender: UIButton!) {
//        self.selectedIndex = 2
//    }
    
    
}
