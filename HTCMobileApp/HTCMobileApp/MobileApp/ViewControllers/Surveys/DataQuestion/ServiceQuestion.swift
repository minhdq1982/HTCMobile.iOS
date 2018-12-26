//
//  SurveyQuestion.swift
//  HTCMobileApp
//
//  Created by admin on 12/3/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

class ServiceQuestion {
    static let shared: ServiceQuestion = ServiceQuestion()
    
    var indexPage: Int = 0
    
    // first page
    
    var firstPageData: [QuestionModel] = [QuestionModel(id: 0,
                                                        page: 0,
                                                        type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                                        question: "",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 1,
                                                        page: 0,
                                                        type: TypeQuestionEnum.SPINNER.typeValue(),
                                                        question: "Vui lòng quý khách nhập tên xe đang sử dụng (*):",
                                                        datasourceType: "car",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 2,
                                                        page: 0,
                                                        type: TypeQuestionEnum.DATE.typeValue(),
                                                        question: "Lần bảo dưỡng/ sửa chữa gần đây nhất là khi nào? (*)",
                                                        datasourceType: "date",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 3,
                                                        page: 0,
                                                        type: TypeQuestionEnum.SPINNER.typeValue(),
                                                        question: "Tên của đại lý đó? (*)",
                                                        datasourceType: "brand",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 4,
                                                        page: 0,
                                                        type: TypeQuestionEnum.TEXT.typeValue(),
                                                        question: "Đại lý ở Tỉnh/Thành phố nào?",
                                                        datasourceType: "location",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 5,
                                                        page: 0,
                                                        type: TypeQuestionEnum.SPINNER.typeValue(),
                                                        question: "Loại công việc đã thực hiện (*)",
                                                        datasourceType: "work",
                                                        answers: [],
                                                        surveyType: "service")]
    
    
//    var firstPageData:  [QuestionModel] = [QuestionModel(type: TypeQuestionEnum.TEXT_AREA.typeValue(),
//                                                         question: "",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.SPINNER.typeValue(),
//                                                         question: "Vui lòng quý khách nhập tên xe đang sử dụng (*):",
//                                                         datasourceType: "car",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.SPINNER.typeValue(),
//                                                         question: "Lần bảo dưỡng/ sửa chữa gần đây nhất là khi nào?",
//                                                         datasourceType: "date",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.SPINNER.typeValue(),
//                                                         question: "Tên của đại lý đó?",
//                                                         datasourceType: "brand",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.SPINNER.typeValue(),
//                                                         question: "Đại lý ở Tỉnh/Thành phố nào?",
//                                                         datasourceType: "location",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.SPINNER.typeValue(),
//                                                         question: "Loại công việc đã thực hiện",
//                                                         datasourceType: "work",
//                                                         answers: [])]

    var secondPageData = [QuestionModel(id: 0,
                                        page: 1,
                                        type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                        question: "point",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 1,
                                        page: 1,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "A1. Quý khách đánh giá như thế nào về mức độ hài lòng chung đối với Đại lý? (*):",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 2,
                                        page: 1,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "B1. Quý khách đánh giá về cơ sở vật chất của Đại lý (Hình ảnh, mức độ sạch sẽ ...) (*):",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 3,
                                        page: 1,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "B2. Dễ dàng lái xe ra/ vào Xưởng dịch vụ:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 4,
                                        page: 1,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "B3. Khu vực đỗ xe thuận tiện:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 5,
                                        page: 1,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "B4. Mức độ sạch sẽ của Đại lý:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 6,
                                        page: 1,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "B5. Sự tiện nghi của phòng chờ khách hàng:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service")]
    
    
//        // second
//    var secondPageData:  [QuestionModel] =  [QuestionModel(type: TypeQuestionEnum.TEXT_AREA.typeValue(),
//                                                           question: "point",
//                                                           datasourceType: "",
//                                                           answers: []),
//                                             QuestionModel(
//                                                type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                question: "A1. Quý khách đánh giá như thế nào về mức độ hài lòng chung đối với Đại lý? (*):",
//                                                datasourceType: "",
//                                                answers: []),
//                                             QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                           question: "B1. Quý khách đánh giá về cơ sở vật chất của Đại lý (Hình ảnh, mức độ sạch sẽ ...) (*):",
//                                                           datasourceType: "",
//                                                           answers: []),
//                                             QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                           question: "B2. Dễ dàng lái xe ra/ vào Xưởng dịch vụ:",
//                                                           datasourceType: "",
//                                                           answers: []),
//                                             QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                           question: "B3. Khu vực đỗ xe thuận tiện:",
//                                                           datasourceType: "",
//                                                           answers: []),
//                                             QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                           question: "B4. Mức độ sạch sẽ của Đại lý:",
//                                                           datasourceType: "",
//                                                           answers: []),
//                                             QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                           question: "B5. Sự tiện nghi của phòng chờ khách hàng:",
//                                                           datasourceType: "",
//                                                           answers: [])]

    
    //third page
    
