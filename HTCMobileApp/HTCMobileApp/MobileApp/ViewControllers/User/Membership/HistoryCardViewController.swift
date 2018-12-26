//
//  HistoryCardViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/8/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import ActionSheetPicker_3_0

class HistoryCardViewController: BaseViewController {
    // MARK: - Outlet
    @IBOutlet weak var endButton: UIButton!
    @IBOutlet weak var beginButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var beginDateLabel: UILabel!
    @IBOutlet weak var endDateLabel: UILabel!
    
    // segment
    @IBOutlet weak var segment0: SegmentView!
    @IBOutlet weak var segment1: SegmentView!
    @IBOutlet weak var segment2: SegmentView!
    let segmentIndex: Variable<Int> = Variable(0)
    @IBOutlet weak var noDataLabel: UILabel!
    
    // variable
    let beginDate: Variable<String> =  Variable("13/11/2018")
    let endDate: Variable<String> =  Variable("13/12/2018")
    let membershipCode: Variable<String> = Variable("")
    var newsRefresh: RefreshHandler?
    
    // MARK: - lifecycle
    
    override func setupView() {
        super .setupView()
        updateSelectedSegment(0)
    
        // set up tableview
        tableView.register(NoUsingPointCell.nib, forCellReuseIdentifier: NoUsingPointCell.identifier)
        tableView.register(HistoryCardCell.nib, forCellReuseIdentifier: HistoryCardCell.identifier)
        tableView.register(UsingIncentiveCell.nib, forCellReuseIdentifier: UsingIncentiveCell.identifier)
        
        self.newsRefresh = RefreshHandler(view: self.tableView)
        guard let refreshHandler = newsRefresh else {return}

      
        
        viewModel = HistoryCardViewModel(service: HTCService())
        let source = HistoryCardViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            segmentIndex: segmentIndex.asDriver(),
            beginDate: beginDate.asDriver(),
            endDate: endDate.asDriver(),
            refresh: refreshHandler.refresh.asDriver(onErrorJustReturn: ()),
            loadMore: self.tableView.rx.reachedBottomWithoutBounces.asDriver(),
            membershipCode: membershipCode.asDriver())
        let sink = (viewModel as! HistoryCardViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super .localizable()
        setHeaderTitle(tr(L10n.historyTitle))
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        
        if let sink = sink as? HistoryCardViewModel.Sink {
            self.beginButton.rx.tap
                .asObservable()
                .subscribe(onNext: {  [weak self] (_) in
                    guard let s = self else { return }
                    s.showCalendar(type: "begindate")
                }).disposed(by: disposeBag)
            
            self.endButton.rx.tap
                .asObservable()
                .subscribe(onNext: {  [weak self] (_) in
                    guard let s = self else { return }
                    s.showCalendar(type: "enddate")
                }).disposed(by: disposeBag)
            
            sink.itemsSource
                .drive(self.tableView.rx.itemsSource())
                .disposed(by: disposeBag)
        
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
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    func showCalendar(type: String) {
        if let alert = R.storyboard.customAlert.fsCalendarAlertView() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            alert.type = type
            alert.delegate = self
            appDelegate.tabbar?.present(alert, animated: true, completion: nil)
            
        }
    }
    
    
    // find data by date
//    @IBAction func chooseEndDate(_ sender: Any) {
//        let datePicker = ActionSheetDatePicker(title: "CHỌN NGÀY", datePickerMode: .date, selectedDate: Date(), target: self, action: #selector(dateEndPicked(_:)), origin: sender)
//        datePicker?.show()
//    }
//    @IBAction func chooseBeginDate(_ sender: Any) {
//        let datePicker = ActionSheetDatePicker(title: "CHỌN NGÀY", datePickerMode: .date, selectedDate: Date(), target: self, action: #selector(dateBeginPicked(_:)), origin: sender)
//        datePicker?.show()
//    }
//    @objc func dateEndPicked(_ obj: Date) {
//        let str = obj.convertToString()
//        beginDateLabel.text = str
//        beginDate.value = str
//    }
//    @objc func dateBeginPicked(_ obj: Date) {
//        let str = obj.convertToString()
//        beginDateLabel .text = str
//        endDate.value = str
//    }
    
    // load more
    @IBAction func onLoadMore(_ sender: Any) {
    }
    
    func updateSelectedSegment(_ index: Int) {
        
        segmentIndex.value = index
        
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
extension HistoryCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
}

extension HistoryCardViewController: FsCalendarAlertViewDelegate {
    func sendBeginDate(date: String) {
        beginDate.value = date
        beginDateLabel.text = date
    }
    
    func sendEndDate(date: String) {
        endDate.value = date
        endDateLabel.text = date
    }
    
    
}
