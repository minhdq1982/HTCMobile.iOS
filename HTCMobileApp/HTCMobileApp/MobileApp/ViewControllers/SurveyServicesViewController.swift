//
//  SurveyServicesViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/28/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift

class SurveyServicesViewController: BaseViewController {
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func onNext(_ sender: Any) {
        print("on next")
    }
    
    override func setupView() {
        super.setupView()
        
        viewModel = SurveyServicesViewModel(service: HTCService())
        let source = SurveyServicesViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()))
        
        let sink = (viewModel as! SurveyServicesViewModel).transform(source: source)
        self.bindData(sink)
    }
    override func localizable() {
        super.localizable()
        setHeaderTitle("Khảo sát")
    }
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        self.nextButton.rx.tap
            .asObservable()
            .subscribe(onNext: { [weak self] (_) in
                self?.showQuestions()
            }).disposed(by: disposeBag)
        
        if let sink = sink as? SurveyServicesViewModel.Sink {
            sink.listAgencyResponse.asObservable()
                .subscribe(onNext: {(agencys) in
                    for item in agencys {
                        MenuSpinner.shared.agencys.append(item.getName())
                    }
                }).disposed(by: disposeBag)

            sink.listCarResponse.asObservable()
                .subscribe(onNext: {(cars) in
                    for item in cars {
                        MenuSpinner.shared.cars.append(item.getName())
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    // MARK: - functions
    
    func showQuestions() {
        if let questionsVC = R.storyboard.surveys.questionsServiceViewController() {
            print("begin do survey")
            navigationController?.pushViewController(questionsVC, animated: false)
//            let questions = [QuestionModel(type: TypeQuestionEnum.SPINNER.typeValue(), question: "", answers: [])]
//            print(questions[0].identifier)

        }
    }
    
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    override func tapNotificationAction(_ sender: Any) {
        
    }
}
