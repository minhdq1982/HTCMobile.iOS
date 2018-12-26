//
//  DetailCardViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import EFQRCode

class DetailCardViewController: BaseViewController {
    

    @IBOutlet weak var tableView: UITableView!

    var listMembershipItem =  [MembershipItem]()
    var memberCardItems: Variable<[CardModel]> = Variable([])
    var indexItem: Variable<Int> = Variable(0)
    
    override func setupView() {
        super .setupView()
        
      
        
        self.tableView.register(HeadDetailCell.nib, forCellReuseIdentifier: HeadDetailCell.identifier)
        self.tableView.register(CardDetailCell.nib, forCellReuseIdentifier: CardDetailCell.identifier)
             self.tableView.register(CarDetailCell.nib, forCellReuseIdentifier: CarDetailCell.identifier)
        self.tableView.register(BenefitDetailCardCell.nib, forCellReuseIdentifier: BenefitDetailCardCell.identifier)
        self.tableView.register(BottomDetailCardCell.nib, forCellReuseIdentifier: BottomDetailCardCell.identifier)
     
        
        viewModel = DetailCardViewModel(service: HTCService())
        let source = DetailCardViewModel.Source(viewWillAppear: rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()), membershipCard: memberCardItems.asDriver(), indexItem: indexItem.asDriver())
        let sink = (viewModel as! DetailCardViewModel).transform(source: source)
        self.bindData(sink)
    }
    override func localizable() {
        super .localizable()
        setHeaderTitle("Thông tin thẻ")
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
        if let sink = sink as? DetailCardViewModel.Sink {
            
            let dataSource = RxTableViewSectionedReloadDataSource<Section>(
                configureCell: {[weak self] ds, tv, ip, item in
                    let cell = tv.dequeueReusableCell(withIdentifier: item.identifier, for: ip) as! BaseTableViewCell
                    guard let s = self else {return cell}
                    cell.setDataContext(indexPath: ip, data: item)
                    if let cell = cell as? HeadDetailCell {
                        cell.delegate = s
                        cell.firstTimeShowPager = s.indexItem.value
                    } else {

                    }
                    return cell
                },
                titleForHeaderInSection: { ds, index in
                    return ds.sectionModels[index].header
            })
            
            // bind data table view
          
            sink.itemsSource
                .drive(self.tableView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
//             select benefit
//           self.tableView.rx
//                .modelSelected(BenefitModel.self)
//                .asObservable()
//               .subscribe { [weak self] (benefit) in
//                if let benefitDetailVC = R.storyboard.user.benefitDetailViewController() {
//                    benefitDetailVC.detail = benefit.element?.getDetail()
//                    benefitDetailVC.benefitId.value = (benefit.element?.getId())!
//                    benefitDetailVC.listMembershipItem.value = self!.listMembershipItem
//                    self!.navigationController?.pushViewController(benefitDetailVC, animated: true)
//                }
//
//            }
//
//            .disposed(by: disposeBag)
            
           
            
            self.tableView.rx.itemSelected
                .subscribe(onNext: { [weak self] indexPath in
                    guard let s = self else {
                        return
                    }
                    guard let cellDetail = s.tableView.cellForRow(at: indexPath) as? BenefitDetailCardCell else {
                        return
                    }
                        if let benefitDetailVC = R.storyboard.user.benefitDetailViewController() {
                            if let detail = cellDetail.benefitModel?.getDetail() {
                                print("Tund        " + detail)
                                benefitDetailVC.detail = detail
                            }
                            
                            if let id = cellDetail.benefitModel?.getId() {
                                print(id)
                                benefitDetailVC.benefitId.value = id
                            }
                            benefitDetailVC.cards.value = s.memberCardItems.value
                            s.navigationController?.pushViewController(benefitDetailVC, animated: true)
                    }
                    }).disposed(by: disposeBag)
        }
    }
    
  
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
extension DetailCardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 353
        case 1:
            return 306
        case 2:
            return 274
        case 3:
            return UITableView.automaticDimension
            
        default:
            return 71
        }
    }
}


extension DetailCardViewController: HeadDetailCellDelagate {
    func useCard(card: CardModel) {
        print("use card")
        if let alert = R.storyboard.useCardAlert.useCardAlertViewController() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            alert.cardNo = card.getCardNo()
            alert.rank = card.getRank()
            alert.brand = card.getAgencyNameDisplay()
            appDelegate.tabbar?.present(alert, animated: true, completion: nil)
            
        }

    }
    
    func deleteCard(_ vinno: String) {
        // do something
        print("delete card \(vinno)")
        
//        let title = tr(L10n.alertTitle)
        let msg = tr(L10n.alertAskMember)
      
        
        self.showConfirmMessage(message: msg, confirmAction: {
            if let userVC = R.storyboard.user.userProfileViewController() {
                userVC.segmentIndex.value = 2
                self.navigationController?.pushViewController(userVC, animated: true)
            }
        }) {
            print("cancel")
        }
     

    }
    
    func gotoHistoryVC() {
        // do something
        if let historyCardVC = R.storyboard.user.historyCardViewController() {
            historyCardVC.membershipCode.value = self.memberCardItems.value[indexItem.value].getMembershipCode() 
            navigationController?.pushViewController(historyCardVC, animated: true)
        }
    }

    func sendSelectedItem(_ index: Int) {
        print("recived: \(index)")
        self.indexItem.value = index
        let firstIndexPath = NSIndexPath(row: 0, section: 0)
        self.tableView.selectRow(at: firstIndexPath as IndexPath, animated: true, scrollPosition: .top)
    }
    
    
}

    
    

