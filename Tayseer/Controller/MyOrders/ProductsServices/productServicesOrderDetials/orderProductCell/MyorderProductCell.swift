//
//  orderProductCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class MyorderProductCell: UITableViewCell {
    
    @IBOutlet weak var quntity: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var price: UILabel!
    
    
    func configureCell(orderList: orderListProductDetailsData){
        quntity.text = "quntity:\(orderList.productQuantity ?? "")"
        productName.text = orderList.productName
        price.text = "Product Total Price:\(orderList.productPrice ?? "")"
        
    }
    
    func configureCellServices(orderList: OrderListServicesData){
        quntity.text = "Total Price:\(orderList.totalServiceQuantity ?? "")"
        productName.text = orderList.sectionName
        price.text = "\(orderList.sectionDescription ?? "")"
        
    }
    
    override var frame: CGRect {
        get {
            return super.frame
        }
        set (newFrame) {
            var frame =  newFrame
            frame.origin.y += 4
            frame.size.height -= 2 * 5
            super.frame = frame
        }
    }
}

