//
//  maintenanceVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class maintenanceVC: UIViewController {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var establishinFormView: establishingForm!
    @IBOutlet weak var maintaceFromView: maintenceForm!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    @IBOutlet weak var headerImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavColore(false)
        establishinFormView.isHidden = true
        setupSegment()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewHight.constant = self.maintaceFromView.frame.size.height + self.headerImage.frame.size.height + 30
    }
    
    
    
    @IBAction func segementAction(_ sender: Any) {
        
        switch segmentView.selectedSegmentIndex
        {
        case 0:
             establishinFormView.isHidden = true
             maintaceFromView.isHidden = false
             self.viewHight.constant = self.maintaceFromView.frame.size.height + self.headerImage.frame.size.height + 30
        case 1:
             establishinFormView.isHidden = false
             maintaceFromView.isHidden = true
             self.viewHight.constant = self.establishinFormView.frame.size.height + self.headerImage.frame.size.height + 30
        default:
            break;
        }
    }
    
    
    
    func setupSegment(){
        let titleSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1)]
        let titleNormal = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        segmentView.setTitleTextAttributes(titleNormal, for: .normal)
        segmentView.setTitleTextAttributes(titleSelected, for: .selected)
        segmentView.layer.borderWidth = 2
        segmentView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}
