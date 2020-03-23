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
        
        
        imageText()
    }
    
    

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
