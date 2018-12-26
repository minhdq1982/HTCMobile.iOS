//
//  JsonConverter.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/19/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper
/*public class JSONInt2StringTransform: TransformType {
 public init()
 {
 
 }
 
 public func transformFromJSON(_ value: Any?) -> String? {
 if let strValue = value as? Int {
 return String(strValue)
 }
 return value as? String ?? nil
 }
 
 public  func transformToJSON(_ value: String?) -> Int? {
 if let intValue = value {
 return Int(intValue)
 }
 return nil
 }
 
 }*/

public class JSONInt642StringTransform: TransformType {
    public init()
    {
        
    }
    
    public func transformFromJSON(_ value: Any?) -> String? {
        if let strValue = value as? Int64 {
            return String(strValue)
        }
        return value as? String ?? nil
    }
    
    public  func transformToJSON(_ value: String?) -> Int64? {
        if let intValue = value {
            return Int64(intValue)
        }
        return nil
    }
    
}


public class JSONDouble2StringTransform: TransformType {
    public init()
    {
        
    }
    
    public func transformFromJSON(_ value: Any?) -> String? {
        if let strValue = value as? Double {
            return String(strValue)
        }
        return value as? String ?? nil
    }
    
    public  func transformToJSON(_ value: String?) -> Double? {
        if let intValue = value {
            return Double(intValue)
        }
        return nil
    }
    
}


public class JSONStringToInt64Transform: TransformType {
    
    public typealias Object = Int64
    public typealias JSON = String
    
    public init()
    {
        
    }
    
    public func transformFromJSON(_ value: Any?) -> Int64? {
        if let strValue = value as? String {
            return Int64(strValue)
        }
        return value as? Int64 ?? nil
    }
    
    public func transformToJSON(_ value: Int64?) -> String? {
        if let intValue = value {
            return "\(intValue)"
        }
        return nil
    }
}


public class JSONStringToIntTransform: TransformType {
    
    public typealias Object = Int
    public typealias JSON = String
    
    public init()
    {
        
    }
    
    public func transformFromJSON(_ value: Any?) -> Int? {
        if let strValue = value as? String {
            return Int(strValue)
        }
        return value as? Int ?? nil
    }
    
    public func transformToJSON(_ value: Int?) -> String? {
        if let intValue = value {
            return "\(intValue)"
        }
        return nil
    }
}
