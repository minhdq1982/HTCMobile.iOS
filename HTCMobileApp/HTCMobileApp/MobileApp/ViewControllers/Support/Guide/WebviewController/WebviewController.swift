//
//  WebviewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 11/6/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import UIKit
import WebKit
import RxSwift
import RxCocoa
import RxDataSources

enum BookType {
    case WARRANTY
    case BOOK
}


class WebviewController: BaseViewController {
    
    @IBOutlet weak var webview: UIWebView!
    @IBOutlet weak var menuBackground: UIImageView!
    @IBOutlet weak var menuStackView: UIStackView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var closeMenuButton: UIButton!
    @IBOutlet weak var contentTableView: UITableView!
    
    @IBOutlet weak var contentButton: UIButton!
    @IBOutlet weak var fullScreenButton: UIButton!
    @IBOutlet weak var zoomInButton: UIButton!
    @IBOutlet weak var zoomOutButton: UIButton!
    
    @IBOutlet weak var headerHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var bottomMenuHeightContraint: NSLayoutConstraint!
    @IBOutlet weak var menuTrailingContraint: NSLayoutConstraint!
    
    @IBOutlet weak var noDataLabel: UILabel!
    
    let zoomStep: CGFloat = 0.2
    let minZoomScale: CGFloat = 1
    let maxZoomScale: CGFloat = 3
    var zoomScale: CGFloat = 1
    
    let warranties: Variable<[WarrantyPolicyModel]> = Variable([])
    let guideBook: Variable<BookGuidanceModel> = Variable(BookGuidanceModel())
    var type: BookType = .WARRANTY
    
    let bottomMenuItems: Variable<[CategoryModel]> = Variable([])
    let contentMenuItems: Variable<[ContentMenuModel]> = Variable([])
    
    let contentIndex: Variable<Int> = Variable(0)
    var isFull: Bool = false
    
