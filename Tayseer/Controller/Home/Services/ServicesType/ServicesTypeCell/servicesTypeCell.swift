//
//  servicesTypeCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class servicesTypeCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var servicesName: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var selecteImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = 8
    }
    
   override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selecteImage.image = selected ? #imageLiteral(resourceName: "Group 1761") : #imageLiteral(resourceName: "Group 1756")
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
    
    func configureCell(services: servicesData){
        servicesName.text = services.title
        price.text = "\(services.price ?? "") \(URLs.currancy)"
    }
    
}
