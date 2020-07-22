//
//  AdressList.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct adressList: Codable {
    let data: [adressListData]?
    let status: Bool?
    let error: String?
}

struct adressListData: Codable {
    let id: Int?
    let customerName, country, city, area: String?
    let address, numberHouse, numberFloor, numberFlat: String?
    let phone, notes, activate,areaPrice: String?

    enum CodingKeys: String, CodingKey {
        case id
        case areaPrice = "area_price"
        case customerName = "customer_name"
        case country, city, area, address
        case numberHouse = "number_house"
        case numberFloor = "number_floor"
        case numberFlat = "number_flat"
        case phone, notes, activate
    }
}
