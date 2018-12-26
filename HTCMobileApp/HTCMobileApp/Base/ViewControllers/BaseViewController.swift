//
//  BaseViewController.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftMessages
import NVActivityIndicatorView

open class BaseViewController: UIViewController, CTViewController, SegueProtocol{
    
    //  Outlet for header title
    @IBOutlet weak var headerTitle: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet fileprivate weak var notificationButton: UIButton!
    @IBOutlet fileprivate weak var notificationWidthContraint: NSLayoutConstraint!
    
    @IBAction func tapBackAction(_ sender: Any) {
        
    }
    
    @IBAction func tapNotificationAction(_ sender: Any) {
        if let notificationVC = R.storyboard.notification.notificationViewController() {
            self.navigationController?.pushViewController(notificationVC, animated: true)
        }
    }
    
    open var state:ViewControllerState = .Unknown
    
    public var viewModel :BaseViewModel?
    public var sender:Any?
    public var nvActivityIndicator:NVActivityIndicatorView?
    public let disposeBag = DisposeBag()
    
    
    public func setSender(_ sender: Any?) {
        self.sender = sender
    }
    
    public func getSender() -> Any? {
        return self.sender
    }
    
    open func setupView (){
        
    }
    
    open func localizable (){
        
    }
    
    open func bindData(_ sink:SinkType) {
        
        sink.fetching?
            .drive(self.nvActivityIndicator!.rx.isAnimating)
            .disposed(by: disposeBag)
        sink.fetching?
            .asObservable()
            .subscribe(onNext: { (isFetching) in
                if isFetching == true {
                    UIApplication.shared.beginIgnoringInteractionEvents()
                }else {
                    UIApplication.shared.endIgnoringInteractionEvents()
                }
            }).disposed(by: disposeBag)
        sink.error?
            .drive(self.rx.showError)
            .disposed(by: disposeBag)
    }
    
    
    open func executeError(error:Error)
    {
        if self.state != .ViewDidDisappear {
            if(error is ServiceError)
            {
                let error = error as! ServiceError
                switch error {
                case let .Error(code,message,_):
                    if code != "999" {
                        self.showMessage(message: message) {}
                    }else {
                        self.showMessage(message: "Đã xảy ra sự cố. Vui lòng thử lại sau.") {}
                    }
                case .NetWorkError:
                    self.showMessage(message: "Không có kết nối mạng") {}
                    break
                case .ParseError:
                    self.showMessage(message: "Lỗi dữ liệu trả về") {}
                    break
                case .EncryptError:
                    break
                case .Cancel:
                    break
                }
            }
            else {
                if ((error as NSError).code == NSURLErrorTimedOut
                    || (error as NSError).code == NSURLErrorCannotFindHost
                    || (error as NSError).code == NSURLErrorCannotConnectToHost) {
                    self.showMessage(message: "Thời gian xử lý quá chậm. Vui lòng thử lại sau.") {}
                }
            }
        }
    }
    func alertWith(_ title: String?, _ message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: tr(L10n.alertClose), style: .cancel, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    /*
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
    */
    
    open func showMessage(message: String, closeAction: @escaping () -> Void) {
        
        if let tabbar = appDelegate.tabbar {
            if tabbar.presentedViewController != nil {
                return
            }
        }else {
            if self.presentedViewController != nil {
                return
            }
        }
        
        if let commonAlert = R.storyboard.main.commonAlertView() {
            commonAlert.providesPresentationContextTransitionStyle = true
            commonAlert.definesPresentationContext = true
            commonAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            commonAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            if let tabbar = appDelegate.tabbar {
                tabbar.present(commonAlert, animated: true, completion: nil)
            }else{
                self.present(commonAlert, animated: true, completion: nil)
            }
            
            commonAlert.message = message
            commonAlert.onOK.asObservable()
                .skip(1)
                .subscribe(onNext: { _ in
                    closeAction()
                }).disposed(by: disposeBag)
        }
    }
    
    open func showConfirmMessage(message: String, confirmAction:@escaping () -> Void, cancelAction:@escaping () -> Void) {
        if let alert = R.storyboard.main.confirmAlertView() {
            alert.providesPresentationContextTransitionStyle = true
            alert.definesPresentationContext = true
            alert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
            alert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
            if let tabbar = appDelegate.tabbar {
                tabbar.present(alert, animated: true, completion: nil)
            }else{
                self.present(alert, animated: true, completion: nil)
            }
            alert.message = message
            
            alert.onConfirm.asObservable()
                .skip(1)
                .subscribe(onNext: { _ in
                    confirmAction()
                }).disposed(by: disposeBag)
            alert.onCancel.asObservable()
                .skip(1)
                .subscribe(onNext: { _ in
                    cancelAction()
                }).disposed(by: disposeBag)
        }
    }
    
    override open func viewDidLoad() {
        super.viewDidLoad()
        self.state = .ViewDidload
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        if headerTitle != nil {
            headerTitle.font = UIFont(name: "HyundaiSansVNHeadOffice-Medium", size: 17)
        }
//        self.setNeedsStatusBarAppearanceUpdate()
        
        // Do any additional setup after loading the view.
        let xAxis = self.view.center.x // or use (view.frame.size.width / 2)
        let yAxis = self.view.center.y // or use (view.frame.size.height / 2)
        let frame = CGRect(x: (xAxis - 45/2), y: (yAxis - 45/2), width: 45, height: 45)
        nvActivityIndicator = NVActivityIndicatorView(frame: frame, type: .ballSpinFadeLoader, color: Colours.greyColor, padding: 0)
        self.view.addSubview(nvActivityIndicator!)
        
        self.setupView()
    }
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.state = .ViewWillAppear
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        if notificationButton != nil {
            notificationButton.isHidden = !UserPrefsHelper.shared.isLoggedIn()
            if notificationWidthContraint != nil {
                notificationWidthContraint.constant = UserPrefsHelper.shared.isLoggedIn() ? 40 : 0
            }
        }
        self.localizable()
    }
    
    open override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.setNeedsLayout()
        self.view.layoutIfNeeded()
    }
    
    override open func viewDidDisappear(_ animated: Bool) {
        self.state = .ViewDidDisappear
        super.viewDidDisappear(animated)
    }
    
    override open var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension BaseViewController {
    override open func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let viewController = segue.destination as? SegueProtocol{
            viewController.setSender(sender)
        }
    }
}

extension BaseViewController {
    func setHeaderTitle(_ title: String) {
        headerTitle.text = title
    }
}

public protocol SegueProtocol {
    func setSender(_ sender:Any?)
    func getSender() -> Any?
}

public enum ViewControllerState : Int , Equatable {
    case Unknown = 0
    case ViewDidload = 1
    case ViewWillAppear = 2
    case ViewDidDisappear  = 3
    
    public static func ==(lhs: ViewControllerState, rhs: ViewControllerState) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }
}
