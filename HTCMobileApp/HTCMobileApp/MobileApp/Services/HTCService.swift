//
//  HTCService.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import SwiftMessages
import Alamofire

open class HTCService : Service{
    
    private var cancelServices:[String] = []
    
    override public init() {
        super.init()
    }
    
    
    override open func cancelService(id: String) {
        if(!id.isEmpty){
            cancelServices.append(id)
        }
    }
    
    override open func get(_ request: RequestProtocol) -> Observable<String>
    {
        
        return Observable<String>.create({[weak self] observer in
            
            if(!NetworkConnectivity.isConnectedToInternet)
            {
                observer.onError(ServiceError.NetWorkError)
            }
            
            self?.sessionManager.request(request.getRequest())
                .responseString{ response in
                    let id = request.getId()
                    if let index = self?.cancelServices.index(of: id)
                    {
                        self?.cancelServices.remove(at: index)
                        observer.onCompleted()
                    }                    
                    
                    switch response.result {
                    case .success :
                        print("http code: \(response.response?.statusCode)")
                        observer.onNext(response.value!)
                        observer.onCompleted()
                    case .failure(let error):
                        observer.onError(error)
                    }
            }
            return Disposables.create()
        })
    }
    
    open override func getItem<T:ImmutableMappable>(_ type:T.Type,_ request:RequestProtocol) ->  Observable<T>
    {
        return self.get(request)
            .observeOn(MainScheduler.instance)
            .flatMap{ json -> Observable<ItemResponse<T>> in
                
                if(json.isEmpty)
                {
                    return Observable.error(ServiceError.Error(code: "999",message: "Error", json: json))
                }
                
                print("Response: \(json)")
                
                let response = try? Mapper<ItemResponse<T>>().map(JSONString: json)
                if(response == nil)
                {
                    return Observable.error(ServiceError.ParseError)
                }
                
                if(response!.code != "200")
                {
                    return Observable.error(ServiceError.Error(code: response!.getCode(),message: response!.getMessage() , json: json))
                }
                
                return Observable.just(response!)
                
            }
            .filter{$0.data != nil}
            .map{$0.data!}
//            .retryWhen { (attempts: Observable<Error>) -> Observable<Void> in
//                return self.retryDelegate?.retryWhen(attempts: attempts, filter: self.errorFilter) ?? attempts.map { _ in}
//        }
    }
    
    open override func getNewsFeedItem<T>(_ type: T.Type, _ request: RequestProtocol) -> Observable<T> where T : ImmutableMappable {
        return self.get(request)
            .observeOn(MainScheduler.instance)
            .flatMap{ json -> Observable<T> in
                
                if(json.isEmpty)
                {
                    return Observable.error(ServiceError.Error(code: "999",message: "Error", json: ""))
                }
                print("response: \(json)")
                
                let all = try? Mapper<T>().map(JSONString: json)
                if(all == nil)
                {
                    return Observable.error(ServiceError.ParseError)
                }
                return Observable.just(all!)
        }
    }
    
    open override func getAllResponse<T>(_ type: T.Type, _ request: RequestProtocol) -> Observable<T> where T : ImmutableMappable {
        return self.get(request)
            .observeOn(MainScheduler.instance)
            .flatMap{ json -> Observable<T> in
                
                if(json.isEmpty)
                {
                    return Observable.error(ServiceError.Error(code: "999",message: "Error", json: ""))
                    
                }
                print("response: \(json)")
                let response = try? Mapper<ItemResponse<T>>().map(JSONString: json)
                if(response == nil)
                {
                    return Observable.error(ServiceError.ParseError)
                }
                
                if(response!.code != "200")
                {
                    return Observable.error(ServiceError.Error(code: response!.getCode(),message: response!.getMessage(),json: json))
                }
                
                let all = try? Mapper<T>().map(JSONString: json)
                if(all == nil)
                {
                    return Observable.error(ServiceError.ParseError)
                }
                
                return Observable.just(all!)
                
            }
//            .retryWhen { (attempts: Observable<Error>) -> Observable<Void> in
//                return self.retryDelegate?.retryWhen(attempts: attempts, filter: self.errorFilter) ?? attempts.map { _ in}
//        }
    }
    
    
    override open func getMessage(_ request: RequestProtocol) -> Observable<String> {
        return self.get(request)
            .observeOn(MainScheduler.instance)
            .flatMap{ json -> Observable<String> in
                
                if(json.isEmpty)
                {
                    return Observable.error(ServiceError.Error(code: "999",message: "Error", json: json))
                }
                
                print("response: \(json)")
                let response = try? Mapper<BaseResponse>().map(JSONString: json)
                if(response == nil)
                {
                    return Observable.error(ServiceError.ParseError)
                }
                
                if(response!.code != "200")
                {
                    return Observable.error(ServiceError.Error(code: response!.getCode(),message: response!.getMessage(), json: json ))
                }
                return Observable.just(response?.message ?? "")
                
            }
//            .retryWhen { (attempts: Observable<Error>) -> Observable<Void> in
//                return self.retryDelegate?.retryWhen(attempts: attempts, filter: self.errorFilter) ?? attempts.map { _ in}
//        }
    }
    
    override open func getItems<T:ImmutableMappable>(_ type: T.Type, _ request: RequestProtocol) -> Observable<[T]> {
        return self.get(request)
            .observeOn(MainScheduler.instance)
            .flatMap
            { json -> Observable<ItemsResponse<T>> in
                             
                if(json.isEmpty)
                {
                    return Observable.error(ServiceError.Error(code: "999",message: "Error", json: json))
                }
                
                print("response: \(json)")
                
                let response = try? Mapper<ItemsResponse<T>>().map(JSONString: json)
                if(response == nil)
                {
                    return Observable.error(ServiceError.ParseError)
                }
                
                if(response!.code != "200")
                {
                    return Observable.error(ServiceError.Error(code: response!.getCode(),message : response!.getMessage(),json: json))
                }
                
                return Observable.just(response!)
                
            }
            .filter{$0.data != nil}
            .map{$0.data!}
//            .retryWhen { (attempts: Observable<Error>) -> Observable<Void> in
//                return self.retryDelegate?.retryWhen(attempts: attempts, filter: self.errorFilter) ?? attempts.map { _ in}
//        }
        
    }
    
}

