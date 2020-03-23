//
//  maintenceForm.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit

class maintenceForm: UIView {
    
    @IBOutlet weak var decratibonTV: UITextView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        let _ = loadViewFromNib()
    }
    
    override func awakeFromNib() {
        decratibonTV.layer.cornerRadius = 8
        decratibonTV.layer.borderWidth = 1
        decratibonTV.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        decratibonTV.delegate = self
        decratibonTV.text = "Work description"
        decratibonTV.textColor = UIColor.lightGray
        
    }
    
    func loadViewFromNib() -> UIView {
        let bundle  = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "maintenceForm", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        return view
    }
    
   
       
        
    
    
    
    
    
}

extension maintenceForm: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Work description"
            textView.textColor = UIColor.lightGray
        }
    }
}
