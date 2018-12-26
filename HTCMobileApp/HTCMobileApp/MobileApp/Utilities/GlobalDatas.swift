//
//  GlobalDatas.swift
//  HTCMobileApp
//
//  Created by Tuan Pham Hai  on 10/30/18.
//  Copyright © 2018 Tinhvan Outsourcing JSC. All rights reserved.
//

import Foundation


class GlobalDatas: NSObject {
    static let shared: GlobalDatas = GlobalDatas()
    private override init() {}
    
    //  Car models
    func getCarModels() -> [String] {
        return [""]
    }
    
    func cities() -> [String] {
        let cities = ["Hà nội", "TP.Hồ Chí Minh", "Đà Nẵng", "Khánh Hoà", "Vinh", "Vĩnh Phúc", "Hà Nam", "Nam Định", "Thái Bình", "Thanh Hoá", "Ninh Bình", "Huế", "Lạng Sơn", "Hải Dương"]
        return cities
    }
    
    func branches() -> [String] {
        let branches = ["Hyundai Đông Anh", "Hyundai Long Biên", "Hyundai Hà Đông", "Hyundai Giải Phóng", "Hyundai Phạm Hùng", "Hyundai Cầu Diễn", "Hyundai Lê Văn Lương", "Hyundai Đông Đô", "Hyundai Phạm Văn Đồng"]
        return branches
    }
    
    
}
