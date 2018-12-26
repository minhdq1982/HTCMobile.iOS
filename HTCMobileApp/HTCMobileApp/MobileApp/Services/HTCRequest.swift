//
//  HTCRequest.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import Alamofire

struct HTCRequest: RequestProtocol {
    
    private var postData:[String:Any] = [:]
    private var function:String = ""
    private var httpMethod:HttpMethod = .get
    private var getParams:String = ""
    private var contentType:String = ""
    private var isRequireLogin = false
    //  For upload avatar
    private var isMultipartForm = false
    private var imageData: Data = Data()
    
    func getId() -> String {
        return ""
    }

    public mutating func setBodyData(_ data: Data) {
        print(data)
    }

    public  func getRequest() -> URLRequest {
        print(Api.default.getUrl())
        var urlString = "\(Api.default.getUrl())\(function)"
        if (httpMethod == .get || httpMethod == .delete) && !getParams.isEmpty {
            urlString.append("?\(getParams)")
        }
        print("Request URL: \(urlString)")
        var urlRequest = URLRequest(url: URL(string:urlString)!)
        urlRequest.httpMethod = httpMethod.rawValue
        
        //  multipart form upload
        
        let boundary = self.generateBoundaryString()
        if isMultipartForm {
            urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        }else{
            urlRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }
        
        if self.isRequireLogin
        {
            urlRequest.setValue("Bearer \(Api.default.accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        if httpMethod == .post {
            if isMultipartForm {
                if imageData.count > 0 {
                    let fullData = self.createBodyWithParameters(filePathKey: "File", imageDataKey: imageData, boundary: boundary)
                    urlRequest.setValue("\(fullData.count)", forHTTPHeaderField: "Content-Length")
                    urlRequest.httpBody = fullData
                }
            }else{
                if postData.count > 0 {
                    print("Post params: \(postData.toJsonString())")
                    urlRequest.httpBody =  postData.toJsonString().data(using: .utf8)
                }
            }
            
        }
        return urlRequest
    }
    
    public init(function:String, httpMethod:HttpMethod = .get, contentType: String = "application/json",isRequireLogin :Bool = false, postData:[String:Any] = [:], getParams: String = "", isMultipartForm: Bool = false, imageData: Data = Data()) {
        self.httpMethod = httpMethod
        self.contentType = contentType
        self.postData = postData
        self.function = function
        self.isRequireLogin = isRequireLogin
        self.getParams = getParams
        //  For upload multi part form
        self.isMultipartForm = isMultipartForm
        self.imageData = imageData
    }
    
    
    public mutating func setData(postData:[String:Any],function:String)
    {
        self.postData = postData
        self.function = function
    }
    
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    fileprivate func createBodyWithParameters(/*parameters: [String: String]?, */filePathKey: String?, imageDataKey: Data, boundary: String) -> Data {
        
        var body = Data()
        
        let filename = "user-profile.png"
        let mimetype = "image/png"
        
        guard let boundaryData = "--\(boundary)\r\n".data(using: String.Encoding.utf8),
                let contentDisposition = "Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n".data(using: String.Encoding.utf8),
            let contentType = "Content-Type: \(mimetype)\r\n\r\n".data(using: String.Encoding.utf8),
            let endBody = "\r\n".data(using: String.Encoding.utf8) else {return Data()}

        
        body.append(boundaryData)
        body.append(contentDisposition)
        body.append(contentType)
        
        body.append(imageDataKey)
        body.append(endBody)
        body.append(boundaryData)
        
        return body
    }
}
