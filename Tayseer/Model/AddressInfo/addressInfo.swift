//
//  addressInfo.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct countries: Codable {
    let data: [countriesData]?
    let status: Bool?
    let error: String?
}


struct countriesData: Codable {
    let id: Int?
    let title: String?
}



struct cities: Codable {
    let data: [citiesData]?
    let status: Bool?
    let error: String?
}


struct citiesData: Codable {
    let id: Int?
    let title: String?
}



struct areas: Codable {
    let data: [areasData]?
    let status: Bool?
    let error: String?
}


struct areasData: Codable {
    let id: Int?
    let price, title: String?
}
