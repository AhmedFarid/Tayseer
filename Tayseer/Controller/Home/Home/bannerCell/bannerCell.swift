//
//  bannerCell.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import Kingfisher

class bannerCell: UICollectionViewCell {

    @IBOutlet weak var bannerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func configureCell(images: sliderData){
        let urlWithoutEncoding = ("\(URLs.mainImage)\(images.image!)")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        bannerImage.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            bannerImage.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }

}
