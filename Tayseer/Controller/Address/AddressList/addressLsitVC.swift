//
//  addressLsitVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//


import UIKit

class addressLsitVC: UIViewController {

    @IBOutlet weak var tabelVIew: UITableView!
    
    var address = [adressListData]()
    var delegate: AddreessdData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, "Address list")
        tabelVIew.rowHeight = UITableView.automaticDimension
        tabelVIew.estimatedRowHeight = UITableView.automaticDimension
        tabelVIew.register(UINib(nibName: "addressTabelViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelVIew.delegate = self
        tabelVIew.dataSource = self
        
        addressListHandelRefresh()
    }

    override func viewWillAppear(_ animated: Bool) {
        addressListHandelRefresh()
    }
    
    func addressListHandelRefresh(){
        addressApi.addressListApi{ (error,success,address) in
            if let address = address{
                self.address = address.data ?? []
                print(address)
                self.tabelVIew.reloadData()
            }
        }
    }

    
    @IBAction func dissmisBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addNewBTN(_ sender: Any) {
        let vc = newAddressVC(nibName: "newAddressVC", bundle: nil)
        vc.new = true
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

extension addressLsitVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return address.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelVIew.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? addressTabelViewCell {
           cell.configureCell(address: address[indexPath.row])
           cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return addressTabelViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = newAddressVC(nibName: "newAddressVC", bundle: nil)
        vc.singelItem = address[indexPath.row]
        vc.new = false
        vc.delegate = delegate
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
}

extension addressLsitVC: AddreessdData {
    func getAddressData(Name: String, Id: Int) {
         print(Id)
    }
    
}
