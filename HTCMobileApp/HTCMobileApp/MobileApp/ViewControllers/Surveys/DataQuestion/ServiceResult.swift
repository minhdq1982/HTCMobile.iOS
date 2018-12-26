//
//  ServiceResult.swift
//  HTCMobileApp
//
//  Created by admin on 12/4/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation

class ServiceResult {
    static let shared: ServiceResult = ServiceResult()
    
    func getResult(index: Int) -> [ResultModel] {
        // get Result
        var results: [ResultModel] = []
        switch index {
        case 0:
            results = ServiceResult.shared.firstPageResults
            break
        case 1:
            results = ServiceResult.shared.secondPageResults
            break
        case 2:
            results = ServiceResult.shared.thirdPageResults
            break
        case 3:
            results = ServiceResult.shared.fourthPageResults
            break
        case 4:
            results = ServiceResult.shared.fifthPageResults
            break
        case 5:
            results = ServiceResult.shared.sixthPageResults
            break
        case 6:
            results = ServiceResult.shared.seventhPageResults
            break
        case 7:
            results = ServiceResult.shared.eighthPageResults
            break
        case 8:
            results = ServiceResult.shared.ninethPageResults
            break
        case 9:
            results = ServiceResult.shared.tenthPageResults
            break
        default:
            break
        }
        return results
    }
    
    
    // first Page
    var firstPageResults: [ResultModel] = [ResultModel(id: 1, page: 0,question: "Vui lòng quý khách nhập tên xe đang sử dụng (*):", answers: "", surveyType: "service"),
                                           ResultModel(id: 2, page:0, question: "Lần bảo dưỡng/ sửa chữa gần đây nhất là khi nào? (*)", answers: "", surveyType: "service"),
                                               ResultModel(id: 3, page: 0,question: "Tên của đại lý đó? (*)", answers: "", surveyType: "service"),
                                               ResultModel(id: 4, page: 0,question: "Đại lý ở Tỉnh/Thành phố nào?", answers: "", surveyType: "service"),
                                               ResultModel(id: 5, page: 0,question: "Loại công việc đã thực hiện (*)", answers: "", surveyType: "service")]
    
