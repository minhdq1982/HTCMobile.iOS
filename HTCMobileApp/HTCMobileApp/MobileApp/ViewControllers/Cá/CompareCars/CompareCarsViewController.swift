//
//  CompareCarsViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/8/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CompareCarsViewController: BaseViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let car1: Variable<CarModel> = Variable(CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "", shortDescription: "", image: [""], price: 500000000, unit: "VND"))
    let car2: Variable<CarModel> = Variable(CarModel(id: 1, categoryId: 1, name: "GRAND i10 SEDAN", slogan: "", shortDescription: "", image: [""], price: 500000000, unit: "VND"))
    let segmentIndex: Variable<Int> = Variable(0)
    var lastSectionIndex: Int = 0
    
    override func setupView() {
        super.setupView()
        
        self.collectionView.register(MetricsCompareCollectionViewCell.nib, forCellWithReuseIdentifier: MetricsCompareCollectionViewCell.identifier)
        self.collectionView.register(R.nib.metricHeaderCollectionView(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "MetricHeaderCollectionView")
        self.collectionView.register(R.nib.compareCarsHeaderCollectionView(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CompareCarsHeaderCollectionView")
        self.collectionView.delegate = self
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = collectionLayout
        
        viewModel = CompareCarsViewModel(service: HTCService())
        let source = CompareCarsViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            car1: car1.asDriver(),
            car2: car2.asDriver(),
            segmentIndex: segmentIndex.asDriver())

        let sink = (viewModel as! CompareCarsViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("So sánh")
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? CompareCarsViewModel.Sink {
            
            sink.itemsSource
                .asObservable()
                .subscribe(onNext: {[weak self] (sections) in
                    self?.lastSectionIndex = sections.count - 1
                }).disposed(by: disposeBag)
            
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(configureCell: {[weak self] (ds, cv, ip, item) -> UICollectionViewCell in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: item.identifier, for: ip) as! MetricsCompareCollectionViewCell
                cell.setDataContext(indexPath: ip, data: item)
                
                cell.bottomLineView.isHidden = !(ip.section == self?.lastSectionIndex)
                
                return cell
                
            }, configureSupplementaryView: {[weak self] (ds, cv, kind, ip) -> UICollectionReusableView in
                guard let s = self else {return UICollectionReusableView()}
                
                if kind == UICollectionView.elementKindSectionHeader {
                    if ip.section == 0 {
                        let headerView = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CompareCarsHeaderCollectionView", for: ip) as! CompareCarsHeaderCollectionView
                        headerView.delegate = self
                        headerView.updateUI(car1: s.car1.value, car2: s.car2.value)
                        return headerView
                    }else{
                        let headerView = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "MetricHeaderCollectionView", for: ip) as! MetricHeaderCollectionView
                        headerView.titleLabel.text = ds.sectionModels[ip.section].header
                        return headerView
                    }
                    
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

extension CompareCarsViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 44)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case 0:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 248)
        default:
            return CGSize(width: UIScreen.main.bounds.size.width, height: 44)
        }
    }
}

extension CompareCarsViewController: CompareCarsHeaderCollectionViewDelegate {
    func didSelectFeature(feature: CategoryModel) {
        self.segmentIndex.value = feature.id ?? 0
    }
}
