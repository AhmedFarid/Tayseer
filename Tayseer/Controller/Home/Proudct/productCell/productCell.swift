//
//  productCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productCell: UITableViewCell {
    
    
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 8
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
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
    func configureCell(producet: dataProduct){
        name.text = producet.title
        desc.text = producet.shortDescription
        price.text = "\(producet.price ?? "") \(URLs.currancy)"
        let urlWithoutEncoding = ("\(URLs.mainImage)\(producet.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        productImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            productImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
