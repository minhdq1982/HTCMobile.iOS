//
//  ConsultantInstallmentViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class ConsultantInstallmentViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let price: Variable<String> = Variable("")
    let percentagePrice: Variable<String> = Variable("")
    let percentage: Variable<String> = Variable("")
    let duration: Variable<String> = Variable("")
    let theFirstInterest: Variable<String> = Variable("")
    let theSecondInterest: Variable<String> = Variable("")
    
    override func setupView() {
        super.setupView()
        
        self.collectionView.register(InstallmentCollectionViewCell.nib, forCellWithReuseIdentifier: InstallmentCollectionViewCell.identifier)
        self.collectionView.register(R.nib.installmentHeaderCollectionView(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "InstallmentHeaderCollectionView")
        
        //  Cars layout
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 220)
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 472)
        self.collectionView.collectionViewLayout = collectionLayout
        
        viewModel = ConsultantInstallmentViewModel(service: HTCService())
        let source = ConsultantInstallmentViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()))
        
        let sink = (viewModel as! ConsultantInstallmentViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Tư vấn trả góp")
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? ConsultantInstallmentViewModel.Sink {
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(configureCell: {(ds, cv, ip, item) -> UICollectionViewCell in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: item.identifier, for: ip) as! BaseCollectionViewCell
                cell.setDataContext(indexPath: ip, data: item)
                if let installmentCell = cell as? InstallmentCollectionViewCell {
                    if ip.row == 0 {
                        installmentCell.upperLineView.isHidden = true
                    }else{
                        installmentCell.upperLineView.isHidden = false
                    }
                }
                return cell
                
            }, configureSupplementaryView: {[weak self] (ds, cv, kind, ip) -> UICollectionReusableView in
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "InstallmentHeaderCollectionView", for: ip) as! InstallmentHeaderCollectionView
                    guard let s = self else {return UICollectionReusableView()}
                    
                    headerView.loanTextField.rx.text.orEmpty.asDriver()
                        .drive(s.price)
                        .disposed(by: s.disposeBag)
                    headerView.percentageTextField.rx.text.orEmpty.asDriver()
                        .drive(s.percentagePrice)
                        .disposed(by: s.disposeBag)
                    headerView.percentageTextField.rx.text.orEmpty.asDriver()
                        .drive(s.percentage)
                        .disposed(by: s.disposeBag)
                    headerView.monthsTextField.rx.text.orEmpty.asDriver()
                        .drive(s.duration)
                        .disposed(by: s.disposeBag)
                    headerView.interestFirstYearTextField.rx.text.orEmpty.asDriver()
                        .drive(s.theFirstInterest)
                        .disposed(by: s.disposeBag)
                    headerView.interestSecondYearTextField.rx.text.orEmpty.asDriver()
                        .drive(s.theSecondInterest)
                        .disposed(by: s.disposeBag)
                    
                    return headerView
                }
                return UICollectionReusableView()
            })
            sink.itemsSource
                .drive(self.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
