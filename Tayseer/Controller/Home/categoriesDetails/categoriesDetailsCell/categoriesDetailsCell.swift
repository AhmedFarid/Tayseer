//
//  categoriesDetailsCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class categoriesDetailsCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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
