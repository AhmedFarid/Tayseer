//
//  signupVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class signupVC: UIViewController, NVActivityIndicatorViewable  {
    
    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var phone: UITextField!
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageText()
        // Do any additional setup after loading the view.
    }
    
    func imageText() {
        if let myImage = UIImage(named: "Group 92"){
            fullname.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Group 96"){
            phone.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        
        if let myImage = UIImage(named: "Group 30"){
            password.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        if let myImage = UIImage(named: "Group 27"){
            email.withImage(direction: .Left, image: myImage, colorSeparator: UIColor.clear, colorBorder: UIColor.clear)
        }
        
    }
    
    
    @IBAction func singUpBTN(_ sender: Any) {
        
        let response = Validation.shared.validate(values:
            (ValidationType.alphabeticString, fullname.text ?? "")
            ,(ValidationType.phoneNo, phone.text ?? "")
            ,(ValidationType.email, email.text ?? "")
            ,(ValidationType.password, password.text ?? ""))
        switch response {
        case .success:
            loaderHelper()
            authApi.register(name: fullname.text ?? "", phone: phone.text ?? "", email: email.text ?? "", password: password.text ?? "") { (error, success, Register) in
                if success {
                    if Register?.status == false{
                        self.showAlert(title: "Sign Up", message: "Faild your mail is used")
                        self.stopAnimating()
                    }else{
                        let login = Register?.data
                        print(login?.email ?? "")
                    }
                }else {
                    self.showAlert(title: "SignUp", message: "Check your network")
                    self.stopAnimating()
                }
                
            }
            break
        case .failure(_, let message):
            showAlert(title: "SignUp", message: message.localized())
        }
    }
}
