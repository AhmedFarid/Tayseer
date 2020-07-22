//
//  establishCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class establishCell: UITableViewCell {

    @IBOutlet weak var requestID: UILabel!
    @IBOutlet weak var dateTime: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var status: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
    
    func configureCell(establish: listRequestEstablishmentData){
        requestID.text = "request id: \(establish.id ?? 0)"
        dateTime.text = establish.dateTime
        price.text = "admin price: \(establish.adminPrice ?? "")"
        
        if establish.acceptances == "2" {
            status.text = "Pending"
            status.layer.cornerRadius = 5
        }else if establish.acceptances == "1" {
            status.text = "Accepted"
            status.layer.cornerRadius = 5
        }else if establish.acceptances == "0" {
            status.text = "Refuse"
            status.layer.cornerRadius = 5
        }
        
    }
    
    func configureCellEmergcy(Emergcy: ListRequestEmergenciesData){
        requestID.text = "request id: \(Emergcy.id ?? 0)"
        dateTime.text = Emergcy.dateTime
        price.text = "admin price: \(Emergcy.adminPrice ?? "")"
        
        if Emergcy.acceptances == "2" {
            status.text = "Pending"
            status.layer.cornerRadius = 5
        }else if Emergcy.acceptances == "1" {
            status.text = "Accepted"
            status.layer.cornerRadius = 5
        }else if Emergcy.acceptances == "0" {
            status.text = "Refuse"
            status.layer.cornerRadius = 5
        }
        
    }

    
    
}
