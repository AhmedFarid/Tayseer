//
//  productCart.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

protocol productCartDelegate {
    func addressButton()
    func orderBtnButton()
}

import UIKit

class productCart: UIView {
    

    @IBOutlet weak var tabelView: UITableView!
    @IBOutlet weak var totalPrice: UILabel!
    
    var delegate: productCartDelegate?
    
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let _ = loadViewFromNib()
    }
    
    override func awakeFromNib() {
        
    }
    @IBAction func changeAdderss(_ sender: Any) {
        delegate?.addressButton()
    }
    
    @IBAction func checkOutBtn(_ sender: Any) {
        delegate?.orderBtnButton()
    }
    
    
    func loadViewFromNib() -> UIView {
        let bundle  = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "productCart", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        return view
    }
}

