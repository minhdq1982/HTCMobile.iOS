//
//  CompareCarsHeaderCollectionView.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/15/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol CompareCarsHeaderCollectionViewDelegate {
    func didSelectFeature(feature: CategoryModel)
}

class CompareCarsHeaderCollectionView: UICollectionReusableView {
    @IBOutlet weak var car1ImageView: UIImageView!
    @IBOutlet weak var car1NameLabel: UILabel!
    @IBOutlet weak var car2ImageView: UIImageView!
    @IBOutlet weak var car2NameLabel: UILabel!
    @IBOutlet weak var car2InfoButton: UIButton!
    @IBOutlet weak var changeCarButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var car1: CarModel?
    var car2: CarModel?
    var delegate: CompareCarsHeaderCollectionViewDelegate?
    
    let disposeBag = DisposeBag()
    let features = [CategoryModel(id: 0, name: "Kích thước"),
                    CategoryModel(id: 1, name: "Đặc tính vận hành"),
                    CategoryModel(id: 2, name: "Khối lượng"),
                    CategoryModel(id: 3, name: "Động cơ"),
                    CategoryModel(id: 4, name: "Hệ thống truyền động")]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        //  Header layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        
        Driver.just(features)
            .drive(self.collectionView.rx.itemsSource())
            .disposed(by: disposeBag)
        
        self.collectionView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] (ip) in
                self?.setSelectedFeature(ip)
            }).disposed(by: disposeBag)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            self.setSelectedFeature(IndexPath(row: 0, section: 0))
        }
    }
    
    func updateUI(car1: CarModel, car2: CarModel) {
        
    }
    
    func setSelectedFeature(_ indexPath: IndexPath) {
        
        self.delegate?.didSelectFeature(feature: features[indexPath.row])
        
        for i in 0...(features.count - 1) {
            if let cell = self.collectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? CategoryCollectionViewCell {
                if i == indexPath.row {
                    cell.setSelected(true)
                }else{
                    cell.setSelected(false)
                }
            }
        }
    }
    
}

extension CompareCarsHeaderCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 120
        switch indexPath.row {
        case 1:
            width = 165
        case 4:
            width = 180
        default:
            break
        }
        return CGSize(width: width, height: 50)
    }
}
