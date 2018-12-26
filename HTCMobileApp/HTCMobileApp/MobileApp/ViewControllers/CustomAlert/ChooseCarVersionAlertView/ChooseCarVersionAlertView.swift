//
//  ChooseCarVersionAlertView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxDataSources
import RxCocoa

protocol ChooseCarVersionAlertViewDelegate {
    func chooseVersion(version: CarVersionModel)
}

class ChooseCarVersionAlertView: BaseViewController {
    
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var carImageVIew: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var carNameLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let selectedVersion: Variable<Int> = Variable(0)
    let versions: Variable<[CarVersionModel]> = Variable([CarVersionModel(name: "1.2 MT Tiêu Chuẩn"), CarVersionModel(name: "1.2 MT"), CarVersionModel(name: "1.2 AT")])
    
    let onCancel: Variable<Bool> = Variable(false)
    let onAgree: Variable<CarVersionModel> = Variable(CarVersionModel(name: "1.2 MT Tiêu Chuẩn"))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
        
        self.tableView.register(CarVersionCell.nib, forCellReuseIdentifier: CarVersionCell.identifier)
        self.tableView.rowHeight = 44
    }
    
    override func setupView() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
//        versions.asObservable()
        versions.asObservable()
            .bind(to: tableView.rx.items) {[weak self] (tableView, row, element) in
                let cell = tableView.dequeueReusableCell(withIdentifier: element.identifier) as! CarVersionCell
                if self?.selectedVersion.value == row {
                    cell.setStatus(true)
                }else{
                    cell.setStatus(false)
                }
                return cell
            }.disposed(by: disposeBag)
        tableView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (indexPath) in
                self?.selectVersionAtIndex(indexPath)
            }).disposed(by: disposeBag)
        
    }
    
    func selectVersionAtIndex(_ indexPath: IndexPath)  {
        for i in 0...(versions.value.count - 1) {
            if let cell = tableView.cellForRow(at: IndexPath(row: i, section: 0)) as? CarVersionCell {
                cell.setStatus(i == indexPath.row)
            }
        }
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    @IBAction func onAgree(_ sender: Any) {
        onAgree.value = versions.value[0]
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onDismiss(_ sender: Any) {
        onCancel.value = true
        self.dismiss(animated: true, completion: nil)
    }
}
