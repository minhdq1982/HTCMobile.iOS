//
//  Services.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
import Alamofire
import RxAlamofire
import RxSwift
import NVActivityIndicatorView
open class Service : ServiceProtocol {
    open func cancelService(id: String) {
        
    }
    
    public var sessionManager:SessionManager
    
    var activityData = ActivityData(type:NVActivityIndicatorType.lineScalePulseOut)
//    public var retryDelegate: RetryDelegate? = RetryHandler()
//    public var errorFilter: ErrorFilter = NetworkErrorFilter()
    
    let disposeBag = DisposeBag()
    public init(){
        //sessionManager = SessionManager.default
        let timeout = 60
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForResource = TimeInterval(timeout)
        configuration.timeoutIntervalForRequest = TimeInterval(timeout)
        sessionManager = Alamofire.SessionManager(configuration: configuration)
    }
    
    open func get(_ request:RequestProtocol)-> Observable<String>
    {
        return sessionManager.rx.request( urlRequest: request.getRequest())
            .flatMap{ request -> Observable<(HTTPURLResponse,String)> in
                if(!NetworkConnectivity.isConnectedToInternet)
                {
                    return Observable.error(ServiceError.NetWorkError)
                }
                return request.rx.responseString()
            }
            //  TODO retry when request error if needs
//            .retryWhen { (attempts: Observable<Error>) -> Observable<Void> in
//                return self.retryDelegate?.retryWhen(attempts: attempts, filter: self.errorFilter) ?? attempts.map { _ in}
//            }
            .subscribeOn(MainScheduler.instance)
            .map{$0.1}
    }
    
    open func getItem<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<T>
    {
        print(type)
        
        return self.get(request)
            .map{Mapper<T>().map(JSONString: $0)!}
    }
    
    open func getNewsFeedItem<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<T>
    {
        print(type)
        
        return self.get(request)
            .map{Mapper<T>().map(JSONString: $0)!}
    }
    
    open func getAllResponse<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<T>
    {
        print(type)
        
        return self.get(request)
            .map{Mapper<T>().map(JSONString: $0)!}
    }
    
    open func getMessage(_ request:RequestProtocol) -> Observable<String>
    {
        return Observable.just("")
    }
    
    open func getItems<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) -> Observable<[T]>
    {
        return self.get(request)
            .map{Mapper<T>().mapArray(JSONString: $0)!}
    }
}

public enum ServiceError:Error{
    case NetWorkError
    case ParseError
    case EncryptError
    case Cancel
    case Error(code:String,message:String,json:String)
}
