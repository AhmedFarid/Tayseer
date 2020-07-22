//
//  productsServicesVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class productsServicesVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var orders = [orderListData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.register(UINib(nibName: "prodactServiesOrdersCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelView.delegate = self
        tabelView.dataSource = self
        
        tabelView.rowHeight = UITableView.automaticDimension
        tabelView.estimatedRowHeight = UITableView.automaticDimension
        
        setUpNavColore(false, "Products and Services")
        
        orderSHandelRefresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
    }
    
    func orderSHandelRefresh(){
        loaderHelper()
        orderApi.orderlist{ (error,success,orders) in
            if let orders = orders{
                self.orders = orders.data ?? []
                print(orders)
                self.tabelView.reloadData()
                self.stopAnimating()
            }
             self.stopAnimating()
        }
    }
    
}

extension productsServicesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? prodactServiesOrdersCell {
            cell.configureCell(orderList: orders[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return prodactServiesOrdersCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = productServicesOrderDetialsVC(nibName: "productServicesOrderDetialsVC", bundle: nil)
        vc.singelItem = orders[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}
