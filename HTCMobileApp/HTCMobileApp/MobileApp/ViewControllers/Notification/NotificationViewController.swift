//
//  NotificationViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/1/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxCocoa
import RxSwift
import RxDataSources

class NotificationViewController: BaseViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    override func setupView() {
        super.setupView()
        self.collectionView.register(NotificationCollectionViewCell.nib, forCellWithReuseIdentifier: NotificationCollectionViewCell.identifier)
        self.collectionView.register(R.nib.notificationHeaderCollectionView(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "NotificationHeaderCollectionView")
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        
        collectionLayout.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 110)
        collectionLayout.minimumInteritemSpacing = 0
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.headerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 50)
        self.collectionView.collectionViewLayout = collectionLayout
        
        viewModel = NotificationViewModel(service: HTCService())
        let source = NotificationViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ())
        )
        let sink = (viewModel as! NotificationViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle(tr(L10n.alertTitle))
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? NotificationViewModel.Sink {
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(configureCell: {(ds, cv, ip, item) -> UICollectionViewCell in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: item.identifier, for: ip) as! NotificationCollectionViewCell
                cell.topSeparatorView.isHidden = ip.row == 0
                cell.setDataContext(indexPath: ip, data: item)
                return cell
                
            }, configureSupplementaryView: { (ds, cv, kind, ip) -> UICollectionReusableView in
                if kind == UICollectionView.elementKindSectionHeader {
                    let headerView = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "NotificationHeaderCollectionView", for: ip) as! NotificationHeaderCollectionView
                    headerView.titleLabel.text = ds.sectionModels[ip.section].header
                    if ds.sectionModels[ip.section].header == "" {
                        headerView.willMove(toSuperview: cv)
                    }
                    return headerView
                }
                return UICollectionReusableView()
            })
            sink.itemsSource
                .drive(self.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
            self.collectionView.rx.modelSelected(NotificationModel.self)
                .asObservable()
                .subscribe(onNext: {[weak self] (model) in
                    if let detailNotificationVC = R.storyboard.notification.detailNotificationViewController() {
                        self!.navigationController?.pushViewController(detailNotificationVC, animated: true)
                        detailNotificationVC.fullContent = model.getFullContent()
                        detailNotificationVC.titleContent = model.getTitle()
                    }
                }).disposed(by: disposeBag)
            
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
