//
//  addToCartVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol updateCarts {
    func updateCart()
}

class addToCartVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var qtyText: UILabel!
    @IBOutlet weak var plusQtyBTN: UIButton!
    @IBOutlet weak var minQtyBTN: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceAndTItel: UILabel!
    
    var singelItem: dataProduct?
    var qty = 1
    var price = 0.0
    
    var delegate: updateCarts?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceAndTItel.text = "\(singelItem?.title ?? "")\nPrice\(singelItem?.price ?? "")"
        priceLabel.text = "Total Price \(singelItem?.price ?? "") \(URLs.currancy)"
        price = Double(singelItem?.price ?? "") ?? 0
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
         dismiss(animated: false, completion: nil)
    }
    
    
    @IBAction func minQtyAction(_ sender: Any) {
           qty = qty - 1
        self.priceLabel.text = "Total Price \((self.price) * Double(self.qty)) \(URLs.currancy)"
           self.qtyText.text = "\(qty)"
           if qty == 1 {
               
               minQtyBTN.isHidden = true
           }else {
               minQtyBTN.isHidden = false
           }
       }
       
       @IBAction func pluseQtyAction(_ sender: Any) {
           qty = qty + 1
        self.priceLabel.text = "Total Price \((self.price) * Double(self.qty)) \(URLs.currancy)"
           self.qtyText.text = "\(qty)"
           if qty == 1 {
               minQtyBTN.isHidden = true
           }else {
               minQtyBTN.isHidden = false
           }
           
       }
    
    @IBAction func addCartBTN(_ sender: Any) {
        loaderHelper()
        cartApi.addCarts(product_id: "\(singelItem?.id ?? 0)", product_quantity: "\(qty)"){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                let alert = UIAlertController(title: "Add cart", message: "\(addTofav?.data ?? "")", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    self.delegate?.updateCart()
                    self.dismiss(animated: false, completion: nil)
                }))
                self.present(alert, animated: true, completion: nil)
            }else {
                self.showAlert(title: "Add cart", message: "Check your network")
                self.stopAnimating()
            }
        }
    }
    
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
        //dismiss(animated: false, completion: nil)
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    
}


extension addToCartVC: UITabBarDelegate  {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        dismiss(animated: false, completion: nil)
    }
}
