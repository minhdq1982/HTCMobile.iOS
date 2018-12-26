//
//  SettingViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: BaseViewController {
    
    var settingMenu: SettingTableViewController?
    
    override func setupView() {
        super.setupView()
    }
    
    override func localizable() {
        self.setHeaderTitle("Thiết lập")
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settingMenu" {
            if let settingMenuVC = segue.destination as? SettingTableViewController {
                
                settingMenu = settingMenuVC
                
                settingMenuVC.tableView.rx.itemSelected
                    .asObservable()
                    .subscribe(onNext: {[weak self] (indexPath) in
                        switch indexPath.section {
                        case 1:
                            //  Signout
                            Api.default.setAccessToken("", userId: 0)
                            UserPrefsHelper.shared.setAccessToken("", userId: 0, phone:"")
                            self?.navigationController?.popToRootViewController(animated: true)
                        default:
                            break
                        }
                        
                    }).disposed(by: disposeBag)
            }
        }
    }
}
