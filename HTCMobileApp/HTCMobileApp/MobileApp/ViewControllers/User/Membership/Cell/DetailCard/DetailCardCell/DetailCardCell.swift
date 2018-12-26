//
//  DetailCardCell.swift
//  HTCMobileApp
//
//  Created by admin on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit

protocol DetailCardCellDelegate: class {
    func openHistory(cell: DetailCardCell)
    func useCard(itemHeader: ItemHeader, cell: DetailCardCell)
    func delete(vinno: String, cell: DetailCardCell)
}

class DetailCardCell: BaseTableViewCell {
  
    @IBOutlet weak var useCardButton: UIButton!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var vinnoLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var licensePlate: UILabel!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var historyButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    weak var delegate: DetailCardCellDelegate?
    var itemHeaders: ItemHeader?
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        super .setDataContext(indexPath: indexPath, data: data)
        if let header = data as? ItemHeader {
            itemHeaders = header
            brandLabel.text = header.getBrand()
            vinnoLabel.text = header.getVinno()
            usernameLabel.text = header.getUsername()
            licensePlate.text = "SAN FE | " + header.getLicensePlate()
            rankLabel.text = header.getRank()
            historyButton.layer.cornerRadius = 3
            deleteButton.layer.cornerRadius = 3
        }
    }
    @IBAction func openHistory(_ sender: Any) {
        delegate?.openHistory(cell: self)
    }
    @IBAction func onDelete(_ sender: Any) {
        delegate?.delete(vinno: (itemHeaders?.getVinno())!, cell: self)
    }
    @IBAction func onUseCard(_ sender: Any) {
        delegate?.useCard(itemHeader: itemHeaders!, cell: self)
    }
    
    
    
}
