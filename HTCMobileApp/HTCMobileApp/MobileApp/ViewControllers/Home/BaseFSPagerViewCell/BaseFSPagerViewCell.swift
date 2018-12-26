//
//  BaseFSPagerViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/25/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import FSPagerView
import RxSwift
import RxCocoa
import RxGesture

public class BaseFSPagerViewCell : FSPagerViewCell {
    public var data:Any?
    public let disposeBag = DisposeBag()
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentView.rx.tapGesture()
            .asObservable()
            .skip(1)
            .subscribe(onNext:{[weak self] _ in
                self?.selected()
            }).disposed(by: disposeBag)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    override public func awakeFromNib() {
        super.awakeFromNib()
    }
    
    open func setDataContext(index:Int,data:Any)
    {
        self.data = data
    }
    
    
    
    open func selected()
    {
        
    }
    
    public class var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    public class var identifier: String {
        return String(describing: self)
    }
    
    public func getHeight() -> CGFloat {
        return 30
    }
}
