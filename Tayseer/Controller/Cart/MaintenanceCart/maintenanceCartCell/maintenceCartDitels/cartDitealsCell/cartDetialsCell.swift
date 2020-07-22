//
//  cartDetialsCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class cartDetialsCell: UITableViewCell {

    @IBOutlet weak var serviceName: UILabel!
    @IBOutlet weak var servicePrice: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    
    func configureCell(services: cartServicesDitalsList){
        serviceName.text = services.name
        servicePrice.text = "\(services.price ?? "") \(services.currency ?? "")"
        
    }

   
}
