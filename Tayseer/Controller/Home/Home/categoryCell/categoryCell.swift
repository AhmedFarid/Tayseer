//
//  categoryCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class categoryCell: UICollectionViewCell {
    
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 5
    }
    
    func configureCell(cat: sectionsData){
        catName.text = cat.title
        
        let urlWithoutEncoding = ("\(URLs.mainImage)\(cat.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        catImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            catImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }
    
}
