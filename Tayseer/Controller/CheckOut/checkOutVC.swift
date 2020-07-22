//
//  checkOutVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class checkOutVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var totalMaintPrice: UILabel!
    @IBOutlet weak var mainCart: UITableView!
    @IBOutlet weak var totalProductPrice: UILabel!
    @IBOutlet weak var productCart: UITableView!
    @IBOutlet weak var changeBtn: UIButton!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var totalServicesPrice: UILabel!
    @IBOutlet weak var promoCodeTF: UITextField!
    @IBOutlet weak var promoValue: UILabel!
    @IBOutlet weak var totalPriceWithPromo: UILabel!
    
    var services = [CartServicesList]()
    var product = [productCartList]()
    
    var totalPriceCart = 0.0
    var totalPriceProduct = 0.0
    var totalPriceService = 0.0
    var totalAddressPrice = 0.0
    var totalPromo = 0.0
    var promo = 0.0
    var total_price_coupon = 0.0
    var coupone_type = ""
    var coupone_code = ""
    var coupone_value = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        totalPrice.text = "\(totalPriceProduct + totalPriceService + totalAddressPrice)"
        
        mainCart.register(UINib(nibName: "servicesCartCell", bundle: nil), forCellReuseIdentifier: "cell")
        mainCart.delegate = self
        mainCart.dataSource = self
        
        productCart.register(UINib(nibName: "productCartCheckOutCell", bundle: nil), forCellReuseIdentifier: "cell")
        productCart.delegate = self
        productCart.dataSource = self
        
        
        if helperLogin.getLangData().mainAddressID == nil {
            changeBtn.setTitle("Add New Address", for: .normal)
            address.text = "\(helperLogin.getLangData().mianAddressName ?? "")\n\(helperLogin.getLangData().mianAddressPrice ?? "")"
            totalServicesPrice.text = "delivery services \(helperLogin.getLangData().mianAddressPrice ?? "") \(URLs.currancy)"
            self.totalAddressPrice = Double(helperLogin.getLangData().mianAddressPrice ?? "") ?? 0.0
            totalPrice.text = "Total Price \(totalPriceProduct + totalPriceService + totalAddressPrice)"
        }else {
            changeBtn.setTitle("Change Address", for: .normal)
            address.text = "\(helperLogin.getLangData().mianAddressName ?? "")\ndelivery price: \(helperLogin.getLangData().mianAddressPrice ?? "") LE"
            
            totalServicesPrice.text = "delivery services \(helperLogin.getLangData().mianAddressPrice ?? "") \(URLs.currancy)"
            self.totalAddressPrice = Double(helperLogin.getLangData().mianAddressPrice ?? "") ?? 0.0
            totalPrice.text = "Total Price \(totalPriceProduct + totalPriceService + totalAddressPrice)"
        }
        servicesHandelRefresh()
        productHandelRefresh()
        
    }
    
    
    func servicesHandelRefresh(){
        loaderHelper()
        cartApi.serviceCartListApi{ (error, success, services) in
            if let services = services {
                self.services = services.data?.list ?? []
                self.totalMaintPrice.text = "Total Price \(services.data?.totalServices ?? "") \(services.data?.currency ?? "")"
                self.totalPriceService = Double(services.data?.totalServices ?? "") ?? 0.0
                self.totalPrice.text = "Total Price \(self.totalPriceProduct + self.totalPriceService + self.totalAddressPrice)"
                print(services)
                self.mainCart.reloadData()
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
                self.totalProductPrice.text = "Total Price \(product.data?.price ?? 0) \(URLs.currancy)"
                self.totalPriceProduct = Double(product.data?.price ?? 0)
                self.totalPrice.text = "Total Price \(self.totalPriceProduct + self.totalPriceService + self.totalAddressPrice)"
                //                if let number = Int(helperLogin.getLangData().mianAddressPrice ?? "") {
                //                  self.cartPrice = (product.data?.price ?? 0) + number
                //                }else {
                //                self.cartPrice = (product.data?.price ?? 0)
                //                }
                print(product)
                self.productCart.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    @IBAction func changeAddressBtn(_ sender: Any) {
        print("xxxxx")
        let vc = addressLsitVC(nibName: "addressLsitVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true,completion: nil)
    }
    @IBAction func checkOutOtn(_ sender: Any) {
        
        guard helperLogin.getLangData().mainAddressID != nil else {
            let messages = NSLocalizedString("add your address", comment: "hhhh")
            let title = NSLocalizedString("", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        loaderHelper()
        orderApi.creatOrder(address_id: helperLogin.getLangData().mainAddressID ?? "", order_total_price: "\(self.totalPriceProduct + self.totalPriceService + self.totalAddressPrice)",coupone_value: coupone_value,coupone_code: coupone_code,coupone_type: coupone_type,total_price_coupon: "\(total_price_coupon)") { (error, success, message) in
            if success {
                let alert = UIAlertController(title: "Order", message: message?.data ?? "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    let vc = homeVC(nibName: "homeVC", bundle: nil)
                    self.navigationController!.pushViewController(vc, animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    
    @IBAction func promoCodeValue(_ sender: Any) {
        loaderHelper()
        promoCodeApi.checkPromoCodeApi(code: promoCodeTF.text ?? "") { (error, success, couponeType,codeError)  in
            if success {
                if couponeType?.data?.couponeType == "Amount" {
                    self.showAlert(title: "", message: "you won promo code with \(couponeType?.data?.couponeValue ?? "") EGP")
                    self.totalPromo = self.totalPriceProduct + self.totalPriceService + self.totalAddressPrice
                    self.promo = Double(couponeType?.data?.couponeValue ?? "") ?? 0.0
                    self.totalPriceWithPromo.text = "total with promo code \(self.totalPromo - self.promo) EGP"
                    self.promoValue.text = "promo code \(couponeType?.data?.couponeValue ?? "") EGP"
                    
                    self.total_price_coupon = self.totalPromo - self.promo
                    self.coupone_type = couponeType?.data?.couponeType ?? ""
                    self.coupone_code = self.promoCodeTF.text ?? ""
                    self.coupone_value = couponeType?.data?.couponeValue ?? ""
                    
                    
                    self.stopAnimating()
                }else if couponeType?.data?.couponeType == "Percentage" {
                    self.showAlert(title: "", message: "you won promo code with \(couponeType?.data?.couponeValue ?? "") %")
                    self.promo = Double(couponeType?.data?.couponeValue ?? "") ?? 0.0
                    self.totalPromo = self.totalPriceProduct + self.totalPriceService + self.totalAddressPrice
                    self.totalPriceWithPromo.text = "total with promo code \(self.totalPromo - ((self.promo / 100.0) * self.totalPromo)) EGP"
                    self.promoValue.text = "promo code \(couponeType?.data?.couponeValue ?? "") %"
                    
                    self.total_price_coupon = (self.totalPromo - (self.promo / 100.0) * self.totalPromo)
                    self.coupone_type = couponeType?.data?.couponeType ?? ""
                    self.coupone_code = self.promoCodeTF.text ?? ""
                    self.coupone_value = couponeType?.data?.couponeValue ?? ""
                    
                    self.stopAnimating()
                }else {
                    self.showAlert(title: "", message: "Your coupon not available")
                    self.stopAnimating()
                }
            }else if codeError == true {
                self.showAlert(title: "", message: "Your coupon not available")
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
}


extension checkOutVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == mainCart{
            return 1
        }else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == mainCart{
            return services.count
        }else {
            return product.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == mainCart{
            if let cell = mainCart.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? servicesCartCell {
                cell.configureCell(services: services[indexPath.row])
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }else {
                return servicesCartCell()
            }
        }else {
            if let cell = productCart.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? productCartCheckOutCell {
                cell.configureCell(cart: product[indexPath.row])
                cell.selectionStyle = UITableViewCell.SelectionStyle.none
                return cell
            }else {
                return productCartCheckOutCell()
            }
        }
    }
}


extension checkOutVC: AddreessdData{
    func getAddressData(Name: String, Id: Int) {
        if helperLogin.getLangData().mainAddressID == nil {
            changeBtn.setTitle("Add New Address", for: .normal)
            address.text = "\(helperLogin.getLangData().mianAddressName ?? "")\n\(helperLogin.getLangData().mianAddressPrice ?? "")"
            totalServicesPrice.text = "delivery services \(helperLogin.getLangData().mianAddressPrice ?? "") \(URLs.currancy)"
            self.totalAddressPrice = Double(helperLogin.getLangData().mianAddressPrice ?? "") ?? 0.0
            totalPrice.text = "Total Price \(totalPriceProduct + totalPriceService + totalAddressPrice)"
        }else {
            changeBtn.setTitle("Change Address", for: .normal)
            address.text = "\(helperLogin.getLangData().mianAddressName ?? "")\ndelivery price: \(helperLogin.getLangData().mianAddressPrice ?? "") LE"
            totalServicesPrice.text = "delivery services \(helperLogin.getLangData().mianAddressPrice ?? "") \(URLs.currancy)"
            self.totalAddressPrice = Double(helperLogin.getLangData().mianAddressPrice ?? "") ?? 0.0
            totalPrice.text = "Total Price \(totalPriceProduct + totalPriceService + totalAddressPrice)"
        }
    }
}

