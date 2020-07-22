//
//  services.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct services: Codable {
    let data: [servicesData]?
    let status: Bool?
    let error: String?
}

struct servicesData: Codable {
    let id: Int?
    let type, price, vendorName, title: String?
    let datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, type, price
        case vendorName = "vendor_name"
        case title
        case datumDescription = "description"
    }
}
