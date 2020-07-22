//
//  myOrdersVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class myOrdersVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpNavColore(false, "My Orders")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
    }

    @IBAction func prodctServiecsBtn(_ sender: Any) {
        let vc = productsServicesVC(nibName: "productsServicesVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func emergencyBtn(_ sender: Any) {
        let vc = establishingRequstsVC(nibName: "establishingRequstsVC", bundle: nil)
               vc.url = URLs.listRequestEmergencies
                      self.navigationController!.pushViewController(vc, animated: true)
    }
    
    @IBAction func establishingBTN(_ sender: Any) {
        let vc = establishingRequstsVC(nibName: "establishingRequstsVC", bundle: nil)
        vc.url = URLs.listRequestEstablishment
               self.navigationController!.pushViewController(vc, animated: true)
    }
    @IBAction func cleaningBTN(_ sender: Any) {
        let vc = establishingRequstsVC(nibName: "establishingRequstsVC", bundle: nil)
        vc.url = URLs.listRequestCleannesses
               self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
