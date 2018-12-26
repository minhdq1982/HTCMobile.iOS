//
//  BenefitDetailViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class BenefitDetailViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentLabel: UILabel!
    var detail: String?
    var benefitId: Variable<Int> = Variable(0)
    var cards: Variable<[CardModel]> = Variable([])
    
    // MARK: - LifeCycle
    override func setupView() {
        super .setupView()
        
        tableView.register(AgencyBenefitCell.nib, forCellReuseIdentifier: AgencyBenefitCell.identifier)
        
        viewModel = BenefitDetailViewModel(service: HTCService())
        let source = BenefitDetailViewModel.Source(viewWillAppear: rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()), benefitId: benefitId.asDriver(), cards: cards.asDriver())
        let sink = (viewModel as! BenefitDetailViewModel).transform(source: source)
        self.bindData(sink)
        
    }
    
    override func localizable() {
        super .localizable()
        setHeaderTitle(tr(L10n.benefitTitle))
        // setContent
        if let detail = detail {
            contentLabel.text = detail
        }
        
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? BenefitDetailViewModel.Sink {
            
            sink.itemSource
                .drive(self.tableView.rx.itemsSource())
                .disposed(by: disposeBag)
        }
    }
    
    // MARK: - function
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
//extension BenefitDetailViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 110
//    }
//}
