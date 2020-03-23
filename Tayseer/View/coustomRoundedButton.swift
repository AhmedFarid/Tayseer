//
//  coustomRoundedButton.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/18/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit


@IBDesignable
class coustomRoundedButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 0{
              didSet{
                  self.layer.cornerRadius = self.layer.bounds.height/2
              }
          }
          
       
       @IBInspectable var cornerRadiuscostom: CGFloat = 0{
           didSet{
               self.layer.cornerRadius = cornerRadiuscostom
           }
       }
          @IBInspectable var borderWidth: CGFloat = 0{
              didSet{
                  self.layer.borderWidth = borderWidth
              }
          }
          
          @IBInspectable var borderColor: UIColor = UIColor.clear{
              didSet{
                  self.layer.borderColor = borderColor.cgColor
              }
          }
          
          @IBInspectable var shadowColor : UIColor = UIColor.clear{
              didSet{
                  self.layer.shadowColor  = shadowColor.cgColor
              }
          }
          
          @IBInspectable var shadowOpacity : Float = 0{
              didSet{
                  self.layer.shadowOpacity = shadowOpacity
              }
          }
          
          @IBInspectable var shadowOffset  : CGFloat = 0{
              didSet{
                  self.layer.shadowOffset  = CGSize.zero
              }
          }
          
          @IBInspectable var shadowRadius : CGFloat = 0{
              didSet{
                  self.layer.shadowRadius  = shadowRadius
              }
          }
          
          
      }
