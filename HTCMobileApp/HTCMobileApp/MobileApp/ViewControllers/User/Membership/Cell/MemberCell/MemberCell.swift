//
//  MemberCell.swift
//  HTCMobileApp
//
//  Created by admin on 10/31/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

protocol MemberCellDelegate: class {
    func useCard(row: Int?)
}

class MemberCell: BaseTableViewCell {
    @IBOutlet weak var cardNumberLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var licensePlateLabel: UILabel!
    @IBOutlet weak var cardAddressLabel: UILabel!
    @IBOutlet weak var useCardButton: UIButton!
    @IBOutlet weak var cardImageView: UIImageView!
    weak var delegate: MemberCellDelegate?
    var row: Int?
    @IBOutlet weak var cardBgImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        // Initialization code
    }
    func customInit(_ cardNo: String, _ username: String, _ rank: String, _ licensePlate: String, _ brand: String) {
        self.setNeedsLayout()
        self.layoutIfNeeded()
        useCardButton.roundCorners(corners: .bottomLeft, radius: 4.0)
        useCardButton.roundCorners(corners: .bottomRight, radius: 4.0)
    
       
        self.cardNumberLabel.text = cardNo
        self.usernameLabel.text = username
        self.licensePlateLabel.text = "SANTA FE | " + licensePlate
        self.cardAddressLabel.text = brand
        
        if rank == CardType.gold.rawValue {
            // setup background
            useCardButton.setTitleColor(Colours.goldText, for: .normal)
            useCardButton.setBackgroundImage(R.image.use_card_gold(), for: .normal)
            cardAddressLabel.textColor = Colours.black
            cardNumberLabel.textColor = Colours.black
            licensePlateLabel.textColor = Colours.black
            usernameLabel.textColor = Colours.black
            cardBgImageView.image = R.image.img_membership_gold()
            
        } else if rank == CardType.silver.rawValue {
            // setup background
            useCardButton.setTitleColor(Colours.silverText, for: .normal)
            useCardButton.setBackgroundImage(R.image.use_card_silver(), for: .normal)
            cardAddressLabel.textColor = Colours.black
            cardNumberLabel.textColor = Colours.black
            licensePlateLabel.textColor = Colours.black
            usernameLabel.textColor = Colours.black
            cardBgImageView.image =  R.image.img_membership_silver()
        } else if rank == CardType.platinum.rawValue {
            // setup background
            useCardButton.setTitleColor(Colours.useCardPlatinumText, for: .normal)
            useCardButton.setBackgroundImage(R.image.use_card_platinum(), for: .normal)
            cardAddressLabel.textColor = Colours.white
            cardNumberLabel.textColor = Colours.platiumText
            licensePlateLabel.textColor = Colours.white
            usernameLabel.textColor = Colours.white
            cardBgImageView.image = R.image.img_membership_platinum()

        } else {
            //
        }
    }

    @IBAction func onUseCard(_ sender: Any) {
        delegate?.useCard(row: self.row)
    }
    
}
