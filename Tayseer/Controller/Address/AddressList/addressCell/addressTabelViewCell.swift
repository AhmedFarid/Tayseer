//
//  addressTabelViewCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class addressTabelViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var addressName: UILabel!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var isDefualtAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
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
    
    func configureCell(address: adressListData){
        name.text = address.customerName
        addressName.text = address.address
        city.text = "\(address.city ?? ""), \(address.area ?? "")"
        
        if address.activate == "1" {
            isDefualtAddress.text = "Default Address"
        }else {
            isDefualtAddress.text = ""
        }
        
        
        
    }
    
}
