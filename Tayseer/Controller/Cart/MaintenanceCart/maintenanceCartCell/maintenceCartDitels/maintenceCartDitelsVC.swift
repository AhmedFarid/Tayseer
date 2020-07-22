//
//  maintenceCartDitelsVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class maintenceCartDitelsVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var popView: UIView!
    
    var singlItem: CartServicesList?
    var services = [cartServicesDitalsList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTap(_:))))
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(onTapPop(_:))))
        
        
        self.tabelView.register(UINib.init(nibName: "cartDetialsCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelView.delegate = self
        tabelView.dataSource = self
        
        servicesHandelRefresh()
    }
    
    func servicesHandelRefresh(){
        loaderHelper()
        cartApi.serviceCartListDitelsApi(cart_service_id: "\(singlItem?.cartServiceID ?? 0)"){ (error, success, services) in
            if let services = services {
                self.services = services.data?.list ?? []
                print(services)
                self.tabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    @objc func onTap(_ sender:UIPanGestureRecognizer) {
        dismiss(animated: false, completion: nil)
    }
    
    @objc func onTapPop(_ sender:UIPanGestureRecognizer) {
        
    }
    
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: false, completion: nil)
    }
    
    
}



extension maintenceCartDitelsVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? cartDetialsCell {
            cell.configureCell(services: services[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return cartDetialsCell()
        }
    }
}
