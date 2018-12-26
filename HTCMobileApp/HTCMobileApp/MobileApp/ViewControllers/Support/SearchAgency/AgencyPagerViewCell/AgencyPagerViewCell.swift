//
//  AgencyPagerViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/2/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import FSPagerView
import RxSwift
import RxCocoa
import RxGesture

protocol AgencyPagerViewCellDelegate {
    
    func callHotlineCskh(agency: AgencyLocationModel)
    func callHotlineSale(agency: AgencyLocationModel)
    func callHotlineService(agency: AgencyLocationModel)
    func openWebsite(agency: AgencyLocationModel)
    
    func navigateToAgency(agency: AgencyLocationModel)
    func openGoogleMaps(agency: AgencyLocationModel)
    
}

class AgencyPagerViewCell: BaseFSPagerViewCell {
    
    @IBOutlet weak var agencyNameLabel: UILabel!
    @IBOutlet weak var agencyAddressLabel: UILabel!
    
    @IBOutlet weak var hotlineCSKH: UILabel!
    @IBOutlet weak var hotlineSellProduct: UILabel!
    @IBOutlet weak var hotlineServices: UILabel!
    
    @IBOutlet weak var cskhPhoneLabel: UILabel!
    @IBOutlet weak var sellProductPhoneLabel: UILabel!
    @IBOutlet weak var servicePhoneLabel: UILabel!
    
    @IBOutlet weak var websiteLabel: UILabel!
    
    @IBOutlet weak var directionButton: UIButton!
    @IBOutlet weak var googleMapButton: UIButton!
    
    var agencyModel: AgencyLocationModel?
    var delegate: AgencyPagerViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cskhPhoneLabel.rx.tapGesture()
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                if let agency = self?.agencyModel {
                    self?.delegate?.callHotlineCskh(agency: agency)
                }
            }).disposed(by: disposeBag)
        sellProductPhoneLabel.rx.tapGesture()
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                if let agency = self?.agencyModel {
                    self?.delegate?.callHotlineSale(agency: agency)
                }
            }).disposed(by: disposeBag)
        servicePhoneLabel.rx.tapGesture()
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                if let agency = self?.agencyModel {
                    self?.delegate?.callHotlineService(agency: agency)
                }
            }).disposed(by: disposeBag)
        websiteLabel.rx.tapGesture()
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                if let agency = self?.agencyModel {
                    self?.delegate?.openWebsite(agency: agency)
                }
            }).disposed(by: disposeBag)
        
        directionButton.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                if let agency = self?.agencyModel {
                    self?.delegate?.navigateToAgency(agency: agency)
                }
            }).disposed(by: disposeBag)
        
        googleMapButton.rx.tap
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                if let agency = self?.agencyModel {
                    self?.delegate?.openGoogleMaps(agency: agency)
                }
            }).disposed(by: disposeBag)
    }
    
    override public func setDataContext(index: Int, data: Any) {
        super.setDataContext(index: index, data: data)
        
        if let agency = data as? AgencyLocationModel
        {
            agencyModel = agency
            
            self.agencyNameLabel.text = agency.getName()
            self.agencyAddressLabel.text = "\(agency.getAddress())"
            self.cskhPhoneLabel.text = "\(agency.getHotline())"
            self.sellProductPhoneLabel.text = "\(agency.getHotlineSale())"
            self.servicePhoneLabel.text = "\(agency.getHotlineService())"
            self.websiteLabel.text = "\(agency.getWebsite())"
        }
    }
}
