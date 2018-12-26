//
//  CarsViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import RxDataSources

class CarsViewController: BaseViewController {
    
    @IBOutlet weak var registerDriveCarLabel: UILabel!
    @IBOutlet weak var chooseCarLabel: UILabel!
    @IBOutlet weak var priceConsultantLabel: UILabel!
    @IBOutlet weak var installmentConsultantLabel: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func setupView() {
        super.setupView()
        self.collectionView.register(CarCollectionViewCell.nib, forCellWithReuseIdentifier: CarCollectionViewCell.identifier)
//        self.collectionView.register(R.nib.carHeaderCollectionView(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CarHeaderCollectionView")
        self.collectionView.register(R.nib.carFooterCollectionView(), forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "CarFooterCollectionView")
        
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        
        collectionLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 72 )/2, height: 130)
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.footerReferenceSize = CGSize(width: UIScreen.main.bounds.size.width, height: 75)
        collectionLayout.sectionInset = UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
        self.collectionView.collectionViewLayout = collectionLayout
        
        viewModel = CarsViewModel(service: HTCService())
        let source = CarsViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ())
        )
        let sink = (viewModel as! CarsViewModel).transform(source: source)
        self.bindData(sink)
        
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle(tr(L10n.carsTitle))
        searchTextField.attributedPlaceholder = NSAttributedString.init(string: "Bạn muốn tìm loại xe nào?", attributes:[NSAttributedString.Key.foregroundColor: UIColor(red: 1, green: 1, blue: 1, alpha: 0.6)])
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? CarsViewModel.Sink {
            let dataSource = RxCollectionViewSectionedReloadDataSource<Section>(configureCell: {(ds, cv, ip, item) -> UICollectionViewCell in
                let cell = cv.dequeueReusableCell(withReuseIdentifier: item.identifier, for: ip) as! BaseCollectionViewCell
                cell.setDataContext(indexPath: ip, data: item)
                return cell
                
                }, configureSupplementaryView: {[weak self] (ds, cv, kind, ip) -> UICollectionReusableView in
                    guard let s = self else {return UICollectionReusableView()}
                    
                    if kind == UICollectionView.elementKindSectionFooter {
                        let footerView = cv.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CarFooterCollectionView", for: ip) as! CarFooterCollectionView
                        footerView.allButton.rx.tap
                            .asObservable()
                            .subscribe(onNext: {[weak self] _ in
                                if let chooseCarVC = R.storyboard.cars.chooseCarViewController() {
                                    self?.navigationController?.pushViewController(chooseCarVC, animated: true)
                                }
                            }).disposed(by: s.disposeBag)
                        
                        return footerView
                    }
                    
                    return UICollectionReusableView()
            })
            sink.itemsSource
                .drive(self.collectionView.rx.items(dataSource: dataSource))
                .disposed(by: disposeBag)
            
            self.collectionView.rx.modelSelected(CarModel.self)
                .asObservable()
                .subscribe(onNext: {[weak self] (carModel) in
                    self?.moveToDetailCar(carModel)
                }).disposed(by: disposeBag)
        }
    }
    
    //  MARK: - Actions
    @IBAction func tapRegisterDriveCar(_ sender: Any) {
        if let registerVC = R.storyboard.cars.registerDriveCarViewController() {
            self.navigationController?.pushViewController(registerVC, animated: true)
        }
    }
    
    @IBAction func tapChooseCar(_ sender: Any) {
        if let chooseCarVC = R.storyboard.cars.chooseCarViewController() {
            self.navigationController?.pushViewController(chooseCarVC, animated: true)
        }
    }
    
    @IBAction func tapPriceConsulting(_ sender: Any) {
        if let priceConsultingVC = R.storyboard.cars.priceConsultingViewController() {
            self.navigationController?.pushViewController(priceConsultingVC, animated: true)
        }
    }
    
    @IBAction func tapConsultantInstallment(_ sender: Any) {
        if let installmentVC = R.storyboard.cars.consultantInstallmentViewController() {
            self.navigationController?.pushViewController(installmentVC, animated: true)
        }
    }
    
    func moveToDetailCar(_ car: CarModel) {
        if let detailCarVC = R.storyboard.cars.detailCarViewController() {
            detailCarVC.carModel = car
            self.navigationController?.pushViewController(detailCarVC, animated: true)
        }
    }
}
