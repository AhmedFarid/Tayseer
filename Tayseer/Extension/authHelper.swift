//
//  authHelper.swift
//  Tayseer
//
//  Created by Ahmed farid on 5/31/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import UIKit

class helperLogin: NSObject {
    
    class func restartApp(){
        
        guard let window = UIApplication.shared.keyWindow else {return}
        if getAPIToken() == nil {
            let navigationController = UINavigationController(rootViewController: loginVC())
            window.rootViewController = navigationController
            window.makeKeyAndVisible()
        }else {
            let tabBarController = UITabBarController()
            let homeTabVC = homeVC(nibName: "homeVC",bundle: nil)
            let myOrdersTabVC = myOrdersVC(nibName:"myOrdersVC",bundle: nil)
            let notificationTabVC = notificationVC(nibName: "notificationVC",bundle: nil)
            let moreTabVC = moreVC(nibName:"moreVC",bundle: nil)
            homeTabVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "WhatsApp Image 202"), selectedImage: UIImage(named: "WhatsApp Image 2020-02-04 at 6.40.17 PM copy-1"))
            myOrdersTabVC.tabBarItem = UITabBarItem(title: "My Orders",image:UIImage(named: "checklist") ,tag:2)
            notificationTabVC.tabBarItem = UITabBarItem(title: "Notification",image: UIImage(named: "notifications-button"),tag: 3)
            moreTabVC.tabBarItem = UITabBarItem(title: "More",image:UIImage(named: "ellipsis-1") ,tag:4)
            let controllers = [homeTabVC,myOrdersTabVC,notificationTabVC,moreTabVC].map {
                UINavigationController(rootViewController: $0)
                
            }
            tabBarController.tabBar.tintColor = #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1)
            tabBarController.viewControllers = controllers
            
            window.rootViewController = tabBarController
            window.makeKeyAndVisible()
        }
        UIView.transition(with: window, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    class func dleteAPIToken() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "user_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func saveAPIToken(token: String) {
        let def = UserDefaults.standard
        def.setValue(token, forKey: "user_token")
        def.synchronize()
        
        restartApp()
    }
    
    class func getAPIToken() -> String? {
        let def = UserDefaults.standard
        return def.object(forKey: "user_token") as? String
    }
    
    class func saveLangData(mainAddressID: String, mianAddressName: String, mianAddressPrice: String ) {
        let def = UserDefaults.standard
        def.setValue(mainAddressID, forKey: "mainAddressID")
        def.setValue(mianAddressName, forKey: "mianAddressName")
        def.setValue(mianAddressPrice, forKey: "mianAddressPrice")
        def.synchronize()
    }
    
    class func getLangData() -> (mainAddressID: String?, mianAddressName: String?,mianAddressPrice: String?) {
        let def = UserDefaults.standard
        return (def.object(forKey: "mainAddressID") as? String,def.object(forKey: "mianAddressName") as? String,def.object(forKey: "mianAddressPrice") as? String)
    }
    
    class func dleteLangData() {
        let def = UserDefaults.standard
        def.removeObject(forKey: "mainAddressID")
        def.removeObject(forKey: "mianAddressName")
        def.removeObject(forKey: "mianAddressPrice")
        def.synchronize()
        
        restartApp()
    }
    
}
