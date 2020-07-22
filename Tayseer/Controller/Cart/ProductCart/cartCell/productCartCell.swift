//
//  productCartCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productCartCell: UITableViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var qty: UILabel!
    @IBOutlet weak var minBtn: UIButton!
    @IBOutlet weak var maxBtn: UIButton!
    @IBOutlet weak var clearBTN: UIButton!
    @IBOutlet weak var totalPrice: UILabel!
    
    
    var add: (()->())?
    var min: (()->())?
    var deleteBtn: (()->())?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backView.layer.cornerRadius = 8.0
        
        
        
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
    
    
    
    func configureCell(cart: productCartList){
        title.text = cart.productName
        price.text = "\(cart.unitPrice ?? "") \(URLs.currancy)"
        totalPrice.text = "\(cart.totalUnitPrice ?? 0) \(URLs.currancy)"
        qty.text = cart.quantity
        let urlWithoutEncoding = ("\(URLs.mainImage)\(cart.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        img.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            img.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
    @IBAction func clearBTNAction(_ sender: Any) {
        deleteBtn?()
    }
    
    @IBAction func plusBTNAction(_ sender: Any) {
        add?()
    }
    @IBAction func mainBTNAction(_ sender: Any) {
        min?()
    }
    
    
}