    var thirdPageData = [QuestionModel(id: 0,
                                        page: 2,
                                        type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                        question: "point",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 1,
                                        page: 2,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "C1. Quý khách đánh giá như thế nào về Nhân viên dịch vụ? (*):",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 2,
                                        page: 2,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "C2. Xử lý các yêu cầu qua điện thoại (nếu có):",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 3,
                                        page: 2,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "C3. Mức độ lịch sự và trung thực:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 4,
                                        page: 2,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "C4. Đáp ứng nhanh chóng các yêu cầu của Quý khách:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 5,
                                        page: 2,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "C5. Lắng nghe và hiểu rõ các yêu cầu của Quý khách:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 6,
                                        page: 2,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "C6. Giải thích rõ ràng & đầy đủ câu hỏi của Quý khách:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service")]
  
    
//    // third page
//    var thirdPageData: [QuestionModel] =  [QuestionModel(type: TypeQuestionEnum.TEXT_AREA.typeValue(),
//                                                         question: "point",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "C1. Quý khách đánh giá như thế nào về Nhân viên dịch vụ? (*):",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "C2. Xử lý các yêu cầu qua điện thoại (nếu có):",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "C3. Mức độ lịch sự và trung thực:",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "C4. Đáp ứng nhanh chóng các yêu cầu của Quý khách:",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "C5. Lắng nghe và hiểu rõ các yêu cầu của Quý khách:",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "C6. Giải thích rõ ràng & đầy đủ câu hỏi của Quý khách:",
//                                                         datasourceType: "",
//                                                         answers: [])]

    
    // fourth page
    var fourthPageData = [QuestionModel(id: 0,
                                       page: 3,
                                       type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                       question: "point",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 1,
                                       page: 3,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "D1. Quý khách đánh giá thế nào về mức độ giải quyết nhanh chóng các yêu cầu của Quý khách? (*)",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 2,
                                       page: 3,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "D2. Dễ dàng đặt lịch hẹn (nếu có):",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 3,
                                       page: 3,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "D3. Sắp xếp lịch hẹn thuận tiện với yêu cầu của Quý khách (nếu có):",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 4,
                                       page: 3,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "D4. Tiếp nhận xe nhanh chóng:",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 5,
                                       page: 3,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "D5. Giao xe nhanh chóng:",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 6,
                                       page: 3,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "D6. Tổng thời gian cần thiết để hoàn thành chiếc xe của Quý khách:",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service")]


    
//    // fourth page
//    var fourthPageData:  [QuestionModel] = [QuestionModel(type: TypeQuestionEnum.TEXT_AREA.typeValue(),
//                                                          question: "point",
//                                                          datasourceType: "",
//                                                          answers: []),
//                                            QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                          question: "D1. Quý khách đánh giá thế nào về mức độ giải quyết nhanh chóng các yêu cầu của Quý khách? (*):",
//                                                          datasourceType: "",
//                                                          answers: []),
//                                            QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                          question: "D2. Dễ dàng đặt lịch hẹn (nếu có):",
//                                                          datasourceType: "",
//                                                          answers: []),
//                                            QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                          question: "D3. Sắp xếp lịch hẹn thuận tiện với yêu cầu của Quý khách (nếu có):",
//                                                          datasourceType: "",
//                                                          answers: []),
//                                            QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                          question: "D4. Tiếp nhận xe nhanh chóng:",
//                                                          datasourceType: "",
//                                                          answers: []),
//                                            QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                          question: "D5. Giao xe nhanh chóng:",
//                                                          datasourceType: "",
//                                                          answers: []),
//                                            QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                          question: "D6. Tổng thời gian cần thiết để hoàn thành chiếc xe của Quý khách:",
//                                                          datasourceType: "",
//                                                          answers: [])]

    // fifth page
    var fifthPageData = [QuestionModel(id: 0,
                                        page: 4,
                                        type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                        question: "point",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 1,
                                        page: 4,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "E1. Quý khách đánh giá như thế nào về chất lượng của các công việc được thực hiện? (*):",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 2,
                                        page: 4,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "E2. Giải thích các công việc sẽ thực hiện:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 3,
                                        page: 4,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "E3. Mức độ hoàn thành việc BD/SC:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 4,
                                        page: 4,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "E4. Sự sạch sẽ của chiếc xe sau khi BD/SC:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service"),
                          QuestionModel(id: 5,
                                        page: 4,
                                        type: TypeQuestionEnum.LEVEL.typeValue(),
                                        question: "E5. Giải thích lại các hạng mục công việc đã thực hiện:",
                                        datasourceType: "",
                                        answers: [],
                                        surveyType: "service")]
    
//    var fifthPageData: [QuestionModel] =  [QuestionModel(type: TypeQuestionEnum.TEXT_AREA.typeValue(),
//                                                         question: "point",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "E1. Quý khách đánh giá như thế nào về chất lượng của các công việc được thực hiện? (*):",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "E2. Giải thích các công việc sẽ thực hiện:",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "E3. Mức độ hoàn thành việc BD/SC:",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "E4. Sự sạch sẽ của chiếc xe sau khi BD/SC:",
//                                                         datasourceType: "",
//                                                         answers: []),
//                                           QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                         question: "E5. Giải thích lại các hạng mục công việc đã thực hiện:",
//                                                         datasourceType: "",
//                                                         answers: [])]
    // sixth page
    var sixthPageData = [QuestionModel(id: 0,
                                       page: 5,
                                       type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                       question: "point",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 1,
                                       page: 5,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "F1. Quý khách đánh giá như thế nào về chi phí dịch vụ? (*):",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 2,
                                       page: 5,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "F2. Giải thích về các chi phí liên quan trước khi BD/SC",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 3,
                                       page: 5,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "F3. Tính hợp lý của các chi phí:",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 4,
                                       page: 5,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "F4. Sự hợp lý về giá cả của các phụ tùng:",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service"),
                         QuestionModel(id: 5,
                                       page: 5,
                                       type: TypeQuestionEnum.LEVEL.typeValue(),
                                       question: "F5. Giải thích lại các chi phí dịch vụ khi giao xe:",
                                       datasourceType: "",
                                       answers: [],
                                       surveyType: "service")]
    

        

//    // sixth page
//
//    var sixthPageData: [QuestionModel] = [QuestionModel(type: TypeQuestionEnum.TEXT_AREA.typeValue(),
//                                                        question: "point",
//                                                        datasourceType: "",
//                                                        answers: []),
//                                          QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                        question: "F1. Quý khách đánh giá như thế nào về chi phí dịch vụ? (*):",
//                                                        datasourceType: "",
//                                                        answers: []),
//                                          QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                        question: "F2. Giải thích về các chi phí liên quan trước khi BD/SC:",
//                                                        datasourceType: "",
//                                                        answers: []),
//                                          QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                        question: "F3. Tính hợp lý của các chi phí:",
//                                                        datasourceType: "",
//                                                        answers: []),
//                                          QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                        question: "F4. Sự hợp lý về giá cả của các phụ tùng:",
//                                                        datasourceType: "",
//                                                        answers: []),
//                                          QuestionModel(type: TypeQuestionEnum.LEVEL.typeValue(),
//                                                        question: "F5. Giải thích lại các chi phí dịch vụ khi giao xe:",
//                                                        datasourceType: "",
//                                                        answers: [])]


    
    // seventh page
    
        
    var seventhPageData: [QuestionModel] = [QuestionModel(id: 0,
                                                          page: 6,
                                                          type: TypeQuestionEnum.SPINNER.typeValue(),
                                                          question: "G1. Khi đến Đại lý, Quý khách mất bao lâu để được đón tiếp?",
                                                         datasourceType: "select_time",
                                                         answers: [],
                                                         surveyType: "service"),
                                            QuestionModel(id: 1,
                                                          page: 6,
                                                         type: TypeQuestionEnum.RADIO.typeValue(),
                                                         question: "H1. Nếu có công việc phát sinh, Quý khách có được thông báo trước?",
                                                         datasourceType: "",
                                                         answers: [AnswerModel("Có", TypeQuestionEnum.RADIO.typeValue()), AnswerModel("Không", TypeQuestionEnum.RADIO.typeValue()),
                                                             AnswerModel("Không có công việc nào phát sinh", TypeQuestionEnum.RADIO.typeValue())],
                                                         surveyType: "service"),
                                            QuestionModel(id: 2,
                                                          page: 6,
                                                          type: TypeQuestionEnum.RADIO.typeValue(),
                                                          question: "I1. Quý khách có nhận được xe đúng theo thời gian cam kết ban đầu không?:",
                                                          datasourceType: "",
                                                          answers: [AnswerModel("Có", TypeQuestionEnum.RADIO.typeValue()), AnswerModel("Không", TypeQuestionEnum.RADIO.typeValue()),
                                                              AnswerModel("Đại lý không cam kết thời gian hoàn thành", TypeQuestionEnum.RADIO.typeValue())],
                                                          surveyType: "service"),
                                            QuestionModel(id: 3,
                                                          page: 6,
                                                          type: TypeQuestionEnum.RADIO.typeValue(),
                                                          question: "I2. Quý khách có nhận được thông báo trước về việc chậm trễ?",
                                                          datasourceType: "",
                                                          answers: [AnswerModel("Có", TypeQuestionEnum.RADIO.typeValue()),
                                                                   AnswerModel("Không", TypeQuestionEnum.RADIO.typeValue())],
                                                          surveyType: "service")]


    // eighth page
    var eighthPageData: [QuestionModel] = [QuestionModel(id : 0,
                                                         page: 7,
                                                         type: TypeQuestionEnum.RADIO.typeValue(),
                                                         question: "J1. Xe của Quý khách có phải quay lại Đại lý để kiểm tra và sửa chữa lại không?",
                                                         datasourceType: "",
                                                         answers: [AnswerModel("Có", TypeQuestionEnum.RADIO.typeValue()), AnswerModel("Không", TypeQuestionEnum.RADIO.typeValue())],
                                                         surveyType: "service"),
                                           QuestionModel(id: 1,
                                                         page: 7,
                                                         type: TypeQuestionEnum.CHECKBOX.typeValue(),
                                                         question: "J2. Lý do Quý khách mang xe trở lại đại lý? (Chọn câu trả lời dưới đây)",
                                                         datasourceType: "",
                                                         answers: [AnswerModel("Không đủ thời gian để sửa/ Lịch sửa chữa quá dầy", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("Phụ tùng không có sẵn", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("Phụ tùng có nhưng bị lỗi", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("Xưởng dịch vụ không tìm ra nguyên nhân trong lần sửa chữa trước", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("Xưởng dịch vụ cố gắng nhưng không tìm ra nguyên nhân trong lần sửa chữa trước", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("Lỗi lặp lại sau khi sửa chữa lần trước", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("Sửa đúng lần trước nhưng có một vài phát sinh thêm", TypeQuestionEnum.CHECKBOX.typeValue()),
                                                                   AnswerModel("", TypeQuestionEnum.CHECKBOX.typeValue())],
                                                         surveyType: "service")]

    // nineth page
    var ninethPageData: [QuestionModel] =  [QuestionModel(id: 0,
                                                          page: 8,
                                                          type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                                          question: "",
                                                          datasourceType: "",
                                                          answers: [],
                                                          surveyType: "service"),
                                            QuestionModel(id: 1,
                                                          page: 8,
                                                          type: TypeQuestionEnum.RADIO.typeValue(),
                                                          question: "K1. Sau khi BD/SC, Quý khách có được liên hệ và hỏi thăm không?",
                                                          datasourceType: "",
                                                          answers: [AnswerModel("Có", TypeQuestionEnum.RADIO.typeValue()), AnswerModel("Không", TypeQuestionEnum.RADIO.typeValue())],
                                                          surveyType: "service"),
                                            QuestionModel(id: 2,
                                                          page: 8,
                                                          type: TypeQuestionEnum.SPINNER.typeValue(),
                                                          question: "L1. Quý khách có dự định giới thiệu Đại lý với bạn bè và người thân? (*)",
                                                          datasourceType: "yes/no",
                                                          answers: [],
                                                          surveyType: "service"),
                                            QuestionModel(id: 3,
                                                          page: 8,
                                                          type: TypeQuestionEnum.SPINNER.typeValue(),
                                                          question: "M1. Quý khách có dự định trở lại Đại lý để làm BD/SC cho các lần sau?",
                                                          datasourceType: "yes/no",
                                                          answers: [],
                                                          surveyType: "service"),
                                            QuestionModel(id: 4,
                                                          page: 8,
                                                          type: TypeQuestionEnum.TEXT.typeValue(),
                                                          question: "Vui lòng chia sẻ thêm ý kiến cho lần Bảo dưỡng/ sửa chữa gần đây nhất của Quý khách tại đại lý (nếu có):",
                                                          datasourceType: "yes/no",
                                                          answers: [],
                                                          surveyType: "service"),
                                            QuestionModel(id: 5,
                                                          page: 8,
                                                          type: TypeQuestionEnum.RADIO.typeValue(),
                                                          question: "Tôi cho phép chia sẻ những câu trả lời của tôi với Đại lý nơi tôi làm dịch vụ:",
                                                          datasourceType: "",
                                                          answers: [AnswerModel("Có", TypeQuestionEnum.RADIO.typeValue()), AnswerModel("Không", TypeQuestionEnum.RADIO.typeValue())],
                                                          surveyType: "service")]

    
    // tenth page
    var tenthPageData: [QuestionModel] = [QuestionModel(id: 0,
                                                        page: 9,
                                                        type: TypeQuestionEnum.TEXT_AREA.typeValue(),
                                                        question: "",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 1,
                                                        page: 9,
                                                        type: TypeQuestionEnum.TEXT.typeValue(),
                                                        question: "Vui lòng cho biết Họ tên của Quý khách (*)",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 2,
                                                        page: 9,
                                                        type: TypeQuestionEnum.TEXT.typeValue(),
                                                        question: "Địa chỉ hiện tại của Quý khách (*):",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 3,
                                                        page: 9,
                                                        type: TypeQuestionEnum.TEXT.typeValue(),
                                                        question: "Địa chỉ Email của Quý Khách (*):",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 4,
                                                        page: 9,
                                                        type: TypeQuestionEnum.TEXT.typeValue(),
                                                        question: "Số điện thoại di động/cố định của Quý khách (*):",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service"),
                                          QuestionModel(id: 5,
                                                        page: 9,
                                                        type: TypeQuestionEnum.TEXT.typeValue(),
                                                        question: "Biển kiểm soát của chiếc xe làm dịch vụ (*):",
                                                        datasourceType: "",
                                                        answers: [],
                                                        surveyType: "service")]


    // first page
    public func addAnswerFirstPage(result: ResultModel) {
        for i in 0..<firstPageData.count {
            print("Bang bang")
            let item = firstPageData[i]
            if item.getQuestion() == result.getQuestion() {
                item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                firstPageData[i] = item
                break
            }
        }
    }
    // second page
    public func addAnswerSecondPage(result: ResultModel) {
        for i in 0..<secondPageData.count {
            print("Bang bang")
            let item = secondPageData[i]
            print(item.getType())
            if item.getQuestion() == result.getQuestion() {
                  item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                secondPageData[i] = item
                break
            }
        }
        print(fifthPageData)
    }
    // third page
    public func addAnswerThirdPage(result: ResultModel) {
        for i in 0..<thirdPageData.count {
            let item = thirdPageData[i]
            if item.getQuestion() == result.getQuestion() {
                  item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                thirdPageData[i] = item
                break
            }
        }
    }
    // fourth page
    public func addAnswerFourthPage(result: ResultModel) {
        for i in 0..<fourthPageData.count {
            let item = fourthPageData[i]
            if item.getQuestion() == result.getQuestion() {
                  item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                fourthPageData[i] = item
                break
            }
        }
    }
    // fifth page
    public func addAnswerFifthPage(result: ResultModel) {
        for i in 0..<fifthPageData.count {
            let item = fifthPageData[i]
            if item.getQuestion() == result.getQuestion() {
                 item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                fifthPageData[i] = item
                break
            }
        }
    }
    // sixth page
    public func addAnswerSixthPage(result: ResultModel) {
        for i in 0..<sixthPageData.count {
            let item = sixthPageData[i]
            if item.getQuestion() == result.getQuestion() {
                item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                sixthPageData[i] = item
                break
            }
        }
    }
    // seventh page
    public func addAnswerSeventhPage(result: ResultModel) {
        for i in 0..<seventhPageData.count {
            let item = seventhPageData[i]
            if item.getQuestion() == result.getQuestion() {
                item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                seventhPageData[i] = item
                break
            }
        }
    }
    // eighth page
    public func addAnswerEighthPage(result: ResultModel) {
        for i in 0..<eighthPageData.count {
            let item = eighthPageData[i]
            if item.getQuestion() == result.getQuestion() {
                item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                eighthPageData[i] = item
                break
            }
        }
    }
    // nineth page
    public func addAnswerNinethPage(result: ResultModel) {
        for i in 0..<ninethPageData.count {
            let item = ninethPageData[i]
            if item.getQuestion() == result.getQuestion() {
                item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                ninethPageData[i] = item
                break
            }
        }
    }
    // tenth page
    public func addAnswerTenthPage(result: ResultModel) {
        for i in 0..<tenthPageData.count {
            let item = tenthPageData[i]
            if item.getQuestion() == result.getQuestion() {
                item.updateAnswer(answers: [AnswerModel(result.getAnswer(), item.getType())])
                tenthPageData[i] = item
                break
            }
        }
    }

}
