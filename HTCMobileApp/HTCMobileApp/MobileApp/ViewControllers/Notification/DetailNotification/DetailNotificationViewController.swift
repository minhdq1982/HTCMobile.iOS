//
//  DetailNotificationViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/1/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class DetailNotificationViewController: BaseViewController {
    @IBOutlet weak var fullContentLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    var titleContent: String?
    var fullContent: String?
    
    
    override func setupView() {
        super.setupView()
        guard let titleContent = titleContent,
            let fullContent = fullContent else {
                return
        }
        self.titleLabel.text = titleContent
        self.fullContentLabel.text = fullContent
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle(tr(L10n.alertTitle))
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
//        if let sink = sink as? DetailNotificationViewModel.Sink {
//            
//        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
