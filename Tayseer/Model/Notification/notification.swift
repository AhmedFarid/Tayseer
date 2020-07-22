//
//  notification.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import Foundation


struct allNotificaitons: Codable {
    let data: [notificationData]?
    let status: Bool?
    let error: String?
}


struct notificationData: Codable {
    let id: Int?
    let name, datumDescription: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case datumDescription = "description"
    }
}
