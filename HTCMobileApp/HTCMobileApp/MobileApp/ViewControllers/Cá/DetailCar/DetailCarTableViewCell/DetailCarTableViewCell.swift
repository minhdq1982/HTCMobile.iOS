//
//  DetailCarTableViewCell.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/7/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class DetailCarTableViewCell: BaseTableViewCell {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var contentHeight: NSLayoutConstraint!
    
    let height: Variable<CGFloat> = Variable(0)
    let content: Variable<String> = Variable("")
    let disposeBag = DisposeBag()
    var carModel: CarModel?
    let version: Variable<CarSpecModel> = Variable(CarSpecModel())
    
    override func awakeFromNib() {
        super.awakeFromNib()
        webView.scrollView.isScrollEnabled = false
        webView.scrollView.bounces = false
        webView.backgroundColor = Colours.white
        webView.isOpaque = false
        webView.delegate = self
        
        content.asObservable()
            .subscribe(onNext: {[weak self] (content) in
                self?.loadHtmlString(content)
            }).disposed(by: disposeBag)
        
        version.asObservable()
            .skip(1)
            .subscribe(onNext: { (specModel) in
                
            }).disposed(by: disposeBag)
    }
    
    override func setDataContext(indexPath: IndexPath, data: BaseModel) {
        //  Do nothing
    }
    
    fileprivate func loadHtmlString(_ content: String) {
        webView.loadHTMLString(content, baseURL: nil)
    }
    
    func showSpecs(_ isShow: Bool) {
        self.tableView.isHidden = !isShow
        self.webView.isHidden = isShow
    }
}

extension DetailCarTableViewCell: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        contentHeight.constant = webView.scrollView.contentSize.height
        height.value = contentHeight.constant
        self.contentView.setNeedsLayout()
        self.contentView.layoutIfNeeded()
    }
}
