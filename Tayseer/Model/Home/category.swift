//
//  category.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct sections: Codable {
    let data: [sectionsData]?
    let status: Bool?
    let error: String?
}


struct sectionsData: Codable {
    let id: Int?
    let typeSection, haveProduct, haveMaintenance, haveEmergency: String?
    let image, title, shortDescription, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case typeSection = "type_section"
        case haveProduct = "have_product"
        case haveMaintenance = "have_maintenance"
        case haveEmergency = "have_emergency"
        case image, title
        case shortDescription = "short_description"
        case datumDescription = "description"
    }
}
