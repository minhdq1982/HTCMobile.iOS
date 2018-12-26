//
//  UserInforCell.swift
//  HTCMobileApp
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

class UserInforCell: BaseTableViewCell {
    
    //MARK: - Outlet
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var titleImageView: UIImageView!
   
    // MARK: - Variable
    var userItem: UserItem?
    
    // MARK: - LifeCycle
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        
        if let item = data as? UserItem {
            userItem = item
            
            contentTextField.text = item.getContent()
            
            let  type = item.getType()
                if type == "phone" {
                    titleImageView.image = UIImage(named: "user_phone")
                    contentTextField.placeholder = tr(L10n.userPhone)
                } else if type == "dateOfBirth" {
                     titleImageView.image = UIImage(named: "user_calendar")
                    contentTextField.placeholder = tr(L10n.userDateBirth)
                } else if type == "CMND" {
                      titleImageView.image = UIImage(named: "user_badge")
                    contentTextField.placeholder = tr(L10n.userCMND)
                } else if type == "email" {
                      titleImageView.image = UIImage(named: "user_email")
                    contentTextField.placeholder = tr(L10n.userEmail)
                } else {
                     titleImageView.image = UIImage(named: "user_home")
                    contentTextField.placeholder = tr(L10n.userAddress)
                }
            
        }
    }
    
}
