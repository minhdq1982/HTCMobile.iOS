//
//  CardPagerViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView

protocol CardPagerViewCellDelegate {
    func didTapUseCard(_ card: CardModel?)
    func didTapCardInfo(_ card: CardModel?)
}

class CardPagerViewCell: BaseFSPagerViewCell {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var useCardButton: UIButton!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var cardAddressLabel: UILabel!
    @IBOutlet weak var carModelNameLabel: UILabel!
    
    var cardModel: CardModel?
    var delegate: CardPagerViewCellDelegate?
    
    override public func setDataContext(index: Int, data: Any) {
        super.setDataContext(index: index, data: data)
        
        if let cardInfo = data as? CardModel
        {
            cardModel = cardInfo
            usernameLabel.text = cardInfo.getCustomerName().uppercased()
            cardNumberLabel.text = cardInfo.getCardNo()
            cardAddressLabel.text = cardInfo.getAgencyNameDisplay().uppercased()
            
            //  Localization
            useCardButton.setTitle(tr(L10n.homeTextUseCard), for: .normal)
            
            if cardInfo.getRank() == CardType.gold.rawValue {
                cardImageView.image = R.image.img_membership_gold()
                useCardButton.setBackgroundImage(R.image.use_card_gold(), for: .normal)
                usernameLabel.textColor = Colours.black
                cardNumberLabel.textColor = Colours.black
                cardAddressLabel.textColor = Colours.black
                carModelNameLabel.textColor = Colours.black
            }else if cardInfo.getRank() == CardType.silver.rawValue {
                cardImageView.image = R.image.img_membership_silver()
                useCardButton.setBackgroundImage(R.image.use_card_silver(), for: .normal)
                usernameLabel.textColor = Colours.black
                cardNumberLabel.textColor = Colours.black
                cardAddressLabel.textColor = Colours.black
                carModelNameLabel.textColor = Colours.black
            }else if cardInfo.getRank() == CardType.platinum.rawValue {
                cardImageView.image = R.image.img_membership_platinum()
                useCardButton.setBackgroundImage(R.image.use_card_platinum(), for: .normal)
                usernameLabel.textColor = Colours.white
                cardNumberLabel.textColor = Colours.platiumText
                cardAddressLabel.textColor = Colours.white
                carModelNameLabel.textColor = Colours.white
            }
        }
        
    }
    
    //  MARK: - Actions
    @IBAction func tapUseCardAction(_ sender: Any) {
        delegate?.didTapUseCard(self.cardModel)
    }
    
    @IBAction func tapCardAction(_ sender: Any) {
        delegate?.didTapCardInfo(self.cardModel)
    }
}
