//
//  UseCardAlertViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/8/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import EFQRCode
import Barcode128View

class UseCardAlertViewController: UIViewController {
    
    @IBOutlet weak var barCodeView: Barcode128View!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var cardAddressLabel: UILabel!
    @IBOutlet weak var doneButon: UIButton!
    @IBOutlet weak var cardNoLabel: UILabel!
    @IBOutlet weak var alertView: UIView!
    var cardNo: String?
    var qrCGImage: CGImage?
    var brand: String?
    var rank: String?
    
    var qrImage: UIImage?
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        setup()
        animateView()
        
        if let cardNo = cardNo {
            self.barCodeView.code128String = cardNo
        }
        
        self.barCodeView.showCode = false

        self.barCodeView.font = UIFont.systemFont(ofSize: 20)
        self.barCodeView.barColor = UIColor.black
        self.barCodeView.padding = 0
    }
    
    @IBAction func onClose(_ sender: Any) {        
        self.dismiss(animated: true, completion: nil)
    }
    
    func setup() {
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        doneButon.roundCorners(corners: .bottomLeft, radius: 4.0)
        doneButon.roundCorners(corners: .bottomRight, radius: 4.0)
        doneButon.setTitle("Ẩn thẻ", for: .normal)
        
        guard let rank = rank,
            let brand = brand else {
                return
        }
        cardAddressLabel.text = brand.uppercased()
        cardNoLabel.text = cardNo
        cardNoLabel.textColor = Colours.textColor
        
        if rank == CardType.gold.rawValue {
            // setup background
            doneButon.setTitleColor(Colours.goldText, for: .normal)
            doneButon.setBackgroundImage(R.image.use_card_gold_new(), for: .normal)
            cardAddressLabel.textColor = Colours.black
            bgImageView.image = R.image.use_card_bg_gold()
        } else if rank == CardType.silver.rawValue {
            // setup background
            doneButon.setTitleColor(Colours.silverText, for: .normal)
            doneButon.setBackgroundImage(R.image.use_card_silver_new(), for: .normal)
            cardAddressLabel.textColor = Colours.black
            bgImageView.image = R.image.use_card_bg_silver()
        } else if rank == CardType.platinum.rawValue {
            // setup background
            doneButon.setTitleColor(Colours.goldText, for: .normal)
            doneButon.setBackgroundImage(R.image.use_card_platinum_new(), for: .normal)
            cardAddressLabel.textColor = Colours.white
            bgImageView.image = R.image.use_card_bg_platinum()
        }
    }
    
    func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
}