    override func setupView() {
        super.setupView()
        self.menuView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        webview.scrollView.minimumZoomScale = 1
        webview.scrollView.maximumZoomScale = 5
        webview.scalesPageToFit = false
        webview.delegate = self
        webview.backgroundColor = UIColor.clear
        webview.isOpaque = false
        
        self.contentTableView.register(ContentCell.nib, forCellReuseIdentifier: ContentCell.identifier)
        self.collectionView.register(ContentCollectionViewCell.nib, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.collectionView.collectionViewLayout = layout
        self.collectionView.delegate = self
        
        warranties.asObservable()
            .subscribe(onNext: {[weak self] (warranties) in
                self?.bottomMenuItems.value.removeAll()
                if warranties.count > 0 {
                    var counter: Int = 0
                    for warranty in  warranties {
                        //  Bottom list
                        var category = CategoryModel(id: counter, name: warranty.getName())
                        category.setIdentifier(ContentCollectionViewCell.identifier)
                        self?.bottomMenuItems.value.append(category)
                        
                        //  Menu list
                        self?.contentMenuItems.value.append(ContentMenuModel(title: warranty.getName(), isParrent: false))
                        
                        counter += 1
                    }
                }
            }).disposed(by: disposeBag)
        
        guideBook.asObservable()
            .subscribe(onNext: {[weak self] (model) in
                
                self?.setHeaderTitle(model.getTitle())
                
                if let contents = model.contents, contents.count > 0 {
                    self?.noDataLabel.isHidden = true
                    var counter: Int = 0
                    for item in  contents {
                        //  Bottom list
                        var category = CategoryModel(id: counter, name: item.getTitle())
                        category.setIdentifier(ContentCollectionViewCell.identifier)
                        self?.bottomMenuItems.value.append(category)
                        
                        //  Menu list
                        self?.contentMenuItems.value.append(ContentMenuModel(title: item.getTitle(), isParrent: item.isParrent()))
                        
                        counter += 1
                    }
                }else{
                    self?.noDataLabel.isHidden = false
                }
            }).disposed(by: disposeBag)
        
        contentIndex.asObservable()
            .subscribe(onNext: {[weak self] (index) in
                guard let s = self else {return}
                
                if s.type == .WARRANTY {
                    s.setHeaderTitle("Chính sách bảo hành")
                    if index < s.warranties.value.count {
                        let warranty = s.warranties.value[index]
                        s.loadContent(content: warranty.getContent())
                    }
                }else{
                    if let contents = s.guideBook.value.contents, index < contents.count {
                        let guide = contents[index]
                        s.loadContent(content: guide.getContent())
                    }
                }
                
            }).disposed(by: disposeBag)
        
        //  Bind to display GUI
        self.bottomMenuItems.asDriver()
            .drive(self.collectionView.rx.itemsSource())
            .disposed(by: disposeBag)
        self.contentMenuItems.asDriver()
            .drive(self.contentTableView.rx.itemsSource())
            .disposed(by: disposeBag)
        
        Driver.merge(contentTableView.rx.itemSelected.asDriver(), collectionView.rx.itemSelected.asDriver())
            .asObservable()
            .subscribe(onNext: {[weak self] (indexPath) in
                self?.contentIndex.value = indexPath.row
                self?.focusItemAtIndex(indexPath.row)
            }).disposed(by: disposeBag)
        
        //  Hidden right content menu
        contentTableView.rx.itemSelected
            .asObservable()
            .subscribe(onNext: {[weak self] _ in
                self?.showRightContentMenu(false)
            }).disposed(by: disposeBag)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            self.focusItemAtIndex(self.contentIndex.value)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.tabbar?.setHidden(true)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        appDelegate.tabbar?.setHidden(false)
    }
    
    override func localizable() {
        super.localizable()
    }
    
    override func tapBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadContent(content: String) {
        if content.isEmpty {
            //  Show there is no data
            webview.loadHTMLString("", baseURL: nil)
            noDataLabel.isHidden = false
        }else{
            noDataLabel.isHidden = true
            webview.loadHTMLString(content, baseURL: nil)
        }
        self.setZoomScale(scale: zoomScale)
    }
    
    func showFullScreen(isFull: Bool) {
        if isFull {
            headerHeightContraint.constant = 50
            bottomMenuHeightContraint.constant = 48
            self.headerView.alpha = 1
            self.collectionView.alpha = 1
            
            UIView.animate(withDuration: 0.3, animations: {
                self.headerHeightContraint.constant = 0
                self.bottomMenuHeightContraint.constant = 0
                self.headerView.alpha = 0
                self.collectionView.alpha = 0
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
            }) { _ in
                self.headerView.isHidden = true
                self.collectionView.isHidden = true
                self.fullScreenButton.isEnabled = true
            }
        }else{
            self.headerView.isHidden = false
            self.collectionView.isHidden = false
            
            headerHeightContraint.constant = 0
            bottomMenuHeightContraint.constant = 0
            
            self.headerView.alpha = 0
            self.collectionView.alpha = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.headerHeightContraint.constant = 50
                self.bottomMenuHeightContraint.constant = 48
                self.headerView.alpha = 1
                self.collectionView.alpha = 1
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
            }) { _ in
                self.fullScreenButton.isEnabled = true
            }
        }
    }
    
    func showMenu(_ isShow: Bool) {
        if isShow {
            menuBackground.isHidden = false
            menuBackground.alpha = 0
            menuStackView.isHidden = false
            menuStackView.alpha = 0
            
            UIView.animate(withDuration: 0.3, animations: {
                self.menuBackground.alpha = 1
                self.menuStackView.alpha = 1
            }) { _ in
                self.menuButton.isEnabled = true
            }
        }else{
            menuBackground.isHidden = false
            menuBackground.alpha = 1
            menuStackView.isHidden = false
            menuStackView.alpha = 1
            
            UIView.animate(withDuration: 0.3, animations: {
                self.menuBackground.alpha = 0
                self.menuStackView.alpha = 0
            }) { _ in
                self.menuButton.isEnabled = true
            }
        }
    }
    
    func showRightContentMenu(_ isShow: Bool) {
        if isShow {
            self.menuView.isHidden = false
            self.menuView.backgroundColor = UIColor.black.withAlphaComponent(0)
            menuTrailingContraint.constant = 0.8 * UIScreen.main.bounds.size.width
            
            UIView.animate(withDuration: 0.3, animations: {
                self.menuTrailingContraint.constant = 0
                self.menuView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
            }) { _ in
                
            }
        }else{
            self.menuView.isHidden = false
            menuTrailingContraint.constant = 0
            self.menuView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            
            UIView.animate(withDuration: 0.3, animations: {
                self.menuTrailingContraint.constant = 0.8 * UIScreen.main.bounds.size.width
                self.menuView.backgroundColor = UIColor.black.withAlphaComponent(0)
                
                self.view.setNeedsLayout()
                self.view.layoutIfNeeded()
                
            }) { _ in
                self.menuView.isHidden = true
            }
        }
    }
    
    @IBAction func tapCloseContentsMenuAction(_ sender: Any) {
//        self.menuView.isHidden = true
        self.showRightContentMenu(false)
    }
    
    @IBAction func tapShowContentMenu(_ sender: Any) {
        self.showRightContentMenu(true)
    }
    
    @IBAction func tapFullScreenAction(_ sender: Any) {
        self.fullScreenButton.isEnabled = false
        if isFull {
            isFull = false
            self.showFullScreen(isFull: false)
        }else{
            isFull = true
            self.showFullScreen(isFull: true)
        }
    }
    
    @IBAction func tapZoomInAction(_ sender: Any) {
        webview.scrollView.zoomScale += zoomStep
        zoomScale += zoomStep
        if zoomScale > maxZoomScale {
            zoomScale = maxZoomScale
        }
        self.setZoomScale(scale: zoomScale)
    }
    
    @IBAction func tapZoomOutAction(_ sender: Any) {
        webview.scrollView.zoomScale -= zoomStep
        
        zoomScale -= zoomStep
        if zoomScale < minZoomScale {
            zoomScale = minZoomScale
        }
        self.setZoomScale(scale: zoomScale)
    }
    
    @IBAction func tapShowHideMenuAction(_ sender: UIButton) {
        self.menuButton.isEnabled = false
        self.menuButton.isSelected = !self.menuButton.isSelected
        self.showMenu(self.menuButton.isSelected)
    }
    
    func setZoomScale(scale: CGFloat) {
        webview.stringByEvaluatingJavaScript(from: "document. body.style.zoom = \(scale);")
    }
    
    func focusItemAtIndex(_ index: Int) {
        
        for i in 0..<self.bottomMenuItems.value.count {
            if let cell = self.collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? ContentCollectionViewCell{
                cell.setSelected(index == i)
            }
        }
        
        if index < self.collectionView.numberOfItems(inSection: 0) {
            self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        }
    }
}

extension WebviewController: ContentViewControllerDelegate {
    func didChooseContentAtIndex(_ index: Int) {
        self.contentIndex.value = index
    }
}

extension WebviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row < self.bottomMenuItems.value.count {
            let item = self.bottomMenuItems.value[indexPath.row]
            
            if let font = UIFont(name: "HyundaiSansVNHeadOffice-Regular", size: 17) {
                let width = 36 + item.getName().width(withConstrainedHeight: 48, font: font)
                return CGSize(width: width, height: 48)
            }
        }
        return CGSize(width: 0, height: 48)
    }
}

extension WebviewController: UIWebViewDelegate {
    func webViewDidFinishLoad(_ webView: UIWebView) {
        self.setZoomScale(scale: zoomScale)
    }
}
