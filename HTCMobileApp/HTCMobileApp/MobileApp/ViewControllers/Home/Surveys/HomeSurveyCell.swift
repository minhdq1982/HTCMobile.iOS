//
//  SurveyCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/29/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import Lottie

class HomeSurveyCell: BaseTableViewCell {
    
    @IBOutlet weak var bgView: RoundedView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var makeSurveyButton: UIButton!
    @IBOutlet weak var giftView: UIView!
    var animationView: LOTAnimationView?
    
    @IBOutlet weak var giftBottomContraintLayout: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let bounds = self.giftView.bounds
        if animationView == nil {
            animationView = LOTAnimationView(name: "happy_gift", bundle: Bundle.main)
            animationView?.frame = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
            animationView?.contentMode = .scaleAspectFill
            animationView?.loopAnimation = true
            self.giftView.addSubview(animationView!)
            animationView!.play()
        }
        
        animationView?.bounds = CGRect(x: 0, y: 0, width: bounds.size.width, height: bounds.size.height)
        animationView?.center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        if let model = data as? HomeSurveyModel {
            if model.getType() == 0 {
                bgView.backgroundColor = colorFromHex("00aad2")
                titleLabel.textColor = Colours.white
                desLabel.textColor = Colours.white
                titleLabel.text = "KHẢO SÁT BÁN HÀNG"
                
            }else if model.getType() == 1 {
                bgView.backgroundColor = colorFromHex("d9aa4e")
                titleLabel.textColor = Colours.themeColor
                desLabel.textColor = Colours.themeColor
                titleLabel.text = "KHẢO SÁT MỨC ĐỘ HÀI LÒNG VỀ DỊCH VỤ"
            }
            
            if UIScreen.main.bounds.size.width == 320 {
                giftBottomContraintLayout.constant = -24
            }else {
                giftBottomContraintLayout.constant = -50
            }
            
            desLabel.text = "Giúp Hyundai Thành Công  phục vụ quý khách ngày một tốt hơn"
            makeSurveyButton.setTitle("LÀM KHẢO SÁT", for: .normal)
        }
    }
}
