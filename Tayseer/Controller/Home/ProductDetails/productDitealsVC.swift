//
//  productDitealsVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class productDitealsVC: UIViewController {

    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var bigDesc: UILabel!
    
    var singelItem: dataProduct?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, singelItem?.title ?? "")
        setUPData()
    }
    
    
    func setUPData() {
        name.text = singelItem?.title
        desc.text = singelItem?.shortDescription
        bigDesc.text = singelItem?.datumDescription
        price.text = "\(singelItem?.price ?? "") \(URLs.currancy)"
        
        let urlWithoutEncoding = ("\(URLs.mainImage)\(singelItem?.image ?? "")")
        let encodedLink = urlWithoutEncoding.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed)
        let encodedURL = NSURL(string: encodedLink!)! as URL
        imageProduct.kf.indicatorType = .activity
        if let url = URL(string: "\(encodedURL)") {
            imageProduct.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        }
    }


    @IBAction func addToCart(_ sender: Any) {
        let vc = addToCartVC(nibName: "addToCartVC", bundle: nil)
        vc.modalPresentationStyle = .custom
        vc.singelItem = singelItem
        vc.delegate = self
        self.present(vc,animated: true)
    }
}

extension productDitealsVC: updateCarts {
    func updateCart() {
        refesHcart()
    }
    
}
