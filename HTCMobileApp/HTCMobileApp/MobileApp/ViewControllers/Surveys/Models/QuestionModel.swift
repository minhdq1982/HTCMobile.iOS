//
//  QuestionModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation


class QuestionModel: BaseModel {
    var identifier: String = ""
    public var page, id: Int?
    public var type: String?
    public var question: String?
    public var answers: [AnswerModel]?
    public var result: String?
    public var datasourceType: String?
    public var hasNote: Bool?
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
    
    public func updateAnswer(answers: [AnswerModel]) {
        self.answers = answers
    }
    
    public func getResult() -> String{
        return result ?? ""
    }
    
    public func getNote() -> Bool {
        return  hasNote ?? false
    }
    
    public func getDataSourceType() -> String {
        return datasourceType ?? ""
    }
    
    public func getIdentifier() -> String {
        return identifier
    }
    
    public func getType() -> String {
        return type ?? ""
    }
    
    public func getQuestion() -> String {
        return question ?? ""
    }
    
    func getAnswers() -> [AnswerModel] {
        return answers ?? []
    }
    
    init(id: Int, page: Int, type: String, question: String, datasourceType: String, answers:[AnswerModel], surveyType: String) {
        self.type = type
        self.question = question
        self.answers = answers
        self.datasourceType = datasourceType
        self.id = id
        self.page = page
        self.surveyType = surveyType
 
        switch type {
        case TypeQuestionEnum.EMAIL.typeValue():
            self.identifier = ""
            break
        case TypeQuestionEnum.FULL_NAME.typeValue():
            self.identifier = ""
            break
        case TypeQuestionEnum.PHONE.typeValue():
            self.identifier = ""
            break
        case TypeQuestionEnum.TEXT.typeValue():
            self.identifier = "TextCell"
            break
        case TypeQuestionEnum.TEXT_AREA.typeValue():
            self.identifier = "TitleCell"
            break
        case TypeQuestionEnum.SPINNER.typeValue():
            self.identifier = "SpinnerCell"
            break
        case TypeQuestionEnum.DATE.typeValue():
            self.identifier = "DateCell"
            break
        case TypeQuestionEnum.LEVEL.typeValue():
            self.identifier = "LevelCell"
            break
        case TypeQuestionEnum.RADIO.typeValue():
            self.identifier = "RadioCell"
            break
        case TypeQuestionEnum.CHECKBOX.typeValue():
            self.identifier = "CheckBoxCell"
            break
        default: break
            // dont anything
        }
    }
    
    init(question: String, answers: [AnswerModel]) {
        self.question = question
        self.answers = answers

    }
}
    
    
