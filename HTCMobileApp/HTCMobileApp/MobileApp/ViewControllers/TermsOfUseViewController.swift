//
//  TermsOfUseViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/23/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

class TermsOfUseViewController: BaseViewController {
    
    @IBOutlet weak var agreeButton: UIButton!
    @IBOutlet weak var webView: UIWebView!
    
    override func setupView() {
        super.setupView()
        
        agreeButton.then {
            $0.setTitle(tr(L10n.termofuseTextAgree), for: .normal)
        }
        
        agreeButton.rx.tap.take(1)
            .asObservable()
            .subscribe(onNext: { [weak self](_) in
                self?.moveToHome()
            }).disposed(by: disposeBag)
        
        webView.backgroundColor = UIColor.clear
        webView.isOpaque = false
        
        viewModel = TermsOfUseViewModel(service: HTCService())
        let source = TermsOfUseViewModel.Source(viewWillAppear: self.rx.viewWillAppear.take(1).asDriver(onErrorJustReturn: ()))
        let sink = (viewModel as! TermsOfUseViewModel).transform(source: source)
        self.bindData(sink)
        
    }
    
    override func bindData(_ sink: SinkType) {
        super.bindData(sink)
        
        if let sink = sink as? TermsOfUseViewModel.Sink {
            sink.htmlString.asObservable()
                .subscribe(onNext: {[weak self] (termOfUse) in
                    if let content = termOfUse.content, !content.isEmpty {
                        self?.loadHtmlString(htmlString: content)
                    }else{
                        self?.loadHtmlString(htmlString: "Không có dữ liệu")
                    }
                }).disposed(by: disposeBag)
        }
    }
    
    func loadHtmlString(htmlString: String) {
        let html = "<div style=\"color:#FFFFFF ;  \">\(htmlString)</div>\""
        self.webView.loadHTMLString(html, baseURL: nil)
    }
    
    @objc func moveToHome() {
        //  Save prefs for the first time
        UserPrefsHelper.shared.setAgreeTermOfUse(true)
        
        let tabbar = appDelegate.createTabbarControler()
        appDelegate.tabbar = tabbar
        self.navigationController?.pushViewController(tabbar, animated: true)
    }
}
