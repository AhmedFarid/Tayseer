//
//  productVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class productVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    
    var product = [dataProduct]()
    var singleItem: sectionsData?
    
    var type = "1"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false, singleItem?.title ?? "")
        tabelView.register(UINib(nibName: "productCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelView.delegate = self
        tabelView.dataSource = self
        productHandelRefresh(types: "1")
        setupSegment()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
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
    
    func productHandelRefresh(types: String){
        loaderHelper()
        productApi.productList(section_id: "\(singleItem?.id ?? 0)", type: types){ (error, success, product) in
            if let product = product {
                self.product = product.data ?? []
                print(product)
                self.tabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    @IBAction func segementAction(_ sender: Any) {
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            productHandelRefresh(types: "1")
        case 1:
            productHandelRefresh(types: "0")
        default:
            break;
        }
    }
    
}

extension productVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return product.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tabelView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? productCell {
            cell.configureCell(producet: product[indexPath.row])
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return productCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = productDitealsVC(nibName: "productDitealsVC", bundle: nil)
        vc.singelItem = product[indexPath.row]
        self.navigationController!.pushViewController(vc, animated: true)
    }
}
