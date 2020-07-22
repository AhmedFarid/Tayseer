//
//  prodactServiesOrdersCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class prodactServiesOrdersCell: UITableViewCell {

    @IBOutlet weak var OrderId: UILabel!
    @IBOutlet weak var createdAt: UILabel!
    @IBOutlet weak var orderTotalPrice: UILabel!
    @IBOutlet weak var deleveryFees: UILabel!
    @IBOutlet weak var customerStreet: UILabel!
    @IBOutlet weak var orderStat: UILabel!
    
    
    func configureCell(orderList: orderListData){
        OrderId.text = "Order Id:\(orderList.orderID ?? 0)"
        createdAt.text = orderList.createdAt
        orderTotalPrice.text = "Order Total Price:\(orderList.orderTotalPrice ?? "")"
        deleveryFees.text = "Delivery Price:\(orderList.deleveryFees ?? "")"
        customerStreet.text = orderList.customerStreet
        orderStat.text = orderList.orderStat
           
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
