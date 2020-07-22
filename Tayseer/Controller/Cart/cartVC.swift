//
//  cartApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class cartVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var segmentView: rondedSegent!
    @IBOutlet weak var productCartForm: productCart!
    @IBOutlet weak var maintenanceCartForm: maintenanceCart!
    
    var services = [CartServicesList]()
    var product = [productCartList]()
    var cartPrice = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        maintenanceCartForm.delegate = self
        productCartForm.delegate = self
        maintenanceCartForm.isHidden = true
        setUpNavColore(false, "Cart")
        setupSegment()
        
        productHandelRefresh()
        
        print(helperLogin.getLangData().mianAddressPrice ?? "")
        
        maintenanceCartForm.tabelView.register(UINib(nibName: "maintCartCell", bundle: nil), forCellReuseIdentifier: "cell")
        maintenanceCartForm.tabelView.delegate = self
        maintenanceCartForm.tabelView.dataSource = self
        
        productCartForm.tabelView.register(UINib(nibName: "productCartCell", bundle: nil), forCellReuseIdentifier: "cell")
        productCartForm.tabelView.delegate = self
        productCartForm.tabelView.dataSource = self
        
    }
    
    func servicesHandelRefresh(){
        loaderHelper()
        cartApi.serviceCartListApi{ (error, success, services) in
            if let services = services {
                self.services = services.data?.list ?? []
                self.maintenanceCartForm.totalPrice.text = "Total Price: \(services.data?.totalServices ?? "") \(services.data?.currency ?? "")"
                print(services)
                self.maintenanceCartForm.tabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func productHandelRefresh(){
        loaderHelper()
        cartApi.listOfCart{ (error,networkSuccess,codeSucess,product) in
            if let product = product {
                self.product = product.data?.list ?? []
                self.productCartForm.totalPrice.text = "Total Price: \(product.data?.price ?? 0) \(URLs.currancy)"
                if let number = Int(helperLogin.getLangData().mianAddressPrice ?? "") {
                  self.cartPrice = (product.data?.price ?? 0) + number
                }else {
                self.cartPrice = (product.data?.price ?? 0)
                }
                print(product)
                self.productCartForm.tabelView.reloadData()
                self.stopAnimating()
            }else {
                self.productCartForm.isHidden = true
            }
            self.stopAnimating()
        }
    }
    
    func optionCart(url: String, cartID: String) {
        loaderHelper()
        cartApi.optionCarts(url: url, cart_id: cartID){ (error, success, addTofav) in
            if success {
                self.stopAnimating()
                self.showAlert(title: "Cart", message: addTofav?.data ?? "")
                self.productHandelRefresh()
                self.productCartForm.tabelView.reloadData()
                
            }else {
                self.showAlert(title: "Cart", message: "Check your network")
                self.stopAnimating()
                self.productHandelRefresh()
                self.productCartForm.tabelView.reloadData()
            }
        }
    }
    
    func setupSegment(){
        let titleSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1)]
        let titleNormal = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        segmentView.setTitleTextAttributes(titleNormal, for: .normal)
        segmentView.setTitleTextAttributes(titleSelected, for: .selected)
        segmentView.layer.borderWidth = 2
        segmentView.layer.borderColor = #colorLiteral(red: 0.2156862745, green: 0.3137254902, blue: 0.6078431373, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
    @IBAction func segementAction(_ sender: Any) {
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            maintenanceCartForm.isHidden = true
            productCartForm.isHidden = false
            productHandelRefresh()
        case 1:
            maintenanceCartForm.isHidden = false
            productCartForm.isHidden = true
            servicesHandelRefresh()
        default:
            break;
        }
    }
    
}


extension cartVC: maintenanceCartsDelegate {
    func orderBtnsButton() {
        let vc = checkOutVC(nibName: "checkOutVC", bundle: nil)
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
}

extension cartVC: productCartDelegate {
    func addressButton() {
        
    }
    
    func orderBtnButton() {
       let vc = checkOutVC(nibName: "checkOutVC", bundle: nil)
       self.navigationController!.pushViewController(vc, animated: true)
    }
    
    
}

extension cartVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == maintenanceCartForm.tabelView{
            return 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == maintenanceCartForm.tabelView{
            return services.count
        }else {
            return product.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == maintenanceCartForm.tabelView{
            if let cell = maintenanceCartForm.tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? maintCartCell {
                cell.configureCell(services: services[indexPath.row])
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                cell.deleteBtn = {
                    self.optionCart(url: URLs.delete_cart_services, cartID: "\(self.services[indexPath.row].cartServiceID ?? 0)")
                    self.servicesHandelRefresh()
                    if self.services.count == 1{
                        self.services.removeAll()
                        self.servicesHandelRefresh()
                    }
                }
                return cell
            }else {
                return maintCartCell()
            }
        }else {
            if let cell = productCartForm.tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? productCartCell {
                cell.configureCell(cart: product[indexPath.row])
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                if self.product[indexPath.row].quantity == "1"{
                    cell.minBtn.isHidden = true
                }else {
                    cell.minBtn.isHidden = false
                }
                cell.add = {
                    self.optionCart(url: URLs.plusQuentityCart, cartID: "\(self.product[indexPath.row].cartID ?? 0)")
                    self.productHandelRefresh()
                }
                
                cell.deleteBtn = {
                    self.optionCart(url: URLs.deleteCart, cartID: "\(self.product[indexPath.row].cartID ?? 0)")
                    self.productHandelRefresh()
                    if self.product.count == 1{
                        self.product.removeAll()
                        self.productHandelRefresh()
                    }
                }
                
                cell.min = {
                    self.optionCart(url: URLs.minQuentityCart, cartID: "\(self.product[indexPath.row].cartID ?? 0)")
                    self.productHandelRefresh()
                }
                
                return cell
            }else {
                return productCartCell()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == maintenanceCartForm.tabelView{
            let vc = maintenceCartDitelsVC(nibName: "maintenceCartDitelsVC", bundle: nil)
            vc.modalPresentationStyle = .overCurrentContext
            vc.singlItem = self.services[indexPath.row]
            self.present(vc,animated: true)
        }else {
            print("x")
        }
    }
}

