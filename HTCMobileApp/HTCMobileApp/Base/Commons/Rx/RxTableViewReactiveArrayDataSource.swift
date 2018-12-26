//
//  RxTableViewReactiveArrayDataSource.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
// objc monkey business
public class _RxTableViewReactiveArrayDataSource
    : NSObject
, UITableViewDataSource  {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func _tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _tableView(tableView, numberOfRowsInSection: section)
    }
    
    fileprivate func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return _tableView(tableView, cellForRowAt: indexPath)
    }
    
    
}

public class RxTableViewReactiveArrayDataSourceSequenceWrapper<S: Sequence>
    : RxTableViewReactiveArrayDataSource<S.Iterator.Element>
, RxTableViewDataSourceType{
    public typealias Element = S
    
    override init(cellFactory: @escaping CellFactory) {
        super.init(cellFactory: cellFactory)
        
    }
    
    public func tableView(_ tableView: UITableView, observedEvent: Event<S>) {
        Binder(self) { tableViewDataSource, sectionModels in
            let sections = Array(sectionModels)
            tableViewDataSource.tableView(tableView, observedElements: sections)
            }.on(observedEvent)
    }
    
    
}

// Please take a look at `DelegateProxyType.swift`
public class RxTableViewReactiveArrayDataSource<Element>
    : _RxTableViewReactiveArrayDataSource
, SectionedViewDataSourceType {
    typealias CellFactory = (UITableView, Int, Element) -> UITableViewCell
    
    var itemModels: [Element]? = nil
    
    func modelAtIndex(_ index: Int) -> Element? {
        return itemModels?[index]
    }
    
    public func model(at indexPath: IndexPath) throws -> Any {
        precondition(indexPath.section == 0)
        guard let item = itemModels?[indexPath.item] else {
            throw RxCocoaError.itemsNotYetBound(object: self)
        }
        return item
    }
    
    let cellFactory: CellFactory
    
    init(cellFactory: @escaping CellFactory) {
        self.cellFactory = cellFactory
    }
    
    override func _tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemModels?.count ?? 0
    }
    
    override func _tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return cellFactory(tableView, indexPath.item, itemModels![indexPath.row])
    }
    
    // reactive
    
    func tableView(_ tableView: UITableView, observedElements: [Element]) {
        self.itemModels = observedElements
        
        tableView.reloadData()
    }
}
