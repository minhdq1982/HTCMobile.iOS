//
//  GroupCardCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import FSPagerView

protocol GroupCardCellDelegate {
    func addCard()
    func useCard(card: CardModel)
    func viewProfitCards(cards: [CardModel])    //  merge content from cards's info
    func viewCardInfo(card: CardModel)
    func loginAction()
}


class GroupCardCell: BaseTableViewCell {
    @IBOutlet weak var fsPagerView: FSPagerView! {
        didSet {
            self.fsPagerView.register(CardPagerViewCell.nib, forCellWithReuseIdentifier:CardPagerViewCell.identifier)
            self.fsPagerView.automaticSlidingInterval = 0
            self.fsPagerView.isInfinite = false
            self.fsPagerView.transformer = FSPagerViewTransformer(type: .linear)
        }
    }
    
    @IBOutlet weak var addCardLabel: UILabel!
    @IBOutlet weak var interestLabel: UILabel!
    @IBOutlet weak var cardInfoLabel: UILabel!
    
    @IBOutlet weak var loggedInView: UIView!
    @IBOutlet weak var pagerViewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var bgHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var bgTopContraint: NSLayoutConstraint!
    
    var delegate: GroupCardCellDelegate?
    var groupModel: GroupCardModel?
    var selectedIndex: Int = 0
    
    public let disposeBag = DisposeBag()
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.fsPagerView.itemSize = self.fsPagerView.frame.size.applying(CGAffineTransform(scaleX: 0.85, y: 0.95))
        self.fsPagerView.interitemSpacing = 8
        self.fsPagerView.clipsToBounds = true
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? GroupCardModel {
            self.setData(model)
            
            bgTopContraint.constant = UIApplication.shared.statusBarFrame.height + 50
            bgHeightContraint.constant = UIScreen.main.bounds.size.height - UIApplication.shared.statusBarFrame.height - 50
            self.setNeedsLayout()
            self.layoutIfNeeded()
        }
    }
    
    //  MARK: - Init group cards
    func setData(_ model:GroupCardModel)  {
        groupModel = model
//        if let cards = groupModel?.cards {
//            self.fsPagerView.isInfinite = cards.count > 1
//        }
        self.fsPagerView.dataSource = self
        self.fsPagerView.delegate = self
        self.fsPagerView.reloadData()
        
        //  Localization
        addCardLabel.text = tr(L10n.homeTextAddCard)
        interestLabel.text = tr(L10n.homeTextInterest)
        cardInfoLabel.text = tr(L10n.homeTextCardInfo)
    }
    
    //  MARK: - Actions
    @IBAction func tapAddAction(_ sender: Any) {
        delegate?.addCard()
    }
    
    @IBAction func tapProfitAction(_ sender: Any) {
        if let cards = groupModel?.cards {
            delegate?.viewProfitCards(cards: cards)
        }
    }
    
    @IBAction func tapInfoAction(_ sender: Any) {
        if let aCard = currentCard() {
            delegate?.viewCardInfo(card: aCard)
        }
    }
    
    func currentCard() -> CardModel? {
        return groupModel?.cards[selectedIndex]
    }
}

extension GroupCardCell: CardPagerViewCellDelegate {
    func didTapUseCard(_ card: CardModel?) {
        if let aCard = card {
            delegate?.useCard(card: aCard)
        }
    }
    func didTapCardInfo(_ card: CardModel?){
        if let aCard = card {
            delegate?.viewCardInfo(card: aCard)
        }
    }
}

extension GroupCardCell: FSPagerViewDataSource, FSPagerViewDelegate{
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        if let cards = groupModel?.cards {
            return cards.count
        }
        return 0
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "CardPagerViewCell", at: index)
        guard let aCell = cell as? CardPagerViewCell else {return FSPagerViewCell()}
        aCell.setDataContext(index: index, data: groupModel?.cards[index] as Any)
        aCell.delegate = self
        return cell
    }
    
    // MARK:- FSPagerView Delegate
    
    public func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        pagerView.scrollToItem(at: index, animated: true)
        selectedIndex = index
    }
}
