//
//  NewsViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import SideMenu
import RxSwift
import RxCocoa
import RxDataSources


class NewsViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // segment
    var segmentIndex: Variable<Int> = Variable(0)
    @IBOutlet weak var segment0: SegmentView!
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var segment2: SegmentView!
    
    var newsRefresh: RefreshHandler?
    
    // MARK: - LifeCycle
    override func setupView() {
        super.setupView()
        updateSelectedSegment(0)
        
        self.tableView.register(NewsCell.nib, forCellReuseIdentifier: NewsCell.identifier)
        self.tableView.register(LaterNewsCell.nib, forCellReuseIdentifier: LaterNewsCell.identifier)
        
        self.newsRefresh = RefreshHandler(view: self.tableView)
        guard let refreshHandler = newsRefresh else {return}
        
        //call service
        viewModel = NewsViewModel(service: HTCService())
        let source = NewsViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            segmentIndex: segmentIndex.asDriver(),
            refresh: refreshHandler.refresh.asDriver(onErrorJustReturn: ()),
            loadMore: self.tableView.rx.reachedBottomWithoutBounces.asDriver())
        let sink = (viewModel as! NewsViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    
    override func localizable() {
        super.localizable()
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? NewsViewModel.Sink {
            sink.itemsSource
                .drive(self.tableView.rx.itemsSource())
                .disposed(by: disposeBag)
            
            self.tableView.rx.modelSelected(Any.self)
                .asObservable()
                .subscribe(onNext: { (model) in
                    if let news = model as? NewsModel {
                        if let newsDetailVC = R.storyboard.news.newsDetailViewController() {
                            newsDetailVC.news = news
                            self.navigationController?.pushViewController(newsDetailVC, animated: true)
                        }
                    }else if let youtube = model as? YoutubeItem {
                        if let url = URL(string: String(format: Constants.openYoutubeUrl, youtube.getVideoId())) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }else if let facebook = model as? FacebookItem {
                        if let url = facebook.getFacebookUrl() {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }).disposed(by: disposeBag)
            
            // change segment
            segment0.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.updateSelectedSegment(0)
                }).disposed(by: disposeBag)
            
            segment1.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.updateSelectedSegment(1)
                }).disposed(by: disposeBag)
            
            segment2.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.updateSelectedSegment(2)
                }).disposed(by: disposeBag)
            
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
  
    func updateSelectedSegment(_ index: Int) {
        
        segmentIndex.value = index
        let indexPath = tableView.indexPathForRow(at: CGPoint(x: 0.0, y: 0.0))
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .top)
        segment0.setSelected(false)
        segment1.setSelected(false)
        segment2.setSelected(false)
        
        if index == 0 {
            segment0.setSelected(true)
        }else if index == 1 {
            segment1.setSelected(true)
        }else {
            segment2.setSelected(true)
        }
    }
    
}

