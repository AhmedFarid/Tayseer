//
//  loader.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

extension  NVActivityIndicatorViewable where Self: UIViewController {
    func loaderHelper() {
        startAnimating(CGSize(width: 45, height: 45), message: "Loading",type: .ballSpinFadeLoader, color: #colorLiteral(red: 0.2156862745, green: 0.3137254902, blue: 0.6078431373, alpha: 1), textColor: #colorLiteral(red: 0.2156862745, green: 0.3137254902, blue: 0.6078431373, alpha: 1))
    }
    
}
