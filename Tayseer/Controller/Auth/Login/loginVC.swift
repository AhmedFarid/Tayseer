//
//  loginVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class loginVC: UIViewController,NVActivityIndicatorViewable  {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpNav(true)
        imageText()
    }
    
    func setUpNav(_ isTranslucent: Bool){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2156862745, green: 0.2980392157, blue: 0.6078431373, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.2156862745, green: 0.2980392157, blue: 0.6078431373, alpha: 1)
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
        let response = Validation.shared.validate(values:
            (ValidationType.email, email.text ?? "")
            ,(ValidationType.password, password.text ?? ""))
        switch response {
        case .success:
            loaderHelper()
            authApi.login(email: email.text ?? "", password: password.text ?? "") { (error, success, login) in
                if success {
                    if login?.status == false{
                        self.stopAnimating()
                        self.showAlert(title: "Login", message: "Faild email or password is wrong")
                    }else{
                        let login = login?.data
                        print(login?.email ?? "")
                    }
                }else {
                    self.stopAnimating()
                    self.showAlert(title: "Login", message: "Check your network")
                }
            }
            break
        case .failure(_, let message):
            showAlert(title: "Login", message: message.localized())
        }
    }
    
    @IBAction func signupBTN(_ sender: Any) {
        let vc = signupVC(nibName: "signupVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
