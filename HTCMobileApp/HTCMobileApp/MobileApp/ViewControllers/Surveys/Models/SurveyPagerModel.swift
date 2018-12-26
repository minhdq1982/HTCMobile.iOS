//
//  SurveyPagerModel.swift
//  HTCMobileApp
//
//  Created by admin on 11/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

struct SurveyPagerModel: BaseModel {
    public var identifier: String = "SurveyPagerCell"
    
    public var questions: Section
    
    init(_ questions: Section) {
        self.questions = questions
    }
    
    
}
