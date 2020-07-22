//
//  notificationVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class notificationVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var tabelView: UITableView!
    
    var notification = [notificationData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.register(UINib(nibName: "notificaitonsCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelView.delegate = self
        tabelView.dataSource = self
        
        tabelView.rowHeight = UITableView.automaticDimension
        tabelView.estimatedRowHeight = UITableView.automaticDimension
        
        orderEmrgeicySHandelRefresh()
        
        setUpNavColore(false, "Notificaitons")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
    }
    
    func orderEmrgeicySHandelRefresh(){
        loaderHelper()
        notificatiionApi.listNotificatiion{ (error,success,notification) in
            if let notification = notification{
                self.notification = notification.data ?? []
                print(notification)
                self.tabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }


    
}

extension notificationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notification.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? notificaitonsCell {
            
            cell.configureCell(orderList:  notification[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return notificaitonsCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

