//
//  BaseTableViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import NVActivityIndicatorView
import RxSwift
import RxCocoa
import SwiftMessages
open class BaseTableViewController : UITableViewController , CTViewController ,SegueProtocol{
    
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    @IBAction func tapBackAction(_ sender: Any) {
        
    }
    
    @IBAction func tapNotificationAction(_ sender: Any) {
        
    }
    
    public func setSender(_ sender: Any?) {
        self.sender = sender
    }
    
    public func getSender() -> Any? {
        return self.sender
    }
    
    public var viewModel :BaseViewModel?
    public var sender:Any?
    public var nvActivityIndicator:NVActivityIndicatorView?
    public let disposeBag = DisposeBag()
    
    open func setupView (){
        
    }
    
    open func localizable (){
        
    }
    
    open func bindData(_ sink:SinkType) {
        sink.fetching?
            .drive(self.nvActivityIndicator!.rx.isAnimating)
            .disposed(by: disposeBag)
        sink.error?
            .drive(self.rx.showError)
            .disposed(by: disposeBag)
    }
    
    
    public func executeError(error:Error)
    {
        //  Handle error
        if(error is ServiceError)
        {
            
        }
        else if ((error as NSError).domain != NSURLErrorDomain){
            
        }
    }
    
    open func toastMessage(title: String, message:String, time:TimeInterval = 3)
    {
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.button?.isHidden = true
        messageView.configureDropShadow()
        messageView.configureTheme(.info, iconStyle: IconStyle.default)
        messageView.configureContent(title: title, body: message)
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: time)
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
        SwiftMessages.show(config: config, view: messageView)
    }
    
    open func showConfirmMessage(title:String, message:String, confirmAction:@escaping () -> Void, cancelAction:@escaping () -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: tr(L10n.commonTextOK), style: .default, handler: { _ in
            confirmAction()
        }))
        alert.addAction(UIAlertAction(title: tr(L10n.commonTextCancel), style: .cancel, handler: { _ in
            cancelAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    open func showMessage(title:String, message:String, closeAction: @escaping () -> Void)
    {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: tr(L10n.commonTextOK), style: .cancel, handler: { _ in
            closeAction()
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    override open func viewDidLoad() {
        let xAxis = self.view.center.x // or use (view.frame.size.width / 2) // or use (faqWebView.frame.size.width / 2)
        let yAxis = self.view.center.y // or use (view.frame.size.height / 2) // or use (faqWebView.frame.size.height / 2)
        let frame = CGRect(x: (xAxis - 45/2), y: (yAxis - 45/2), width: 45, height: 45)
        nvActivityIndicator = NVActivityIndicatorView(frame: frame)
        nvActivityIndicator?.type = .lineScalePulseOut // add your type
        nvActivityIndicator?.color = UIColor.red // add your color
        self.view.addSubview(nvActivityIndicator!)
        
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setupView()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.localizable()
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseTableViewController {
    func setHeaderTitle(_ title: String) {
        headerTitle.text = title
    }
}

extension BaseTableViewController {
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? BaseViewController{
            viewController.sender  = sender
        }
        
        if let viewController = segue.destination as? BaseTableViewController{
            viewController.sender  = sender
        }
    }
}
