//
//  SupportTableViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/1/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
class SupportTableViewController: UITableViewController {
    
    @IBOutlet weak var searchAgencyLabel: UILabel!
    @IBOutlet weak var guideLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIScreen.main.bounds.size.width == 320 {
            self.tableView.isScrollEnabled = true
        }else {
            self.tableView.isScrollEnabled = false
        }
    }
}
