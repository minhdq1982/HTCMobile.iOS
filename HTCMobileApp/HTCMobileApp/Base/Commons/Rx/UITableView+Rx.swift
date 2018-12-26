//
//  UITableView+Rx.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import RxDataSources
public protocol BindableCell {
    associatedtype Value
    func bind(_ value: Value)
}

extension Reactive where Base: UITableView {
    func items<S: Sequence, Cell: UITableViewCell, O: ObservableType>(
        cellIdentifier: String,
        cellType: Cell.Type)
        -> (O)
        -> (Disposable)
        where O.E == S, Cell: BindableCell, Cell.Value == S.Iterator.Element {
            return { source in
                let binder: (Int, Cell.Value, Cell) -> Void = { $2.bind($1) }
                return self.items(cellIdentifier: cellIdentifier, cellType: cellType)(source)(binder)
            }
    }
}

extension Reactive where Base: UITableView {
    public func itemsSource<S: Sequence,Cell: BaseTableViewCell, O : ObservableType>
        (cellIdentifier: String, cellType: Cell.Type = Cell.self)
        -> (_ source: O)
        -> Disposable
        where O.E == S {
            return { source in
                return self.items(cellIdentifier: cellIdentifier, cellType: cellType)(source)(){
                    row, data, cell in
                    cell.setDataContext(row:row,data: (data as! BaseModel))
                }
            }
    }
    
    public func itemsSource<S: Sequence, O : ObservableType>
        ()
        -> (_ source: O)
        -> Disposable
        where O.E == S {
            return { source in
                let dataSource = RxTableViewReactiveArrayDataSourceSequenceWrapper<S> { tv,i,item  in
                    let indexPath = IndexPath(item: i, section: 0)
                    if let model = item as? BaseModel
                    {
                        let cell = tv.dequeueReusableCell(withIdentifier: model.identifier, for: indexPath) as! BaseTableViewCell
                        cell.setDataContext(indexPath:indexPath,data: model)
                        return cell
                    }
                    return UITableViewCell()
                }
                return self.items(dataSource: dataSource)(source)
            }
    }
}
