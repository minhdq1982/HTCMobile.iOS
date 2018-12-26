//
//  FeedbackViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/1/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import DropDown
import RxSwift
import RxCocoa

class FeedbackViewController: BaseViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var sendButton: CustomButton!
    
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneTextField: UITextField!
    @IBOutlet weak var licensePlateTextField: UITextField!
    @IBOutlet weak var issueButton: UIButton!
    @IBOutlet weak var issueTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextField: UITextField!
    
    let dropDown = DropDown()
    
    var issues: [String] = ["Kỹ thuật", "Chính sách bảo hành", "Thái độ phục vụ", "Vấn đề khác"]
    
    override func setupView() {
        super.setupView()
        
        viewModel = FeedbackViewModel(service: HTCService())
        let source = FeedbackViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()), sendAction: self.sendButton.rx.tap.asDriver())
        
        let sink = (viewModel as! FeedbackViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Gửi biểu mẫu")
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? FeedbackViewModel.Sink {
            sendButton.rx.tap.asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.dismissKeyboard()
                    self?.success()
                    
                }).disposed(by: disposeBag)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func tapIssueAction(_ sender: Any) {
        self.dismissKeyboard()
        self.showIssueDropdown()
    }
    
    func showIssueDropdown() {
        dropDown.anchorView = self.issueButton
        dropDown.dataSource = issues
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            self.issueTextField.text = item
        }
        dropDown.direction = .bottom
        dropDown.show()
    }
    
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func success()  {
        if let alert = R.storyboard.support.feedbackSuccessAlertView() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            appDelegate.tabbar?.present(alert, animated: true, completion: nil)
            alert.onAgree.asObservable()
                .skip(1)
                .subscribe(onNext: { _ in
                    
                }).disposed(by: disposeBag)
            alert.onCreateNewFeedback.asObservable()
                .skip(1)
                .subscribe(onNext: { _ in
                    
                }).disposed(by: disposeBag)
        }
    }
}