    // second Page
    var secondPageResults: [ResultModel] = [ResultModel(id: 1, page: 1, question: "A1. Quý khách đánh giá như thế nào về mức độ hài lòng chung đối với Đại lý? (*):", answers: "", surveyType: "service"),
                                             ResultModel(id: 2, page: 1, question: "B1. Quý khách đánh giá về cơ sở vật chất của Đại lý (Hình ảnh, mức độ sạch sẽ ...) (*) :", answers: "", surveyType: "service"),
                                             ResultModel(id: 3, page: 1, question: "B2. Dễ dàng lái xe ra/ vào Xưởng dịch vụ:", answers: "", surveyType: "service"),
                                             ResultModel(id: 4, page: 1, question: "B3. Khu vực đỗ xe thuận tiện:", answers: "", surveyType: "service"),
                                             ResultModel(id: 5, page: 1, question: "B4. Mức độ sạch sẽ của Đại lý:", answers: "", surveyType: "service"),
                                             ResultModel(id: 6, page: 1, question: "B5. Sự tiện nghi của phòng chờ khách hàng:", answers: "", surveyType: "service")]
    // third Page
    var thirdPageResults: [ResultModel] = [ResultModel(id: 1, page: 2, question: "C1. Quý khách đánh giá như thế nào về Nhân viên dịch vụ? (*):", answers: "", surveyType: "service"),
                                             ResultModel(id: 2, page: 2, question: "C2. Xử lý các yêu cầu qua điện thoại (nếu có):", answers: "", surveyType: "service"),
                                             ResultModel(id: 3, page: 2, question: "C3. Mức độ lịch sự và trung thực:", answers: "", surveyType: "service"),
                                             ResultModel(id: 4, page: 2, question: "C4. Đáp ứng nhanh chóng các yêu cầu của Quý khách:", answers: "", surveyType: "service"),
                                             ResultModel(id: 5, page: 2, question: "C5. Lắng nghe và hiểu rõ các yêu cầu của Quý khách:", answers: "", surveyType: "service"),
                                             ResultModel(id: 6, page: 2, question: "C6. Giải thích rõ ràng & đầy đủ câu hỏi của Quý khách:", answers: "", surveyType: "service")]
    // fourth Page
    var fourthPageResults: [ResultModel] = [ResultModel(id: 1, page: 3, question: "D1. Quý khách đánh giá thế nào về mức độ giải quyết nhanh chóng các yêu cầu của Quý khách? (*):", answers: "", surveyType: "service"),
                                            ResultModel(id: 2, page: 3, question: "D2. Dễ dàng đặt lịch hẹn (nếu có):", answers: "", surveyType: "service"),
                                            ResultModel(id: 3, page: 3, question: "D3. Sắp xếp lịch hẹn thuận tiện với yêu cầu của Quý khách (nếu có):", answers: "", surveyType: "service"),
                                            ResultModel(id: 4, page: 3, question: "D4. Tiếp nhận xe nhanh chóng:", answers: "", surveyType: "service"),
                                            ResultModel(id: 5, page: 3, question: "D5. Giao xe nhanh chóng:", answers: "", surveyType: "service"),
                                            ResultModel(id: 6, page: 3, question: "D6. Tổng thời gian cần thiết để hoàn thành chiếc xe của Quý khách:", answers: "", surveyType: "service")]
    // fifth Page
    var fifthPageResults: [ResultModel] = [ResultModel(id: 1, page: 4, question: "E1. Quý khách đánh giá như thế nào về chất lượng của các công việc được thực hiện? (*):", answers: "", surveyType: "service"),
                                             ResultModel(id: 2, page: 4, question: "E2. Giải thích các công việc sẽ thực hiện:", answers: "", surveyType: "service"),
                                             ResultModel(id: 3, page: 4, question: "E3. Mức độ hoàn thành việc BD/SC:", answers: "", surveyType: "service"),
                                             ResultModel(id: 4, page: 4, question: "E4. Sự sạch sẽ của chiếc xe sau khi BD/SC:", answers: "", surveyType: "service"),
                                             ResultModel(id: 5, page: 4, question: "E5. Giải thích lại các hạng mục công việc đã thực hiện:", answers: "", surveyType: "service")]
    
    // sixth page
    var sixthPageResults: [ResultModel] = [ResultModel(id: 1, page: 5, question: "F1. Quý khách đánh giá như thế nào về chi phí dịch vụ? (*):", answers: "", surveyType: "service"),
                                           ResultModel(id: 2, page: 5, question: "F2. Giải thích về các chi phí liên quan trước khi BD/SC:", answers: "", surveyType: "service"),
                                           ResultModel(id: 3, page: 5, question: "F3. Tính hợp lý của các chi phí:", answers: "", surveyType: "service"),
                                           ResultModel(id: 4, page: 5, question: "F4. Sự hợp lý về giá cả của các phụ tùng:", answers: "", surveyType: "service"),
                                           ResultModel(id: 5, page: 5, question: "F5. Giải thích lại các chi phí dịch vụ khi giao xe:", answers: "", surveyType: "service")]
    
    // seventh page
    var seventhPageResults: [ResultModel] = [ResultModel(id: 0, page: 6, question: "G1. Khi đến Đại lý, Quý khách mất bao lâu để được đón tiếp?", answers: "", surveyType: "service"),
                                           ResultModel(id: 1, page: 6, question: "H1. Nếu có công việc phát sinh, Quý khách có được thông báo trước?", answers: "", surveyType: "service"),
                                           ResultModel(id: 2, page: 6, question: "I1. Quý khách có nhận được xe đúng theo thời gian cam kết ban đầu không?", answers: "", surveyType: "service"),
                                           ResultModel(id: 3, page: 6, question: "I2. Quý khách có nhận được thông báo trước về việc chậm trễ?", answers: "", surveyType: "service")]
    // eighth page
    var eighthPageResults: [ResultModel] = [ResultModel(id: 0, page: 7, question: "J1. Xe của Quý khách có phải quay lại Đại lý để kiểm tra và sửa chữa lại không?", answers: "", surveyType: "service"),
                                             ResultModel(id: 1, page: 7, question: "J2. Lý do Quý khách mang xe trở lại đại lý? (Chọn câu trả lời dưới đây)", answers: "", surveyType: "service")]
    
