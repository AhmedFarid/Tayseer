//
//  SceneDelegate.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
       guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.windowScene = windowScene
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
        
        window?.rootViewController = tabBarController
        window!.makeKeyAndVisible()
        
        
        
        
//        let navigationController = UINavigationController(rootViewController: loginVC())
//        window!.rootViewController = navigationController
//        window!.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

