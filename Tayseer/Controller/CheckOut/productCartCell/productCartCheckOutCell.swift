//
//  productCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productCartCheckOutCell: UITableViewCell {
    
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func configureCell(cart: productCartList){
        title.text = cart.productName
        price.text = "\(cart.totalUnitPrice ?? 0) \(URLs.currancy)"
        
    }
    
}
