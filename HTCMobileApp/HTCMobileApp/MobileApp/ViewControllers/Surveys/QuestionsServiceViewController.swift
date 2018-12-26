//
//  QuestionsServiceViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/28/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import FSPagerView
import RxDataSources


class QuestionsServiceViewController: BaseViewController {
    
    // MARK: - Outlet and Variable

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var pageControlView: PageControlSurveyView!
    @IBOutlet weak var previousButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false

        }
    }
    var arrPagers: [Section] = []
    var firstPage: Section?
    var secondPage: Section?
    var thirdPage: Section?
    var fourthPage: Section?
    var fifthPage: Section?
    var sixthPage: Section?
    var seventhPage: Section?
    var eighthPage: Section?
    var ninethPage: Section?
    var tenthPage: Section?
    
    var directionSwipe: String = "left"
    let checkScroll: Variable<Bool> = Variable(true)

    var surveyType: String = "service"
    var indexPage: Variable<Int> = Variable(0)
   

    
    override func setupView() {
        super.setupView()
        
    
        
        self.setData()
        
        //set pageControl
        self.pageControlView.setStatusButton(index: 0, status: StatusPage.CURRENT.typeValue())
        
        self.fsPagerView.register(UINib(nibName: "SurveyPagerCell", bundle: nil), forCellWithReuseIdentifier: "SurveyPagerCell")
        
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.delegate = self
        self.fsPagerView.dataSource = self
        
        
        viewModel = QuestionsServiceViewModel(service: HTCService())
        let source = QuestionsServiceViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()))
        
        let sink = (viewModel as! QuestionsServiceViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.fsPagerView.itemSize = CGSize(width: UIScreen.main.bounds.width - 48, height: self.fsPagerView.frame.size.height)
        self.fsPagerView.clipsToBounds = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.fsPagerView.reloadData()
    }
    
    override func localizable() {
        super.localizable()
        setHeaderTitle("Khảo sát")
    }
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        if let sink = sink as? QuestionsServiceViewModel.Sink {
            view.isUserInteractionEnabled = true
            
            self.indexPage
                .asObservable()
                .subscribe(onNext: { [weak self] (index) in
                    guard let s = self else { return }
                    if index == 9 {
                        s.submitButton.isHidden = false
                    } else {
                        s.submitButton.isHidden = true
                    }
                }).disposed(by: disposeBag)
            
//            self.checkScroll
//                .asObservable()
//                .subscribe(onNext: { [weak self] (value) in
//                    guard let s = self else { return }
//
//                    print("Check Scroll: \(value)")
//                    if value == true {
//                        self?.showMessage(message: "Quý Khách vui lòng điền đầy đủ thông tin", closeAction: {
//                            print("close")
//                        })
//                    } else {
//                        s.checkScroll.value = false
//                        s.swipeLeft()
//                    }
//                }).disposed(by: disposeBag)
            
            // submit button
            self.submitButton.rx.tap
                .asObservable()
                .subscribe(onNext: { [weak self] (_) in
                    guard let s = self else { return }
                }).disposed(by: disposeBag)
            
            // scroll pageview
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.forwardButton.rx.tap
                    .asObservable()
                    .subscribe { [weak self] (_) in
                        guard let s = self else { return }
                        s.checkResult()
                        
                    }
                    .disposed(by: self.disposeBag)
            }
            
           
          
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.previousButton.rx.tap
                    .asObservable()
                    .subscribe { [weak self] (_) in
                        guard let s = self else { return }
                        s.swipeRight()

                    }.disposed(by: self.disposeBag)
            }
            
//            self.fsPagerView.rx.swipeGesture(UISwipeGestureRecognizer.Direction.left)
//                .asObservable()
//                .subscribe(onNext: { [weak self] (_) in
//                    guard let s = self else { return }
//                       s.checkResult()
//                    }
//            )
//            self.fsPagerView.rx.swipeGesture(UISwipeGestureRecognizer.Direction.right)
//                .asObservable()
//                .subscribe(onNext: { [weak self] (_) in
//                    guard let s = self else { return }
//                        s.swipeRight()
//                    }
//            )
  
