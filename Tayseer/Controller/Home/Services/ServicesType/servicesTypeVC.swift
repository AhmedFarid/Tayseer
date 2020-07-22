//
//  servicesTypeVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

protocol servcesIdData {
    func getServiceData(Price: Double,Id: [Int],Name: [String])
}

import UIKit
import NVActivityIndicatorView

class servicesTypeVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var srvicesTypeTabrllView: UITableView!
    
    var services = [servicesData]()
    var singleItem: sectionsData?
    
    var serviceslId = [Int]()
    var servicesName = [String]()
    var sercicePrice = 0.0
    var hide:Bool = true
    var isSelcete = false
    
    var delegate: servcesIdData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        srvicesTypeTabrllView.register(UINib(nibName: "servicesTypeCell", bundle: nil), forCellReuseIdentifier: "cell")
        srvicesTypeTabrllView.delegate = self
        srvicesTypeTabrllView.dataSource = self
        
        servicesHandelRefresh()
    }
    
    func servicesHandelRefresh(){
        loaderHelper()
        servicesApi.servicesLsitApi(section_id: singleItem?.id ?? 0){ (error, success, services) in
            if let services = services {
                self.services = services.data ?? []
                print(services)
                self.srvicesTypeTabrllView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    
    
    @IBAction func doneBNT(_ sender: Any) {
        delegate?.getServiceData(Price: sercicePrice, Id: serviceslId, Name: servicesName)
        dismiss(animated: true)
    }
    
    @IBAction func closeBTN(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}


extension servicesTypeVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = srvicesTypeTabrllView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? servicesTypeCell {
            cell.configureCell(services: services[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return servicesTypeCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !serviceslId.contains(services[indexPath.row].id ?? 0){
            serviceslId.append(services[indexPath.row].id ?? 0)
            servicesName.append(services[indexPath.row].title ?? "")
            self.sercicePrice += Double(self.services[indexPath.row].price ?? "") ?? 0.0
            //            self.priceLabel.text = "\((self.price + self.additonals) * self.qty)"
        }
        print("xxxx\(serviceslId)")
        print(sercicePrice)
        print(servicesName)
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var currentIndex = 0
        for id in serviceslId{
            if id == services[indexPath.row].id {
                serviceslId.remove(at: currentIndex)
                servicesName.remove(at: currentIndex)
                self.sercicePrice -= Double(self.services[indexPath.row].price ?? "") ?? 0.0
                //                self.priceLabel.text = "\((self.price + self.additonals) * self.qty)"
                break
            }
            currentIndex += 1
        }
        print(serviceslId)
        print(sercicePrice)
        print(servicesName)
    }
}
