//
//  ScrollPromotionCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/26/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol ScrollPromotionCellDelegate {
    func viewNews(_ news: NewsModel)
}

class ScrollPromotionCell: BaseTableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var groupNewsModel: GroupNewsModel?
    var delegate: ScrollPromotionCellDelegate?
    let itemSize = CGSize(width: 280, height: 200)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        collectionView.register(PromotionCollectionViewCell.nib, forCellWithReuseIdentifier: PromotionCollectionViewCell.identifier)
        
        let collectionLayout = UICollectionViewFlowLayout()
        collectionLayout.scrollDirection = .horizontal
        collectionLayout.itemSize = itemSize
        collectionLayout.minimumInteritemSpacing = 8
        collectionLayout.minimumLineSpacing = 0
        collectionLayout.headerReferenceSize = CGSize.zero
        collectionLayout.sectionInset = UIEdgeInsets.zero
        self.collectionView.collectionViewLayout = collectionLayout
        
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let pros = data as? GroupNewsModel {
            self.setData(pros)
        }
    }
    
    func setData(_ model:GroupNewsModel)  {
        groupNewsModel = model
        if let news = groupNewsModel?.items, news.count > 0 {
            self.collectionView.reloadData()
        }
    }
}

extension ScrollPromotionCell: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 280, height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let news = groupNewsModel?.items {
            return news.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PromotionCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PromotionCollectionViewCell.identifier, for: indexPath) as! PromotionCollectionViewCell
        cell.indexPath = indexPath
        if let items = groupNewsModel?.items, indexPath.row < items.count {
            cell.setDataContext(indexPath: indexPath, data: items[indexPath.row])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if let items = groupNewsModel?.items, indexPath.row < items.count {
            delegate?.viewNews(items[indexPath.row])
        }
    }
}

extension ScrollPromotionCell: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.checkCurrentIndex()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.checkCurrentIndex()
        }
    }
    
    func checkCurrentIndex() {
        let contentOfsset = self.collectionView.contentOffset
        if contentOfsset.x >= self.collectionView.contentSize.width - UIScreen.main.bounds.size.width {
            //  Do nothing
        }else {
            let pageWidth = itemSize.width + 24
            let index = Int((contentOfsset.x + pageWidth / 2) / pageWidth)
            print("Offset: \(contentOfsset.x) Index: \(index)")
            if index < self.collectionView.numberOfItems(inSection: 0) - 1  {
                self.focusItemAtIndex(index: IndexPath(row: index, section: 0))
            }
        }
    }
    
    func focusItemAtIndex(index: IndexPath) {
        self.collectionView.setContentOffset(CGPoint(x: CGFloat(index.row) * itemSize.width, y: 0), animated: true)
    }
}
