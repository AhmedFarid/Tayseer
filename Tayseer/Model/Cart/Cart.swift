//
//  Cart.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation


struct CartServices: Codable {
    let data: CartServicesData?
    let status: Bool?
    let error: String?
}


struct CartServicesData: Codable {
    let list: [CartServicesList]?
    let countServices: Int?
    let totalServices, currency: String?

    enum CodingKeys: String, CodingKey {
        case list
        case countServices = "count_services"
        case totalServices = "total_services"
        case currency
    }
}

struct CartServicesList: Codable {
    let cartServiceID: Int?
    let sectionID, name, shortDescription, listDescription: String?
    let totalServiceQuantity, currency: String?

    enum CodingKeys: String, CodingKey {
        case cartServiceID = "cart_service_id"
        case sectionID = "section_id"
        case name
        case shortDescription = "short_description"
        case listDescription = "description"
        case totalServiceQuantity = "total_service_quantity"
        case currency
    }
}




struct CartServicesDitals: Codable {
    let data: cartServicesDitalsData?
    let status: Bool?
    let error: String?
}


struct cartServicesDitalsData: Codable {
    let list: [cartServicesDitalsList]?
    let countServices: Int?
    let totalServices, currency: String?

    enum CodingKeys: String, CodingKey {
        case list
        case countServices = "count_services"
        case totalServices = "total_services"
        case currency
    }
}


struct cartServicesDitalsList: Codable {
    let cartID: Int?
    let name, quantity, price, totalPriceQuantity: String?
    let currency: String?

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case name, quantity, price
        case totalPriceQuantity = "total_price_quantity"
        case currency
    }
}



import Foundation


struct ProductCart: Codable {
    let data: dataProductCart?
    let status: Bool?
    let error: String?
}

struct dataProductCart: Codable {
    let list: [productCartList]?
    let totalTax: Int?
    let totalDeleveryFees: String?
    let price: Int?

    enum CodingKeys: String, CodingKey {
        case list
        case totalTax = "total_tax"
        case totalDeleveryFees = "total_delevery_fees"
        case price
    }
}
 
struct productCartList: Codable {
    let cartID: Int?
    let productID, productName, shortDescription, listDescription: String?
    let quantity, image, unitPrice: String?
    let totalUnitPrice: Int?

    enum CodingKeys: String, CodingKey {
        case cartID = "cart_id"
        case productID = "product_id"
        case productName = "product_name"
        case shortDescription = "short_description"
        case listDescription = "description"
        case quantity, image
        case unitPrice = "unit_price"
        case totalUnitPrice = "total_unit_price"
    }
}
