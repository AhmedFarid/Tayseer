//
//  navHelper.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//



import UIKit

extension UIViewController {
    
    
    func setUpNavColore(isTranslucent: Bool,backColor: UIColor, navColor: UIColor, barStyle: UIBarStyle, cart: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = barStyle
        self.navigationController?.navigationBar.tintColor = backColor
        self.navigationController?.navigationBar.barTintColor = navColor
        
        switch cart {
        case true:
            let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 105-2"), style: .done, target: self, action: #selector(showCart))
            self.navigationItem.rightBarButtonItem = rightBarButtonItem
        default:
            print("no")
        }
    }
    
    @objc func showCart() {
        print("x")
    }
}
