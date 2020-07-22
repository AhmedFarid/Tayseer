//
//  servicesCartCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class servicesCartCell: UITableViewCell {
    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    func configureCell(services: CartServicesList){
        catName.text = services.name
        totalPrice.text = "\(services.totalServiceQuantity ?? "") \(services.currency ?? "")"
        
    }
    
}
