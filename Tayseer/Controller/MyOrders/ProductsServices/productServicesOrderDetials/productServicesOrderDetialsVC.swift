//
//  productServicesOrderDetialsVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class productServicesOrderDetialsVC: UIViewController, NVActivityIndicatorViewable{
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var singelItem: orderListData?
    
    var ordersProduct = [orderListProductDetailsData]()
    var ordersServices = [OrderListServicesData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tabelView.register(UINib(nibName: "orderProductCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tabelView.delegate = self
        self.tabelView.dataSource = self
        
        self.tabelView.rowHeight = UITableView.automaticDimension
        self.tabelView.estimatedRowHeight = UITableView.automaticDimension
        
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            orderProductsHandelRefresh(url: URLs.orderListProductDetails)
        case 1:
            orderProductsHandelRefresh(url: URLs.orderListServices)
        default:
            break;
        }
        setupSegment()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func segementAction(_ sender: Any) {
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            orderProductsHandelRefresh(url: URLs.orderListProductDetails)
        case 1:
            orderProductsHandelRefresh(url: URLs.orderListServices)
        default:
            break;
        }
    }
    
    func setupSegment(){
        let titleSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let titleNormal = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        segmentView.setTitleTextAttributes(titleNormal, for: .normal)
        segmentView.setTitleTextAttributes(titleSelected, for: .selected)
        segmentView.layer.borderWidth = 2
        segmentView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 0.2156862745, green: 0.3137254902, blue: 0.6078431373, alpha: 1)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
    }
    
    
    func orderProductsHandelRefresh(url: String){
        loaderHelper()
        orderApi.orderProductList(Url: url, order_id: singelItem?.orderID ?? 0){ (error,success,ordersProduct,ordersServices)  in
            switch self.segmentView.selectedSegmentIndex
            {
            case 0:
                if let ordersProduct = ordersProduct{
                    self.ordersProduct = ordersProduct.data ?? []
                    print(ordersProduct)
                    self.tabelView.reloadData()
                    self.stopAnimating()
                }
            case 1:
                if let ordersServices = ordersServices {
                    self.ordersServices = ordersServices.data ?? []
                    print(ordersServices)
                    self.tabelView.reloadData()
                    self.stopAnimating()
                }
            default:
                break;
            }
        }
    }
}


extension productServicesOrderDetialsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            return ordersProduct.count
        case 1:
            return ordersServices.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? MyorderProductCell {
            
            
            switch segmentView.selectedSegmentIndex
            {
            case 0:
                cell.configureCell(orderList: ordersProduct[indexPath.row])
            case 1:
                cell.configureCellServices(orderList: ordersServices[indexPath.row])
            default:
                break;
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return MyorderProductCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            print("x")
        case 1:
            let vc = productServicesDitelsVC(nibName: "productServicesDitelsVC", bundle: nil)
            vc.singelItem = ordersServices[indexPath.row]
            self.navigationController!.pushViewController(vc, animated: true)
        default:
            break;
        }
    }
    
    
}

