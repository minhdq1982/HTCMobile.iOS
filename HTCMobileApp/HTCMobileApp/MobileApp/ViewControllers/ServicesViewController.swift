//
//  ServicesViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ServicesViewController: BaseViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var addAppointmentButton: UIButton!
    @IBOutlet weak var segmentView1: SegmentView!
    @IBOutlet weak var segmentView2: SegmentView!
    
    let selectedIndex: Variable<Int> = Variable(0)
    
    let scrollMinHeight: CGFloat = 180
    let scrollMaxHeight: CGFloat = 760
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        if priceView.isHidden {
//            self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: scrollMinHeight)
//        }else{
            //self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: scrollMaxHeight)
//        }
    }
    
    override func setupView() {
        super.setupView()
        
        self.tableView.register(AppointmentScheduleCell.nib, forCellReuseIdentifier: AppointmentScheduleCell.identifier)
        self.tableView.rowHeight = 128
        self.tableView.separatorStyle = .none
        
        viewModel = ServicesViewModel(service: HTCService())
        let source = ServicesViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()))
        let sink = (viewModel as! ServicesViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle(tr(L10n.servicesTitle))
        self.setSelectedSegment(index: 0)
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? ServicesViewModel.Sink {
            
            sink.appointmentItemsSource
                .asObservable()
                .bind(to: tableView.rx.items) { (tableView, row, element) in
                    let cell = tableView.dequeueReusableCell(withIdentifier: element.identifier) as! AppointmentScheduleCell
                    cell.setDataContext(indexPath: IndexPath(row: row, section: 0), data: element)
                    if row >= 2 {
                        cell.setAvailable(false)
                    }else{
                        cell.setAvailable(true)
                    }
                    return cell
                }
                .disposed(by: disposeBag)
            
//            sink.appointmentItemsSource
//                .drive(self.tableView.rx.itemsSource())
//                .disposed(by: disposeBag)
            
            self.addAppointmentButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.addAppointment()
                }).disposed(by: disposeBag)
            segmentView1.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.setSelectedSegment(index: 0)
                }).disposed(by: disposeBag)
            segmentView2.rx.tapGesture()
                .skip(1)
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.setSelectedSegment(index: 1)
                }).disposed(by: disposeBag)
            tableView.rx.modelSelected(AppointmentScheduleModel.self)
                .asObservable()
                .subscribe(onNext: {[weak self] (appointment) in
                    self?.moveToDetailAppointment(appointment)
                }).disposed(by: disposeBag)
            
        }
    }
    
    func setSelectedSegment(index: Int) {
        if index == 0 {
            segmentView1.setSelected(true)
            segmentView2.setSelected(false)
            self.scrollView.isHidden = true
            self.tableView.isHidden = false
        }else {
            segmentView1.setSelected(false)
            segmentView2.setSelected(true)
            self.scrollView.isHidden = false
            self.tableView.isHidden = true
        }
        
        selectedIndex.value = index
    }
    
    @objc func addAppointment() {
        if let addAppointmentVC = R.storyboard.services.addAppointmentViewController() {
            self.navigationController?.pushViewController(addAppointmentVC, animated: true)
        }
    }
    
    func moveToDetailAppointment(_ appointment: AppointmentScheduleModel) {
        if let detailVC = R.storyboard.services.detailAppointmentViewController() {
            detailVC.appointment = appointment
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
