//
//  Requests.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct listRequestEstablishment: Codable {
    let data: [listRequestEstablishmentData]?
    let status: Bool?
    let error: String?
}


struct listRequestEstablishmentData: Codable {
    let id: Int?
    
    let flatArea, roomNumber, floorNumber, customerNote: String?
    let dateTime, adminReplay, adminPrice, acceptances: String?

    enum CodingKeys: String, CodingKey {
        case id
        case flatArea = "flat_area"
        case roomNumber = "room_number"
        case floorNumber = "floor_number"
        case customerNote = "customer_note"
        case dateTime = "date_time"
        case adminReplay = "admin_replay"
        case adminPrice = "admin_price"
        case acceptances
    }
}


struct ListRequestEmergencies: Codable {
    let data: [ListRequestEmergenciesData]?
    let status: Bool?
    let error: String?
}


struct ListRequestEmergenciesData: Codable {
    let id: Int?
    let serviceName: [ServiceName]?
    let customerNote, dateTime, adminReplay, adminPrice: String?
    let acceptances: String?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceName = "service_name"
        case customerNote = "customer_note"
        case dateTime = "date_time"
        case adminReplay = "admin_replay"
        case adminPrice = "admin_price"
        case acceptances
    }
}

struct ServiceName: Codable {
    let name: String?
}
