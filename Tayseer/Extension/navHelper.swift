//
//  navHelper.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//



import UIKit

extension UIViewController {
    
    func setUpNavColore(_ isTranslucent: Bool, _ title: String){
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = isTranslucent
        self.navigationController?.navigationBar.barStyle = .black
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2156862745, green: 0.2980392157, blue: 0.6078431373, alpha: 1)
        self.navigationItem.title = title
        self.navigationController?.navigationBar.tintColor = .white
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        navigationController?.navigationBar.titleTextAttributes = textAttributes

    }
    
    func refesHcart() {
        let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 105-2"), style: .done, target: self, action: #selector(self.showCart))
        self.navigationItem.rightBarButtonItem = rightBarButtonItem
        cartApi.listOfCart{ (error,networkSuccess,codeSucess,liCart) in
            if liCart?.status == true {
                self.addBadge(count: liCart?.data?.list?.count ?? 0)
            }else {
                    let rightBarButtonItem = UIBarButtonItem.init(image: UIImage(named: "Group 105-2"), style: .done, target: self, action: #selector(self.showCart))
                    self.navigationItem.rightBarButtonItem = rightBarButtonItem
            }
        }
    }
    
    func refesHNotification() {
        notificatiionApi.listNotificatiion{ (error,success,notification) in
            if notification?.status == true {
                if let tabItems = self.tabBarController?.tabBar.items {
                    let tabItem = tabItems[2]
                    tabItem.badgeValue = "\(notification?.data?.count ?? 0)"
                }
            }
        }
        
    }
    
    @objc func showCart() {
        let vc = cartVC(nibName: "cartVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    func addBadge(count: Int) {
           let bagButton = BadgeButton()
           bagButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
           bagButton.tintColor = UIColor.white
           bagButton.setImage(UIImage(named: "Group 105-2"), for: .normal)
           bagButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 5)
           print("cart Count \(count)")
           bagButton.badge = "\(count)"
           bagButton.addTarget(self, action: #selector(self.showCart), for: UIControl.Event.touchUpInside)
           self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: bagButton)
       }
    
}

extension Notification.Name {
    static let updateCart = Notification.Name(rawValue: "updateCart")
}
