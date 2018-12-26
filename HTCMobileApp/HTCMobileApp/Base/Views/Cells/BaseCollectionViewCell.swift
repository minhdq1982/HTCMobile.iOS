//
//  BaseCollectionViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit

open class BaseCollectionViewCell: UICollectionViewCell {
    open func setDataContext(row:Int, data:BaseModel)
    {
        
    }
    
    open func setDataContext(indexPath:IndexPath, data:BaseModel)
    {
        
    }
    
    public class var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public class var identifier: String {
        return String(describing: self)
    }
}