//            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
//                configureCell: {[weak self] ds, tv, ip, item in
//                    let cell = tv.dequeueReusableCell(withIdentifier: item.identifier, for: ip) as! BaseTableViewCell
//                    cell.setDataContext(indexPath:ip,data: item )
//                    
//                    
//                    return cell
//                },
//                titleForHeaderInSection: { ds, index in
//                    return ds.sectionModels[index].header
//            })            
        }
    }
    
    // MARK: - functions

    
    func setData() {
        // service question
        
        
        if self.surveyType == "service" {
            firstPage = Section(header: "", items: ServiceQuestion.shared.firstPageData)
            secondPage = Section(header: "", items: ServiceQuestion.shared.secondPageData)
            thirdPage = Section(header: "", items: ServiceQuestion.shared.thirdPageData)
            fourthPage = Section(header: "", items: ServiceQuestion.shared.fourthPageData)
            fifthPage = Section(header: "", items: ServiceQuestion.shared.fifthPageData)
            sixthPage = Section(header: "", items: ServiceQuestion.shared.sixthPageData)
            seventhPage = Section(header: "", items: ServiceQuestion.shared.seventhPageData)
            eighthPage = Section(header: "", items: ServiceQuestion.shared.eighthPageData)
            ninethPage = Section(header: "", items: ServiceQuestion.shared.ninethPageData)
            tenthPage = Section(header: "", items: ServiceQuestion.shared.tenthPageData)
        }
        
        guard let firstPage = self.firstPage,
              let secondPage = self.secondPage,
              let thirdPage = self.thirdPage,
              let fourthPage = self.fourthPage,
              let fifthPage = self.fifthPage,
              let sixthPage = self.sixthPage,
              let seventhPage = self.seventhPage,
              let eighthPage = self.eighthPage,
              let ninethPage = self.ninethPage,
              let tenthPage = self.tenthPage else {
            return
        }
       
        
     
        arrPagers.append(firstPage)
        arrPagers.append(secondPage)
        arrPagers.append(thirdPage)
        arrPagers.append(fourthPage)
        arrPagers.append(fifthPage)
        arrPagers.append(sixthPage)
        arrPagers.append(seventhPage)
        arrPagers.append(eighthPage)
        arrPagers.append(ninethPage)
        arrPagers.append(tenthPage)
        
    }
    
    override func tapBackAction(_ sender: Any) {
        self.showConfirmMessage(message: "Quý khách muốn thoát?",
                                confirmAction: {
                                    ServiceQuestion.shared.indexPage = 0
                                    ServiceResult.shared.resetAllResults()
                                    self.navigationController?.popViewController(animated: true)
        }) {
            print("close")
        }
      
       
        
    }
    override func tapNotificationAction(_ sender: Any) {
        //
    }
    
    func checkResult() {
        print("da chay vao day")
        if self.surveyType == "service" {
            if ServiceResult.shared.checkPageAnswer(page: self.indexPage.value) == true {
                self.showMessage(message: "Quý Khách vui lòng điền đầy đủ thông tin", closeAction: {
                    print("close")
                })
            } else {
                self.swipeLeft()
                self.fsPagerView.scrollToItem(at: self.indexPage.value, animated: true)
            }
        }
       
    }
    
    func swipeLeft() {
        if self.indexPage.value < 9 {
          
            self.indexPage.value += 1
            print("Page: \(self.indexPage)")
            
            //setup page control
            self.pageControlView.setStatusButton(index: self.indexPage.value, status: StatusPage.CURRENT.typeValue())
            self.pageControlView.setStatusButton(index: self.indexPage.value - 1, status: StatusPage.SELECTED.typeValue())
            
            // set global index page
            ServiceQuestion.shared.indexPage = self.indexPage.value

            // scroll fspagerview and set global index page
    
          
          
        }
        
    }
    func swipeRight() {
        if self.indexPage.value > 0 {
            self.indexPage.value -= 1
            print("Page: \(self.indexPage)")
            self.fsPagerView.scrollToItem(at: self.indexPage.value, animated: true)
            
            //setup page control
            self.pageControlView.setStatusButton(index: self.indexPage.value, status: StatusPage.CURRENT.typeValue())
            if ServiceResult.shared.checkPageAnswer(page: self.indexPage.value + 1) ==  false {
                self.pageControlView.setStatusButton(index: self.indexPage.value + 1, status: StatusPage.SELECTED.typeValue())
            } else {
                self.pageControlView.setStatusButton(index: self.indexPage.value + 1, status: StatusPage.NORMAL.typeValue())
            }
            
            
            // set global index page
            ServiceQuestion.shared.indexPage = self.indexPage.value
         
      
        }
        
    }

}

extension QuestionsServiceViewController: FSPagerViewDelegate, FSPagerViewDataSource {
    func numberOfItems(in pagerView: FSPagerView) -> Int {
        return arrPagers.count
    }
    
    
    func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = fsPagerView.dequeueReusableCell(withReuseIdentifier: "SurveyPagerCell", at: index)
        guard let aCell = cell as? SurveyPagerCell else {
            return FSPagerViewCell()
        }
        aCell.dataSource(sources: [arrPagers[index]])
        return cell
    }
    
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
        self.indexPage.value = pagerView.currentIndex
        ServiceQuestion.shared.indexPage = self.indexPage.value
    }
    
    

    func pagerViewWillBeginDragging(_ pagerView: FSPagerView) {
//        if ServiceResult.shared.checkPageAnswer(page: pagerView.currentIndex - 1) {
//            self.checkResult()
//        }
        
    }
  
    
    
    
}
