//
//  ResultModel.swift
//  HTCMobileApp
//
//  Created by admin on 12/4/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

struct ResultModel: BaseModel {
    var identifier: String = ""
    public var question: String = ""
    public var answers: String?
    public var page, id: Int?
    
    public var surveyType: String?
    
    public func getSurveyType() -> String {
        return surveyType ?? ""
    }
    
    public func getId() -> Int {
        return id ?? 0
    }
    
    public func getPage() -> Int {
        return page ?? 0
    }

    public func getQuestion() -> String {
        return question
    }
    
    public mutating func updateAnswer(answers: String) {
        self.answers = answers
    }
    
    public func getAnswer() ->  String {
        return  answers ?? ""
    }
    
    init(id: Int, page: Int, question: String, answers: String, surveyType: String ) {
        self.question = question
        self.answers = answers
        self.id = id
        self.page = page
        self.surveyType = surveyType
    }

    init(question: String, answers: String ) {
        self.question = question
        self.answers = answers
    }
}
