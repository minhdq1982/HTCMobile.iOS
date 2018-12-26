//
//  HeadDetailCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/21/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import UIKit
import RxSwift
import RxCocoa
import FSPagerView

protocol HeadDetailCellDelagate {
    func gotoHistoryVC()
    func deleteCard(_ vinno: String)
    func sendSelectedItem(_ index: Int)
    func useCard(card: CardModel)
}

class HeadDetailCell: BaseTableViewCell {
    
    // MARK: - Outlet and Variable
    @IBOutlet weak var deleteCardButton: UIButton!
    @IBOutlet weak var historyButton: UIButton!
    var delegate: HeadDetailCellDelagate?
    var headDetailModel: HeadDetailModel?
    
    var firstTimeShowPager: Int = 0
    public let disposeBag = DisposeBag()
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.register(CardPagerViewCell.nib, forCellWithReuseIdentifier:CardPagerViewCell.identifier)
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            self.fsPagerView.transformer = FSPagerViewTransformer(type: .linear)
        }
    }

    
    
    // MARK: - lifecycle
    override func awakeFromNib() {
        super .awakeFromNib()
        self.selectionStyle = .none
        self.setNeedsLayout()
        self.layoutIfNeeded()
      
        historyButton.layer.borderWidth = 1.0
        historyButton.layer.borderColor = Colours.white.cgColor
        deleteCardButton.layer.borderWidth = 1.0
        deleteCardButton.layer.borderColor = Colours.white.cgColor
      
      
        
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.fsPagerView.interitemSpacing = 1
        self.fsPagerView.itemSize = self.fsPagerView.frame.size.applying(CGAffineTransform(scaleX: 0.85, y: 1))  //CGSize.init(width: UIScreen.main.bounds.size.width - 48, height: 210)
        
        self.fsPagerView.clipsToBounds = true
    }
    
    //  MARK: - Init group cards
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super.setDataContext(indexPath: indexPath, data: data)
        if let model = data as? HeadDetailModel {
            self.setData(model)
        }
        
    }
    
    func setData(_ model: HeadDetailModel)  {
        headDetailModel = model
        self.fsPagerView.dataSource = self
        self.fsPagerView.delegate = self
        
        self.fsPagerView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            print("select pager")
            self.fsPagerView.scrollToItem(at: self.firstTimeShowPager, animated: false)
        }
    }
    
    
    // MARK: - Action
    @IBAction func gotoHisroryVC(_ sender: Any) {
        delegate?.gotoHistoryVC()
    }
    
    @IBAction func onDeleteCar(_ sender: Any) {
       
        if let vinno = headDetailModel?.cards[firstTimeShowPager].getVINNO() {
             print(index)
             delegate?.deleteCard(vinno)
        }
       
    }
}
// MARK: - extension
extension HeadDetailCell: FSPagerViewDataSource, FSPagerViewDelegate, CardPagerViewCellDelegate {
    func didTapUseCard(_ card: CardModel?) {
        if let  aCard = card {
            print("card pager use card")
            delegate?.useCard(card: aCard)
        }
    }
    
    func didTapCardInfo(_ card: CardModel?) {
        // do something
    }
    
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let cards = headDetailModel?.cards {
            return cards.count
        }
        return 0
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CardPagerViewCell", at: index)
        guard let aCell = cell as? CardPagerViewCell else {
            return FSPagerViewCell()
        }
        aCell.setDataContext(index: index, data: headDetailModel?.cards[index] as Any)
        aCell.delegate = self
        return cell
    }
    func pagerView(_ pagerView: FSPagerView, didHighlightItemAt index: Int) {
        print(pagerView.currentIndex)
    }
   
//
//    // MARK:- FSPagerView Delegate
//
    public func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        delegate?.sendSelectedItem(index)

    }
    func pagerViewDidEndDecelerating(_ pagerView: FSPagerView) {
         print(pagerView.currentIndex)
         delegate?.sendSelectedItem(pagerView.currentIndex)
    }

}

