//
//  AddMemberViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class AddMemberViewController: BaseViewController {
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var addMemberButton: UIButton!
    
    // MARK: - LifeCyle
    override func setupView() {
        super .setupView()
        
        viewModel = AddMemberViewModel(service: HTCService())
        let source = AddMemberViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()),
            code: codeTextField.rx.text.orEmpty.asDriver(),
            addMemberAction: addMemberButton.rx.tap.asDriver())
        let sink = (viewModel as! AddMemberViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super .localizable()
        setHeaderTitle(tr(L10n.userAddMemberTitle))
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        
        if let sink = sink as? AddMemberViewModel.Sink {
            addMemberButton.rx.tap
                .asObservable()
                .subscribe(onNext: { _ in
                    
                }).disposed(by: disposeBag)
            sink.validateCode
                .asObservable()
                .skip(1)
                .subscribe(onNext: {[weak self] (message) in
                    self?.showMessage(message: message, closeAction: {})
                }).disposed(by: disposeBag)
            sink.addMemberResponse
                .asObservable()
                .subscribe(onNext: {[weak self] (card) in
                    self?.showSuccessDialog(card: card)
                }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - functions
    override func tapBackAction(_ sender: Any) {
         navigationController?.popViewController(animated: true)
    }
    
    func showSuccessDialog(card: CardModel) {
        if let alertVC = R.storyboard.customAlert.addCardAlertViewController() {
            alertVC.cardNo = card.getCardNo()
            alertVC.carname = card.getModel()
            alertVC.username = card.getCustomerName()
            alertVC.brand = card.getAgencyName()
            alertVC.licensePlate = card.getLicensePlate()
            alertVC.providesPresentationContextTransitionStyle = true
            alertVC.definesPresentationContext = true
            alertVC.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alertVC.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            appDelegate.tabbar?.present(alertVC, animated: true, completion: nil)
            alertVC.completeAction
                .asObservable()
                .skip(1)
                .subscribe(onNext: {[weak self] _ in
                    self?.navigationController?.popViewController(animated: true)
                }).disposed(by: disposeBag)
        }
    }
}
extension AddMemberViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else { return true }
        let count = text.count + string.count - range.length
        return count <= 12
    }
}
