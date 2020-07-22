//
//  notificaitonsCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class notificaitonsCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    
    
    
    func configureCell(orderList: notificationData){
        name.text = orderList.name
        desc.text = orderList.datumDescription
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
