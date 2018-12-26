//
//  SettingsModel.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 12/17/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation
import ObjectMapper

public struct SettingsModel: BaseModel {
    public var identifier: String = ""
    public let isSendSurveyCarNew: Bool?
    public let isSendSurveyCarMaintenace: Bool?
    public let surveyCarNewTime: Int?
    public let surveyCarMaintenaceTime: Int?
    public let surveyDeadLine: Int?
    public let facebookPageId: String?
    public let facebookAccessToken: String?
    public let youTubeChannelId: String?
    public let sync_Membership: Int?
    public let sync_Survey: Int?
    public let sync_News: Int?
    public let numberDayRemindToMaintenance: Int?
    public let hotline: String?
    public let hotline_Complain: String?
    public let email_Complain: String?
    public let sendSurveyViaSMS: Bool?
    public let sendSurveyViaInApp: Bool?
    public let sendRemindAppointmentViaSMS: Bool?
    public let sendRemindAppointmentViaInApp: Bool?
    public let sendPromotionViaSMS: Bool?
    public let sendPromotionViaInApp: Bool?
}

extension SettingsModel: ImmutableMappable {
    public init(map: Map) throws {
        self.isSendSurveyCarNew             = try? map.value("isSendSurveyCarNew")
        self.isSendSurveyCarMaintenace      = try? map.value("isSendSurveyCarMaintenace")
        self.surveyCarNewTime               = try? map.value("surveyCarNewTime")
        self.surveyCarMaintenaceTime        = try? map.value("surveyCarMaintenaceTime")
        self.surveyDeadLine                 = try? map.value("surveyDeadLine")
        self.facebookPageId                 = try? map.value("facebookPageId")
        self.facebookAccessToken            = try? map.value("facebookAccessToken")
        self.youTubeChannelId               = try? map.value("youTubeChannelId")
        self.sync_Membership                = try? map.value("sync_Membership")
        self.sync_Survey                    = try? map.value("sync_Survey")
        self.sync_News                      = try? map.value("sync_News")
        self.numberDayRemindToMaintenance   = try? map.value("numberDayRemindToMaintenance")
        self.hotline                        = try? map.value("hotline")
        self.hotline_Complain               = try? map.value("hotline_Complain")
        self.email_Complain                 = try? map.value("email_Complain")
        self.sendSurveyViaSMS               = try? map.value("sendSurveyViaSMS")
        self.sendSurveyViaInApp             = try? map.value("sendSurveyViaInApp")
        self.sendRemindAppointmentViaSMS    = try? map.value("sendRemindAppointmentViaSMS")
        self.sendRemindAppointmentViaInApp  = try? map.value("sendRemindAppointmentViaInApp")
        self.sendPromotionViaSMS            = try? map.value("sendPromotionViaSMS")
        self.sendPromotionViaInApp          = try? map.value("sendPromotionViaInApp")
    }
}