    // nineth page
    var ninethPageResults: [ResultModel] = [ResultModel(id: 1, page: 8, question: "K1. Sau khi BD/SC, Quý khách có được liên hệ và hỏi thăm không?", answers: "", surveyType: "service"),
                                             ResultModel(id: 2, page: 8, question: "L1. Quý khách có dự định giới thiệu Đại lý với bạn bè và người thân? (*)", answers: "", surveyType: "service"),
                                             ResultModel(id: 3, page: 8, question: "M1. Quý khách có dự định trở lại Đại lý để làm BD/SC cho các lần sau?", answers: "", surveyType: "service"),
                                             ResultModel(id: 4, page: 8, question: "Vui lòng chia sẻ thêm ý kiến cho lần Bảo dưỡng/ sửa chữa gần đây nhất của Quý khách tại đại lý (nếu có)?", answers: "", surveyType: "service"),
                                              ResultModel(id: 5, page: 8, question: "Tôi cho phép chia sẻ những câu trả lời của tôi với Đại lý nơi tôi làm dịch vụ:", answers: "", surveyType: "service")]
    
    // tenth page
    var tenthPageResults: [ResultModel] = [ResultModel(id: 1, page: 9, question: "Vui lòng cho biết Họ tên của Quý khách (*)", answers: "", surveyType: "service"),
                                            ResultModel(id: 2, page: 9, question: "Địa chỉ hiện tại của Quý khách (*):", answers: "", surveyType: "service"),
                                            ResultModel(id: 3, page: 9, question: "Địa chỉ Email của Quý Khách (*):", answers: "", surveyType: "service"),
                                            ResultModel(id: 4, page: 9, question: "Số điện thoại di động/cố định của Quý khách (*):", answers: "", surveyType: "service"),
                                            ResultModel(id: 5, page: 9, question: "Biển kiểm soát của chiếc xe làm dịch vụ (*):", answers: "", surveyType: "service")]



