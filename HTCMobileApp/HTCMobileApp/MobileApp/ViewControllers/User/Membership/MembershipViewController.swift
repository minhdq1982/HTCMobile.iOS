//
//  MembershipViewController.swift
//  HTCMobileApp
//
//  Created by admin on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class MembershipViewController: BaseViewController {
    // MARK: - Outlet
    
    @IBOutlet weak var noDataLabel: UILabel!
    var listMembershipItem = [MembershipItem]()
    let membershipCards: Variable<[CardModel]> = Variable([])
    let user: Variable<User> = Variable(User(name: "", avatar: "", phone: "", birthday: "", email: "", idenfierId: "", address: "", cars: [], cards: []))
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addMembershipButton: UIButton!
    
    //MARK: LifeCycle
    override func setupView() {
        super .setupView()
        
        self.tableView.register(UINib(nibName: "MemberCell", bundle: nil), forCellReuseIdentifier: "MemberCell")
        self.tableView.register(UINib(nibName: "MembershipHeader", bundle: nil), forHeaderFooterViewReuseIdentifier: "MembershipHeader")


        viewModel = MembershipViewModel(service: Service())
        let source = MembershipViewModel.Source(viewWillAppear: self.rx.viewWillAppear.asDriver(onErrorJustReturn: ()), cards: membershipCards.asDriver())
        let sink = (viewModel as! MembershipViewModel).transform(source: source)
        self.bindData(sink)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
    override func localizable() {
        super .localizable()
    }
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? MembershipViewModel.Sink {
            sink.itemsSource.asObservable()
                .subscribe(onNext: { [weak self] (cards) in
                    guard let s = self else { return }
                    s.reloadData(cards: cards)
                }).disposed(by: disposeBag)
        }
       
    }
    // MARK: - funtions
    func reloadData(cards: [CardModel]) {
        if cards.count <= 0 {
            self.noDataLabel.isHidden = false
        } else {
            self.noDataLabel.isHidden = true
        }
        self.listMembershipItem.removeAll()
        var agencySet = Set<String>()
        for i in 0..<cards.count {
            agencySet.insert(cards[i].agency?.getName() ?? "")
        }
        for name in agencySet {
            let items = cards.filter{$0.agency?.getName() == name}
            print("Set: \(name)")
            self.listMembershipItem.append(MembershipItem(isExpand: false, title: name, cards: items))
        }
        self.tableView.reloadData()
    }
    @IBAction func onAddMembership(_ sender: Any) {
        if let addMemberVC = R.storyboard.addMember.addMemberViewController() {
            navigationController?.pushViewController(addMemberVC, animated: true)
        }
    }
}
// MARK: - extension
extension MembershipViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 254
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return listMembershipItem.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if listMembershipItem[section].isExpand == true {
           return listMembershipItem[section].cards.count
        }else{
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: MemberCell = self.tableView.dequeueReusableCell(withIdentifier: "MemberCell", for: indexPath) as? MemberCell else {
            return UITableViewCell()
        }
        let indexList = listMembershipItem[indexPath.section].cards[indexPath.row]
        cell.selectionStyle = .none
        
        cell.row = indexPath.row
        cell.delegate = self
        cell.customInit(indexList.getCardNo(),
                        indexList.getUsername(),
                        indexList.getRank(),
                        indexList.getLicensePlate(),
                        indexList.agency?.getName() ?? "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header: MembershipHeader = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "MembershipHeader") as? MembershipHeader else {
            return UITableViewHeaderFooterView()
        }
        header.section = section
        header.delegate = self
        header.setIsOnExpand(listMembershipItem[section].isExpand)
        header.customInit(listMembershipItem[section].title)
        return header
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let detailVC = R.storyboard.user.detailCardViewController() {
            detailVC.listMembershipItem = listMembershipItem
            detailVC.memberCardItems.value = self.membershipCards.value
            
            // get index card
            for i in 0..<self.membershipCards.value.count {
                if membershipCards.value[i].getId() == listMembershipItem[indexPath.section].cards[indexPath.row].getId() {
                     detailVC.indexItem.value = i
                }
            }
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
extension MembershipViewController: MembershipHeaderDelegate {
    func touchSelection(_ section: Int, _ header: MembershipHeader) {
        listMembershipItem[section].isExpand = !listMembershipItem[section].isExpand
        self.tableView.beginUpdates()
        self.tableView.reloadSections([section], with: .automatic)
        self.tableView.endUpdates()
    }
}
extension MembershipViewController: MemberCellDelegate {
    func useCard(row: Int?) {
        print("use card \(row)")
        guard let row = row else {
            return
        }
        // use card
        if let alert = R.storyboard.useCardAlert.useCardAlertViewController() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            alert.cardNo = self.membershipCards.value[row].getCardNo()
            alert.rank = self.membershipCards.value[row].getRank()
            alert.brand = self.membershipCards.value[row].getAgencyNameDisplay()
            appDelegate.tabbar?.present(alert, animated: true, completion: nil)
        }
    
    }

    
    
}
