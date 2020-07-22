//
//  orders.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation

struct orderList: Codable {
    let data: [orderListData]?
    let status: Bool?
    let error: String?
}


struct orderListData: Codable {
    let orderID: Int?
    let orderTotalPrice: String?
    let tax: Int?
    let deleveryFees, areaFees, orderStat, customerAddress: String?
    let customerCity, customerCountry, customerStreet, langtude: String?
    let lattude, paymentMethod, paymentStatus, customerPhone: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case orderID = "order_id"
        case orderTotalPrice = "order_total_price"
        case tax
        case deleveryFees = "delevery_fees"
        case areaFees = "area_fees"
        case orderStat = "order_stat"
        case customerAddress = "customer_address"
        case customerCity = "customer_city"
        case customerCountry = "customer_country"
        case customerStreet = "customer_street"
        case langtude, lattude
        case paymentMethod = "payment_method"
        case paymentStatus = "payment_status"
        case customerPhone = "customer_phone"
        case createdAt = "created_at"
    }
}


struct orderListProductDetails: Codable {
    let data: [orderListProductDetailsData]?
    let status: Bool?
    let error: String?
}


struct orderListProductDetailsData: Codable {
    let id: Int?
    let productName, productPrice, productQuantity, currency: String?

    enum CodingKeys: String, CodingKey {
        case id
        case productName = "product_name"
        case productPrice = "product_price"
        case productQuantity = "product_quantity"
        case currency
    }
}


struct OrderListServices: Codable {
    let data: [OrderListServicesData]?
    let status: Bool?
    let error: String?
}

struct OrderListServicesData: Codable {
    let id: Int?
    let sectionName, sectionDescription, totalServiceQuantity, currency: String?

    enum CodingKeys: String, CodingKey {
        case id
        case sectionName = "section_name"
        case sectionDescription = "section_description"
        case totalServiceQuantity = "total_service_quantity"
        case currency
    }
}
