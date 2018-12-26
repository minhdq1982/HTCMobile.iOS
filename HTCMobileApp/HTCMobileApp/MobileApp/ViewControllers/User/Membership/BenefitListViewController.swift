//
//  BenefitListViewController.swift
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

class BenefitListViewController: BaseViewController {
    
    // MARK: - Outlet and Variable
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    let membershipCards: Variable<[CardModel]> = Variable([])
    var listBenefitItem = [BenefitItem]()
    
    // MARK: - LifeCycle
    override func setupView() {
        super .setupView()
        self.tableView.register(UINib(nibName: "BenefitCell", bundle: nil), forCellReuseIdentifier: "BenefitCell")
        self.tableView.register(UINib(nibName: "BenefitHeaderCell", bundle: nil), forHeaderFooterViewReuseIdentifier: "BenefitHeaderCell")
      
        
        
        viewModel = BenefitListViewModel(service: HTCService())
        let source = BenefitListViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ())
            , cards: self.membershipCards.asDriver() )
        let sink = (viewModel as! BenefitListViewModel).transform(source: source)
        self.bindData(sink)
    }
    override func localizable() {
        super .localizable()
        setHeaderTitle(tr(L10n.benefitTitle))
    }
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? BenefitListViewModel.Sink {
           sink.itemsSource
            .asObservable()
            .subscribe(onNext: {[weak self] (cards) in
                guard let s = self else { return }
                s.reloadData(cards: cards)
            }).disposed(by: disposeBag)
        }
    }
    // MARK: - functions
    func reloadData(cards: [CardModel]) {
        self.listBenefitItem.removeAll()

        for card in cards {
            self.listBenefitItem.append(BenefitItem(isExpand: false, brand: card.getBrand(), name: card.getModel(), licensePlate: card.getLicensePlate(), benefits: card.benefits ?? []))
        }
        self.tableView.reloadData()
    }
    
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension BenefitListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return  0.0000000000001
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 101
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listBenefitItem.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listBenefitItem[section].isExpand == true {
            return listBenefitItem[section].benefits.count
        }else{
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: BenefitCell = self.tableView.dequeueReusableCell(withIdentifier: "BenefitCell", for: indexPath) as? BenefitCell else {
            return UITableViewCell()
        }
        let indexList = listBenefitItem[indexPath.section].benefits[indexPath.row]
        cell.customInit(title: indexList.getContent())
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header: BenefitHeaderCell = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "BenefitHeaderCell") as? BenefitHeaderCell else {
            return UITableViewHeaderFooterView()
        }
       
        header.section = section
        header.delegate = self
        header.customInit(listBenefitItem[section].getBrand(), name: listBenefitItem[section].getName(), licensePlate: listBenefitItem[section].getlicensePlate())
        header.setIsOnExpand(listBenefitItem[section].isExpand)
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let benefitDetailVC = R.storyboard.user.benefitDetailViewController() {
            let indexList = listBenefitItem[indexPath.section].benefits[indexPath.row]
            benefitDetailVC.detail = indexList.getDetail()
            benefitDetailVC.benefitId.value = indexList.getId()
            benefitDetailVC.cards.value = self.membershipCards.value
            navigationController?.pushViewController(benefitDetailVC, animated: true)
        }
    }
    
}
extension BenefitListViewController: BenefitHeaderDelegate {
    
    func touchSelection(_ section: Int, _ header: BenefitHeaderCell) {
        listBenefitItem[section].isExpand = !listBenefitItem[section].isExpand
        self.tableView.beginUpdates()
        self.tableView.reloadSections([section], with: .automatic)
        self.tableView.endUpdates()
    }
    
    
}

