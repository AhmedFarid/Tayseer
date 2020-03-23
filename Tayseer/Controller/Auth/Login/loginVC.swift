//
//  loginVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class loginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNavColore(isTranslucent: true, backColor: #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1),navColor: #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1), barStyle: .default, cart: false)
        imageText()
    }
    
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//           return .darkContent
//       }
    

    func imageText() {
        if let myImage = UIImage(named: "Group 27"){
            email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Group 30"){
            password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
    }
    
    @IBAction func loginBTN(_ sender: Any) {
        let vc = homeVC(nibName: "homeVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func signupBTN(_ sender: Any) {
        let vc = signupVC(nibName: "signupVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
