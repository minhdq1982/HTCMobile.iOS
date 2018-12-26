//
//  DetailCarFeatureHeaderView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol DetailCarFeatureHeaderViewDelegate {
    func didSelectFeature(feature: CategoryModel)
}

class DetailCarFeatureHeaderView: UITableViewHeaderFooterView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var delegate: DetailCarFeatureHeaderViewDelegate?
    let currentIndex: Variable<Int> = Variable(0)
    
    let disposeBag = DisposeBag()
    let features: Variable<[CategoryModel]> = Variable([CategoryModel(id: 0, name: "Nổi bật"),
                                                        CategoryModel(id: 1, name: "Ngoại thất"),
                                                        CategoryModel(id: 2, name: "Nội thất"),
                                                        CategoryModel(id: 3, name: "Vận hành"),
                                                        CategoryModel(id: 4, name: "An toàn"),
                                                        CategoryModel(id: 5, name: "Tiện nghi"),
                                                        CategoryModel(id: 6, name: "Động cơ")])
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        //  Header layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 120, height: 50)
        self.collectionView.collectionViewLayout = layout
        
        features.asDriver()
            .drive(self.collectionView.rx.itemsSource())
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (ip) in
                self?.setSelectedFeature(ip)
            }).disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.setSelectedFeature(IndexPath(row: self.currentIndex.value, section: 0))
        }
    }
    
    func setSelectedFeature(_ indexPath: IndexPath) {
        self.delegate?.didSelectFeature(feature: features.value[indexPath.row])
        
        for i in 0...(features.value.count - 1) {
            if let cell = self.collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? CategoryCollectionViewCell {
                if i == indexPath.row {
                    cell.setSelected(true)
                    currentIndex.value = indexPath.row
                }else{
                    cell.setSelected(false)
                }
            }
        }
    }
}
