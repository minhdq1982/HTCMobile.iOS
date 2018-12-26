//
//  UICollectionView+Rx.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import UIKit

extension Reactive where Base: UICollectionView{
    /*public func items<S: Sequence, Cell: UICollectionViewCell, O : ObservableType>
     (cellIdentifier: String, cellType: Cell.Type = Cell.self)
     -> (_ source: O)
     -> (_ configureCell: @escaping (Int, S.Iterator.Element, Cell) -> Void)
     -> Disposable where O.E == S {
     return { source in
     return { configureCell in
     let dataSource = RxCollectionViewReactiveArrayDataSourceSequenceWrapper<S> { (cv, i, item) in
     let indexPath = IndexPath(item: i, section: 0)
     let cell = cv.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! Cell
     configureCell(i, item, cell)
     return cell
     }
     
     return self.items(dataSource: dataSource)(source)
     }
     }
     }*/
    
    public func itemsSource<S: Sequence, O : ObservableType>
        ()
        -> (_ source: O)
        -> Disposable
        where O.E == S {
            return { source in
                let dataSource = RxCollectionViewReactiveArrayDataSourceSequenceWrapper<S> { tv,i,item  in
                    let indexPath = IndexPath(item: i, section: 0)
                    let cell = tv.dequeueReusableCell(withReuseIdentifier: (item as! BaseModel).identifier, for: indexPath) as! BaseCollectionViewCell
                    cell.setDataContext(indexPath:indexPath,data: (item as! BaseModel))
                    return cell
                }
                return self.items(dataSource: dataSource)(source)
            }
    }
}
