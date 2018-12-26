//
//  NewsDetailViewController.swift
//  HTCMobileApp
//
//  Created by admin on 11/5/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class NewsDetailViewController: BaseViewController {
    // MARK: - Outlet and Variable
    var news: NewsModel?
    var technicalModel: TechnicalGuidanceModel?
    
    @IBOutlet weak var imageViewTitle: UIImageView!
    @IBOutlet weak var dateCreateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var noDataLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var webviewHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var scrollContentHeightContraint: NSLayoutConstraint!
    var isGoodNews: Bool = false
    
    // MARK: - LifeCycle
    override func setupView() {
        super.setupView()
        
        //  Disable webview scrolling
        webview.scrollView.isScrollEnabled = false
        webview.scrollView.bounces = false
        webview.backgroundColor = Colours.white
        webview.isOpaque = false
        webview.delegate = self
        let htmlFormat = "<!DOCTYPE html><html><head><style>img {width: 100%;}</style></head><body>%@</body></html>"
        if let model = technicalModel {
            
            setHeaderTitle(model.getTitle())
            titleLabel.text = model.getTitle()
            dateCreateLabel.text = model.getCreationTimeDisplay()
            
            if !model.getContent().isEmpty {
                noDataLabel.isHidden = true
//                webview.loadHTMLString(String(format: htmlFormat, model.getContent()), baseURL: nil)
                webview.loadHTMLString(model.getContent().replacingOccurrences(of: "<img src=", with: "<img style=\"width:100%;height:auto\" src="), baseURL: nil)
            } else{
                noDataLabel.isHidden = false
            }
            
            if let url = model.getImageUrl() {
                imageViewTitle.kf.setImage(with: url, placeholder: R.image.no_image_bg_big())
            }else{
                imageViewTitle.image = R.image.no_image_bg_big()
            }
            
        }else if let model = news {
            
            setHeaderTitle(tr(L10n.newsTitle))
            titleLabel.text = model.getTitle()
            dateCreateLabel.text = model.getCreationTimeDisplay()
            
            if !model.getFullContent().isEmpty {
                noDataLabel.isHidden = true
//                webview.loadHTMLString(String(format: htmlFormat, model.getFullContent()), baseURL: nil)
                webview.loadHTMLString(model.getFullContent().replacingOccurrences(of: "<img src=", with: "<img style=\"width:100%;height:auto\" src="), baseURL: nil)
            } else{
                noDataLabel.isHidden = false
            }
            
            if let url = model.getImageUrl() {
                imageViewTitle.kf.setImage(with: url, placeholder: R.image.no_image_bg_big())
            }else{
                imageViewTitle.image = R.image.no_image_bg_big()
            }
        }
    }
    
    override func localizable() {
        super .localizable()
    }
    
    override func bindData(_ sink: SinkType) {
        super .bindData(sink)
    }
    
    // MARK: - function
    override func tapBackAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension NewsDetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: webView.scrollView.contentSize.height + 284 + 10)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.scrollContentHeightContraint.constant = webView.scrollView.contentSize.height + 284 + 10
            self.webviewHeightContraint.constant = webView.scrollView.contentSize.height
        }
    }
}
