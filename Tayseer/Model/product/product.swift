//
//  product.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation


struct Product: Codable {
    let data: [dataProduct]?
    let status: Bool?
    let error: String?
}


struct dataProduct: Codable {
    let id: Int?
    let type, price, vendorName, image: String?
    let title, shortDescription, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, type, price
        case vendorName = "vendor_name"
        case image, title
        case shortDescription = "short_description"
        case datumDescription = "description"
    }
}
