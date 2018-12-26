//
//  BaseViewModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftMessages

open class BaseViewModel{
    
    public let disposeBag = DisposeBag()
    public var service:ServiceProtocol
    
    public init(service:ServiceProtocol){
        self.service = service
    }
    
    open func showMessage(title:String, message:String)
    {
        let messageView = MessageView.viewFromNib(layout: .cardView)
        messageView.configureContent(title: title, body: message)
        messageView.configureDropShadow()
        messageView.button?.isHidden = true
        messageView.configureTheme(.warning, iconStyle: IconStyle.default)
        var config = SwiftMessages.defaultConfig
        config.duration = .seconds(seconds: 3)
        config.presentationContext = .window(windowLevel: UIWindow.Level.normal.rawValue)
        SwiftMessages.show(config: config,view:messageView)
    }
}
