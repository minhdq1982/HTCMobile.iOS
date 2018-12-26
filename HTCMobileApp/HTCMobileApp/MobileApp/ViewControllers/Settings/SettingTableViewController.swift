//
//  SettingTableViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

class SettingTableViewController: UITableViewController {
    
    @IBOutlet weak var notificationSwitch: UISwitch!
    @IBOutlet weak var newsFeedSwitch: UISwitch!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationSwitch.tintColor = Colours.textColor
        notificationSwitch.layer.cornerRadius = 16
        
        newsFeedSwitch.tintColor = Colours.textColor
        newsFeedSwitch.layer.cornerRadius = 16
        
        setNotificationOn(isOn: notificationSwitch.isOn)
        setNewsfeedOn(isOn: newsFeedSwitch.isOn)
        
        notificationSwitch.addTarget(self, action: #selector(didChangeNotificationSetting(_:)), for: UIControl.Event.valueChanged)
        newsFeedSwitch.addTarget(self, action: #selector(didChangeNewsfeedSetting(_:)), for: UIControl.Event.valueChanged)
    }
    
    func setNotificationOn(isOn: Bool) {
        if isOn {
            notificationSwitch.backgroundColor = Colours.white
        }else{
            notificationSwitch.backgroundColor = Colours.textColor
        }
    }
    
    func setNewsfeedOn(isOn: Bool) {
        if isOn {
            newsFeedSwitch.backgroundColor = Colours.white
        }else{
            newsFeedSwitch.backgroundColor = Colours.textColor
        }
    }
    
    @objc func didChangeNotificationSetting(_ sender: UISwitch) {
        self.setNotificationOn(isOn: sender.isOn)
    }
    
    @objc func didChangeNewsfeedSetting(_ sender: UISwitch) {
        self.setNewsfeedOn(isOn: sender.isOn)
    }
}
