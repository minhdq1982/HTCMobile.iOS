//
//  AnswerModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

class AnswerModel: BaseModel {
    
    public var identifier: String = ""
    public var answer: String?
    public var type: String?
    public var id: Int?
    public func getId() -> Int {
        return id ?? 0
    }
    public func getType() -> String {
        return type ?? ""
    }
    
 
    public func getAnswer() -> String {
        return  answer ?? ""
    }
    
    init(_ answer: String, _ type: String) {
        if type == TypeQuestionEnum.RADIO.typeValue() {
            self.identifier = "RadioCollectionCell"
        } else if type == TypeQuestionEnum.CHECKBOX.typeValue() {
            self.identifier = "CheckBoxTableCell"
        }
        self.answer = answer
    }
    
    init(_ id: Int, _ answer: String) {
        self.answer = answer
        self.id = id
    }
}
