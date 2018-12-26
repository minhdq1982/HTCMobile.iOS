//
//  ChooseCarViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ChooseCarViewController: BaseViewController {
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    @IBOutlet weak var carsCollectionView: UICollectionView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var searchButton: CustomButton!
    
    @IBOutlet weak var priceTitleLabel: UILabel!
    @IBOutlet weak var capacityTittleLabel: UILabel!
    @IBOutlet weak var gearTitleLabel: UILabel!
    @IBOutlet weak var price1Button: ChooseButton!
    @IBOutlet weak var price2Button: ChooseButton!
    @IBOutlet weak var capacity1Button: ChooseButton!
    @IBOutlet weak var capacity2Button: ChooseButton!
    @IBOutlet weak var gear1Button: ChooseButton!
    @IBOutlet weak var gear2Button: ChooseButton!
    @IBOutlet weak var gear3Button: ChooseButton!
    
    let priceOption: Variable<Int> = Variable(0)
    let capacityOption: Variable<Int> = Variable(0)
    let gearOption: Variable<Int> = Variable(0)
    
    let categoryIndex: Variable<Int> = Variable(0)
    var categoryCount: Int = 0
    var isSearching: Bool = false
    
    
    override func setupView() {
        super.setupView()
        
        self.categoriesCollectionView.register(CategoryCollectionViewCell.nib, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        self.carsCollectionView.register(CarCollectionViewCell.nib, forCellWithReuseIdentifier: CarCollectionViewCell.identifier)
        
        //  Filter color
        filterView.backgroundColor = UIColor(red: 111.0/255, green: 113.0/255, blue: 121.0/255, alpha: 0.5)
        
        //  Header layout
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.categoriesCollectionView.collectionViewLayout = layout
        self.categoriesCollectionView.delegate = self
        
        //  Cars layout
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .vertical
        collectionLayout.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 72 )/2, height: 110)
        collectionLayout.minimumInteritemSpacing = 10
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.headerReferenceSize = CGSize.zero
        collectionLayout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 10, right: 16)
        self.carsCollectionView.collectionViewLayout = collectionLayout
        
        //  Set default filter option
        choosePriceAction(price1Button)
        chooseCapacityAction(capacity1Button)
        chooseGearAction(gear1Button)
        
        viewModel = ChooseCarViewModel(service: HTCService())
        let source = ChooseCarViewModel.Source(
            viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()),
            categoryIndex: categoryIndex.asDriver(),
            priceOption: priceOption.asDriver(),
            capacityOption: capacityOption.asDriver(),
            gearOption: gearOption.asDriver(),
            searchAction: self.searchButton.rx.tap.asDriver())
        
        let sink = (viewModel as! ChooseCarViewModel).transform(source: source)
        self.bindData(sink)
    }
    
    override func localizable() {
        super.localizable()
        self.setHeaderTitle("Chọn xe Hyundai")
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? ChooseCarViewModel.Sink {
            sink.categoriesSource
                .drive(self.categoriesCollectionView.rx.itemsSource())
                .disposed(by: disposeBag)
            sink.categoriesSource
                .asObservable()
                .subscribe(onNext: {[weak self] (categories) in
                    self?.categoryCount = categories.count
                }).disposed(by: disposeBag)
            
            sink.itemsSource
                .drive(self.carsCollectionView.rx.itemsSource())
                .disposed(by: disposeBag)
            
            categoriesCollectionView.rx.itemSelected
                .asObservable()
                .subscribe(onNext: {[weak self] (indexPath) in
                    self?.categoryIndex.value = indexPath.row
                    self?.setSelectedCategoryAtIndex(indexPath)
                }).disposed(by: disposeBag)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.setSelectedCategoryAtIndex(IndexPath(row: 0, section: 0))
            }
            
            filterButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    guard let s = self else {return}
                    if s.isSearching {
                        self?.doShowSearchAnimation(false)
                    }else{
                        self?.doShowSearchAnimation(true)
                    }
                }).disposed(by: disposeBag)
            searchButton.rx.tap
                .asObservable()
                .subscribe(onNext: {[weak self] _ in
                    self?.doShowSearchAnimation(false)
                }).disposed(by: disposeBag)
        }
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setSelectedCategoryAtIndex(_ indexPath: IndexPath) {
        for i in 0...(categoryCount - 1) {
            if let cell = self.categoriesCollectionView.cellForItem(at: IndexPath(row: i, section: 0)) as? CategoryCollectionViewCell {
                if i == indexPath.row {
                    cell.setSelected(true)
                }else{
                    cell.setSelected(false)
                }
            }
        }
    }
    
    func doShowSearchAnimation(_ isShow: Bool)  {
        if isShow {
            filterButton.setImage(R.image.icon_close(), for: .normal)
            filterView.isHidden = false
            filterView.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                self.filterView.alpha = 1
            }) { _ in
                self.showSearch(true)
            }
        }else{
            filterButton.setImage(R.image.icon_filter(), for: .normal)
            filterView.alpha = 1
            UIView.animate(withDuration: 0.5, animations: {
                self.filterView.alpha = 0
            }) { _ in
                self.showSearch(false)
            }
        }
    }
    
    func showSearch(_ isShow: Bool) {
        if isShow {
            isSearching = true
            filterView.isHidden = false
            filterButton.setImage(R.image.icon_close(), for: .normal)
        }else{
            isSearching = false
            filterView.isHidden = true
            filterButton.setImage(R.image.icon_filter(), for: .normal)
        }
    }
    
    @IBAction func choosePriceAction(_ sender: ChooseButton) {
        switch sender.tag {
        case 1:
            price1Button.setSelected(false)
            price2Button.setSelected(true)
            priceOption.value = 1
        default:
            price1Button.setSelected(true)
            price2Button.setSelected(false)
            priceOption.value = 0
        }
    }
    
    @IBAction func chooseCapacityAction(_ sender: ChooseButton) {
        switch sender.tag {
        case 1:
            capacity1Button.setSelected(false)
            capacity2Button.setSelected(true)
            capacityOption.value = 1
        default:
            capacity1Button.setSelected(true)
            capacity2Button.setSelected(false)
            capacityOption.value = 0
        }
    }
    
    @IBAction func chooseGearAction(_ sender: ChooseButton) {
        
        switch sender.tag {
        case 1:
            gear1Button.setSelected(false)
            gear2Button.setSelected(true)
            gear3Button.setSelected(false)
            gearOption.value = 1
        case 2:
            gear1Button.setSelected(false)
            gear2Button.setSelected(false)
            gear3Button.setSelected(true)
            gearOption.value = 2
        default:
            gear1Button.setSelected(true)
            gear2Button.setSelected(false)
            gear3Button.setSelected(false)
            gearOption.value = 0
        }
    }
    
    
}

extension ChooseCarViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var width: CGFloat = 120
        switch indexPath.row {
        case 0:
            width = 100
        case 1, 3:
            width = 120
        case 2:
            width = 140
        default:
            break
        }
        return CGSize(width: width, height: 50)
    }
}
