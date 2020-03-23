//
//  navHelper.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//



import UIKit

extension UIViewController {
    
    func setUpNavColore(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2156862745, green: 0.2980392157, blue: 0.6078431373, alpha: 1)
        self.navigationController?.navigationBar.tintColor = .white
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 105-2"), style: .done, target: self, action: #selector(showCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    @objc func showCart() {
        print("x")
    }
}