    // first page
    public func addAnswerFirstPage(result: ResultModel) {
        for i in 0..<firstPageResults.count {
            print("Bang bang")
            var item = firstPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                firstPageResults[i] = item
                break
            }
        }
        print(firstPageResults)
    }
    
    func resetFirstPageData() {
        for i in 0..<firstPageResults.count {
            var item = firstPageResults[i]
            item.updateAnswer(answers: "")
            firstPageResults[i] = item
        }
    }

    
    // second page
    public func addAnswerSecondPage(result: ResultModel) {
        
        print("ID: \(result.getId())")
        
        for i in 0..<secondPageResults.count {
            print("Bang bang")
            var item = secondPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                secondPageResults[i] = item
                break
            }
        }
        print(secondPageResults)
    }
    func resetSecondPageData() {
        for i in 0..<secondPageResults.count {
            var item = secondPageResults[i]
            item.updateAnswer(answers: "")
            secondPageResults[i] = item
        }
    }
    
    // third page
    public func addAnswerThirdPage(result: ResultModel) {
        for i in 0..<thirdPageResults.count {
            var item = thirdPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                thirdPageResults[i] = item
                break
            }
        }
        print(thirdPageResults)
    }
    func resetThirdPageData() {
        for i in 0..<thirdPageResults.count {
            var item = thirdPageResults[i]
            item.updateAnswer(answers: "")
            thirdPageResults[i] = item
        }
    }
    // fourth page
    public func addAnswerFourthPage(result: ResultModel) {
        for i in 0..<fourthPageResults.count {
            var item = fourthPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                fourthPageResults[i] = item
                break
            }
        }
        print(fourthPageResults)
    }
    
    func resetFourthPageData() {
        for i in 0..<fourthPageResults.count {
            var item = fourthPageResults[i]
            item.updateAnswer(answers: "")
            fourthPageResults[i] = item
        }
    }
    
    // fifth page
    public func addAnswerFifthPage(result: ResultModel) {
        for i in 0..<fifthPageResults.count {
            var item = fifthPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                fifthPageResults[i] = item
                break
            }
        }
        print(fifthPageResults)
    }
    
    func resetFifthPageData() {
        for i in 0..<fifthPageResults.count {
            var item = fifthPageResults[i]
            item.updateAnswer(answers: "")
            fifthPageResults[i] = item
        }
    }
    // sixth page
    public func addAnswerSixthPage(result: ResultModel) {
        for i in 0..<sixthPageResults.count {
            var item = sixthPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                sixthPageResults[i] = item
                break
            }
        }
        print(sixthPageResults)
    }
    
    func resetSixthPageData() {
        for i in 0..<sixthPageResults.count {
            var item = sixthPageResults[i]
            item.updateAnswer(answers: "")
            sixthPageResults[i] = item
        }
    }
    // seventh page
    public func addAnswerSeventhPage(result: ResultModel) {
        for i in 0..<seventhPageResults.count {
            var item = seventhPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                seventhPageResults[i] = item
                break
            }
        }
        print(seventhPageResults)
    }
    func resetSeventhPageData() {
        for i in 0..<seventhPageResults.count {
            var item = seventhPageResults[i]
            item.updateAnswer(answers: "")
            seventhPageResults[i] = item
        }
    }
    // eighth page
    public func addAnswerEighthPage(result: ResultModel) {
        for i in 0..<eighthPageResults.count {
            var item = eighthPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                eighthPageResults[i] = item
                break
            }
        }
        print(eighthPageResults)
    }
    func resetEighthPageData() {
        for i in 0..<eighthPageResults.count {
            var item = eighthPageResults[i]
            item.updateAnswer(answers: "")
            eighthPageResults[i] = item
        }
    }
    // nineth page
    public func addAnswerNinethPage(result: ResultModel) {
        for i in 0..<ninethPageResults.count {
            var item = ninethPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                ninethPageResults[i] = item
                break
            }
        }
        print(ninethPageResults)
    }
    func resetNinethPageData() {
        for i in 0..<ninethPageResults.count {
            var item = ninethPageResults[i]
            item.updateAnswer(answers: "")
            ninethPageResults[i] = item
        }
    }
    // tenth page
    public func addAnswerTenthPage(result: ResultModel) {
        for i in 0..<tenthPageResults.count {
            var item = tenthPageResults[i]
            if item.getId() == result.getId() {
                item.updateAnswer(answers: result.getAnswer())
                tenthPageResults[i] = item
                break
            }
        }
        print(tenthPageResults)
    }
    func resetTenthPageData() {
        for i in 0..<tenthPageResults.count {
            var item = tenthPageResults[i]
            item.updateAnswer(answers: "")
            tenthPageResults[i] = item
        }
    }
    
   
    func resetAllResults() {
       self.resetFirstPageData()
       self.resetSecondPageData()
        self.resetThirdPageData()
        self.resetFourthPageData()
        self.resetFifthPageData()
        self.resetSixthPageData()
        self.resetSeventhPageData()
        self.resetEighthPageData()
        self.resetNinethPageData()
        self.resetTenthPageData()
    }
    
    // check page answer
    func checkPageAnswer(page: Int) -> Bool {
        let results: [ResultModel] = getResult(index: page)
        // check Item
        for item in results {
            if item.getQuestion().contains("*") == true {
                if item.getAnswer() == "" {
                    print("còn trống")
                    return true
                }
            }
        }
        return false
    }
    

}
