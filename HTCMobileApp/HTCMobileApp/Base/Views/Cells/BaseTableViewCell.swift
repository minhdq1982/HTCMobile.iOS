//
//  BaseTableViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
open class BaseTableViewCell: UITableViewCell {
    public var data:BaseModel?
    
    open func setDataContext(row:Int, data:BaseModel)
    {
        self.data = data
    }
    
    open func setDataContext(indexPath:IndexPath, data:BaseModel)
    {
        self.data = data
    }
    
    open func selected()
    {
        
    }
    
    open func deSelected()
    {
        
    }
    
    public class var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public class var identifier: String {
        return String(describing: self)
    }
}
