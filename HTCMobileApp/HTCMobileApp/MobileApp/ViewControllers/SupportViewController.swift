//
//  SupportViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import SideMenu

class SupportViewController: BaseViewController {
    
    var supportMenuVC: SupportTableViewController?
    @IBOutlet weak var hotlineButton: UIButton!
    var quickAccessMap: Bool = false
    
    override func setupView() {
        super.setupView()
        self.hotlineButton.layer.borderColor = UIColor.gray.cgColor
        self.hotlineButton.layer.borderWidth = 0.5
        self.hotlineButton.layer.cornerRadius = 30.0
        self.hotlineButton.layer.masksToBounds = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if quickAccessMap {
            if let mapVC = R.storyboard.support.mapViewController() {
                self.navigationController?.pushViewController(mapVC, animated: true)
            }
            quickAccessMap = false
        }
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle(tr(L10n.supportTitle))
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? SupportViewModel.Sink {
            
        }
    }
    
    @IBAction func callHotlineCenter(_ sender: Any) {
        if let setting = appDelegate.setting {
            if let phoneNumber = setting.hotline?.replacingOccurrences(of: ".", with: "") {
                let phoneLink = "tel://\(phoneNumber)"
                if let url = URL(string: phoneLink) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    func callCustomerSupport() {
        if let setting = appDelegate.setting {
            if let phoneNumber = setting.hotline_Complain?.replacingOccurrences(of: ".", with: "") {
                let phoneLink = "tel://\(phoneNumber)"
                if let url = URL(string: phoneLink) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "supportMenu" {
            if let supportMenuVC = segue.destination as? SupportTableViewController {
                supportMenuVC.tableView.rx.itemSelected
                    .asObservable()
                    .subscribe(onNext: {[weak self] (indexPath) in
                        
                        guard let s = self else {return}
                        
                        switch indexPath.section {
                        case 0:
                            if let pulleyVC = R.storyboard.support.htcPulleyViewController() {
                                s.navigationController?.pushViewController(pulleyVC, animated: true)
                            }
                            
//                            if let mapVC = R.storyboard.support.mapViewController() {
//                                s.navigationController?.pushViewController(mapVC, animated: true)
//                            }
                        case 1:
                            if let guideVC = R.storyboard.support.guideViewController() {
                                s.navigationController?.pushViewController(guideVC, animated: true)
                            }
                        case 2:
                            if let alert = R.storyboard.support.feedbackAlertView() {
                                alert.providesPresentationContextTransitionStyle = true
                                alert.definesPresentationContext = true
                                alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
                                alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
                                appDelegate.tabbar?.present(alert, animated: true, completion: nil)
                                
                                alert.chooseAction.asObservable()
                                    .skip(1)
                                    .subscribe(onNext: { (value) in
                                        if value == 0 {
                                            s.callCustomerSupport()
                                        }else if value == 1 {
                                            if let feedbackVC = R.storyboard.support.feedbackViewController() {
                                                s.navigationController?.pushViewController(feedbackVC, animated: true)
                                            }
                                        }
                                    }).disposed(by: s.disposeBag)
                            }
                            
                        default:
                            break
                        }
                        
                    }).disposed(by: disposeBag)
            }
        }
    }
    
}
