//
//  establishingRequstsVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class establishingRequstsVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var tabelView: UITableView!
    
    var establshing = [listRequestEstablishmentData]()
    var emrgeicy = [ListRequestEmergenciesData]()
    
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabelView.register(UINib(nibName: "establishCell", bundle: nil), forCellReuseIdentifier: "cell")
        tabelView.delegate = self
        tabelView.dataSource = self
        
        tabelView.rowHeight = UITableView.automaticDimension
        tabelView.estimatedRowHeight = UITableView.automaticDimension
        
        
        
        if url == URLs.listRequestEstablishment {
            setUpNavColore(false, "Establishing")
        }else if url == URLs.listRequestEmergencies {
            setUpNavColore(false, "Emergencies")
        }else {
            setUpNavColore(false, "Cleannesses")
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
         refesHcart()
         if url == URLs.listRequestEstablishment {
             orderSHandelRefresh()
         }else if url == URLs.listRequestEmergencies {
             orderEmrgeicySHandelRefresh()
         }else {
            orderSHandelRefresh()
        }
    }
    
    func orderSHandelRefresh(){
        loaderHelper()
        var urls = ""
        if url == URLs.listRequestEstablishment {
            urls = URLs.listRequestEstablishment
        }else {
            urls = URLs.listRequestCleannesses
        }
        requestsApi.listRequestEstablishments(Url: urls){ (error,success,establshing) in
            if let establshing = establshing{
                self.establshing = establshing.data ?? []
                print(establshing)
                self.tabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    func orderEmrgeicySHandelRefresh(){
        loaderHelper()
        requestsApi.listRequestEmergencies{ (error,success,emrgeicy) in
            if let emrgeicy = emrgeicy{
                self.emrgeicy = emrgeicy.data ?? []
                print(emrgeicy)
                self.tabelView.reloadData()
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
}

extension establishingRequstsVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if url == URLs.listRequestEmergencies {
            return emrgeicy.count
        }else {//if url ==  {
            
            return establshing.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? establishCell {
            if url == URLs.listRequestEstablishment {
                cell.configureCell(establish: establshing[indexPath.row])
            }else if url == URLs.listRequestEmergencies {
                cell.configureCellEmergcy(Emergcy: emrgeicy[indexPath.row])
            }else {
                 cell.configureCell(establish: establshing[indexPath.row])
            }
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            return cell
        }else {
            return establishCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = establishingRequstsDitealsVC(nibName: "establishingRequstsDitealsVC", bundle: nil)
        if url == URLs.listRequestEstablishment {
            vc.singelItem = establshing[indexPath.row]
            vc.url = url
        }else if url == URLs.listRequestEmergencies {
            vc.singelItemEmrgeicy = emrgeicy[indexPath.row]
            vc.url = url
        }else {
            vc.singelItem = establshing[indexPath.row]
            vc.url = url
        }
        
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
}

