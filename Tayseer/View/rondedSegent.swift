//
//  rondedSegent.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class rondedSegent: UISegmentedControl {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = layer.bounds.height / 2
        
    }
}
