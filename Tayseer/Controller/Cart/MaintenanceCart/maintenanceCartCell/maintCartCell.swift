//
//  maintCartCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class maintCartCell: UITableViewCell {
    
    @IBOutlet weak var catName: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    
    var deleteBtn: (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.layer.cornerRadius = 8
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        deleteBtn?()
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
    
    func configureCell(services: CartServicesList){
        catName.text = services.name
        totalPrice.text = "\(services.totalServiceQuantity ?? "") \(services.currency ?? "")"
        
    }
    
}
