//
//  establishingRequstsDitealsVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class establishingRequstsDitealsVC: UIViewController,NVActivityIndicatorViewable {

    @IBOutlet weak var area: UILabel!
    @IBOutlet weak var room: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var replay: UILabel!
    @IBOutlet weak var accept: coustomRoundedButton!
    @IBOutlet weak var refuser: coustomRoundedButton!
    
    var singelItem: listRequestEstablishmentData?
    var singelItemEmrgeicy: ListRequestEmergenciesData?
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpData()
    }
    
    func setUpData() {
        if url == URLs.listRequestEmergencies {
            area.isHidden = true
            room.isHidden = true
            price.text = "Price: \(singelItemEmrgeicy?.adminPrice ?? "")"
            replay.text = singelItemEmrgeicy?.adminReplay
            
            if singelItemEmrgeicy?.acceptances == "2" {
                status.text = "Pending"
                
            }else if singelItemEmrgeicy?.acceptances == "1" {
                status.text = "Accepted"
                accept.isHidden = true
                refuser.isHidden = true
            }else if singelItemEmrgeicy?.acceptances == "0" {
                status.text = "Refuse"
                accept.isHidden = true
                refuser.isHidden = true
            }
        }else {
            area.text = "Area: \(singelItem?.flatArea ?? "")"
            room.text = "Rooms: \(singelItem?.roomNumber ?? "")"
            price.text = "Price: \(singelItem?.adminPrice ?? "")"
            replay.text = singelItem?.adminReplay
            
            if singelItem?.acceptances == "2" {
                status.text = "Pending"
                
            }else if singelItem?.acceptances == "1" {
                status.text = "Accepted"
                accept.isHidden = true
                refuser.isHidden = true
            }else if singelItem?.acceptances == "0" {
                status.text = "Refuse"
                accept.isHidden = true
                refuser.isHidden = true
            }
        }
    }
    
    @IBAction func acceptBTNAction(_ sender: Any) {
        loaderHelper()
        var Urls = ""
        if url == URLs.listRequestEstablishment {
            Urls = URLs.replayRequestEstablishment
        }else if url == URLs.listRequestEmergencies {
            Urls = URLs.replayRequestEmergencies
        }else {
            Urls = URLs.replayRequestCleannesses
        }
        print(Urls)
        requestsApi.replayEstablishment(Url: Urls , id_request: "\(singelItem?.id ?? singelItemEmrgeicy?.id ?? 0)", acceptances: "1") { (error, success, message) in
            if success {
                let alert = UIAlertController(title: "", message: message?.data ?? "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    _ = self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
    @IBAction func refuseBtnAction(_ sender: Any) {
        loaderHelper()
        var Urls = ""
        if url == URLs.listRequestEstablishment {
            Urls = URLs.replayRequestEstablishment
        }else if url == URLs.listRequestEmergencies {
            Urls = URLs.replayRequestEmergencies
        }else {
            Urls = URLs.replayRequestCleannesses
        }
        requestsApi.replayEstablishment(Url: Urls, id_request: "\(singelItem?.id ?? singelItemEmrgeicy?.id ?? 0)", acceptances: "0") { (error, success, message) in
            if success {
                let alert = UIAlertController(title: "", message: message?.data ?? "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction) in
                    _ = self.navigationController?.popViewController(animated: true)
                }))
                self.present(alert, animated: true, completion: nil)
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
    
}
