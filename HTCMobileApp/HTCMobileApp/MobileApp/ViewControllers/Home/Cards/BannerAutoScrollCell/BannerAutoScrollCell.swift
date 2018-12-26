//
//  BannerAutoScrollCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/12/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

protocol BannerAutoScrollCellDelegate {
    func didSelectBanner(_ banner: BannerModel)
}

class BannerAutoScrollCell: BaseTableViewCell {
    
    @IBOutlet weak var fsPagerView: FSPagerView!{
        didSet {
            self.fsPagerView.register(BannerPagerViewCell.nib, forCellWithReuseIdentifier:BannerPagerViewCell.identifier)
            self.fsPagerView.automaticSlidingInterval = 5
            self.fsPagerView.isInfinite = true
        }
    }
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var heightContraint: NSLayoutConstraint!
    var delegate: BannerAutoScrollCellDelegate?
    
    var homeBannerModel: HomeBannerModel?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? HomeBannerModel {
            homeBannerModel = model
            pageControl.numberOfPages = model.banners.count
            self.fsPagerView.reloadData()
            let width = UIScreen.main.bounds.size.width - 24
            let height = width * 711 / 1053
            self.heightContraint.constant = height
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.fsPagerView.interitemSpacing = 0
        let width = UIScreen.main.bounds.size.width - 24
        let height = width * 711 / 1053
        self.fsPagerView.itemSize = CGSize(width: width, height: height) //self.fsPagerView.frame.size
        self.fsPagerView.clipsToBounds = true
        self.fsPagerView.dataSource = self
        self.fsPagerView.delegate = self
    }
}


extension BannerAutoScrollCell: FSPagerViewDataSource, FSPagerViewDelegate{
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let bns = homeBannerModel?.banners {
            return bns.count
        }
        return 0
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "BannerPagerViewCell", at: index)
        guard let aCell = cell as? BannerPagerViewCell else {return FSPagerViewCell()}
        if let bns = homeBannerModel?.banners {
            aCell.setDataContext(index: index, data: bns[index] as Any)
        }
        aCell.delegate = self
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    func pagerView(_ pagerView: FSPagerView, willDisplay cell: FSPagerViewCell, forItemAt index: Int){
        pageControl.currentPage = index
        print("Index: \(index)")
    }
}

extension BannerAutoScrollCell: BannerPagerViewCellDelegate {
    func didSelectBanner(_ banner: BannerModel?) {
        if let bn = banner {
            delegate?.didSelectBanner(bn)
        }
    }
}
