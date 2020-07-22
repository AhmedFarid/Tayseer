//
//  coupone.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/28/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct couponeType: Codable {
    let data: couponeTypeData?
    let status: Bool?
    let error: String?
}


struct couponeTypeData: Codable {
    let couponeType, couponeValue: String?

    enum CodingKeys: String, CodingKey {
        case couponeType = "coupone_type"
        case couponeValue = "coupone_value"
    }
}
