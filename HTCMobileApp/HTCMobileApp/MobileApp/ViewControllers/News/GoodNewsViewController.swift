//
//  GoodNewsViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class GoodNewsViewController: BaseViewController {
    var groupNews: GroupNewsHeaderModel?
    @IBOutlet weak var tableView: UITableView!
    var newsRefresh: RefreshHandler?
    
    override func setupView() {
        super.setupView()
       
        self.tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
        self.tableView.register(LaterNewsCell.nib, forCellReuseIdentifier: LaterNewsCell.identifier)
        
        guard let group = groupNews else {return}
        setHeaderTitle(group.getName())
        
        self.newsRefresh = RefreshHandler(view: self.tableView)
        guard let refreshHandler = newsRefresh else {return}
        
        //call service
        viewModel = GoodNewsViewModel(service: HTCService())
        let source = GoodNewsViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            groupNews: Driver.just(group),
            loadMore: self.tableView.rx.reachedBottomWithoutBounces.asDriver(),
            refresh: refreshHandler.refresh.asDriver(onErrorJustReturn: ()))
        let sink = (viewModel as! GoodNewsViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super .localizable()
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        
        if let sink = sink as? GoodNewsViewModel.Sink {
            sink.itemSource
                .drive(self.tableView.rx.itemsSource())
                .disposed(by: disposeBag)

            self.tableView.rx.modelSelected(NewsModel.self)
                .asObservable()
                .subscribe({ (new) in
                    if let newsDetailVC = R.storyboard.news.newsDetailViewController() {
                        newsDetailVC.news = new.element
                        self.navigationController?.pushViewController(newsDetailVC, animated: true)
                    }
                })
                .disposed(by: disposeBag)
            
            //  Handle end refresh animation
            guard let refreshHandler = self.newsRefresh else {return}
            refreshHandler.refresh.asObservable()
                .subscribe(onNext: {[weak self] _ in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                        self?.newsRefresh?.end()
                    })
                }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - functions
    
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
