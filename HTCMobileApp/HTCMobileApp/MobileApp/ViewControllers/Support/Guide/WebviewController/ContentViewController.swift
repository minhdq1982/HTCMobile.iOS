//
//  ContentViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

protocol ContentViewControllerDelegate {
    func didChooseContentAtIndex(_ index: Int)
}

class ContentViewController: BaseViewController {
    @IBOutlet weak var tableOfContentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: ContentViewControllerDelegate?
    
    let warranties: Variable<[WarrantyPolicyModel]> = Variable([])
    let guideBook: Variable<BookGuidanceModel> = Variable(BookGuidanceModel())
    
    let contents: Variable<[ContentMenuModel]> = Variable([])
    
    override func setupView() {
        super.setupView()
        
        self.tableView.register(ContentCell.nib, forCellReuseIdentifier: ContentCell.identifier)
        
        warranties.asObservable()
            .skip(1)
            .subscribe(onNext: {[weak self] (warranties) in
                self?.contents.value.removeAll()
                if warranties.count > 0 {
                    var counter: Int = 0
                    for warranty in  warranties {
                        self?.contents.value.append(ContentMenuModel(title: warranty.getName(), isParrent: false))
                        counter += 1
                    }
                }
            }).disposed(by: disposeBag)
        
        guideBook.asObservable()
            .skip(1)
            .subscribe(onNext: {[weak self] (model) in
                if let contents = model.contents, contents.count > 0 {
                    var counter: Int = 0
                    for item in  contents {
                        self?.contents.value.append(ContentMenuModel(title: item.getTitle(), isParrent: item.isParrent()))
                        counter += 1
                    }
                }
            }).disposed(by: disposeBag)
        
        self.contents.asDriver()
            .drive(self.tableView.rx.itemsSource())
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (index) in
                self?.delegate?.didChooseContentAtIndex(index.row)
            }).disposed(by: disposeBag)
    }
}
