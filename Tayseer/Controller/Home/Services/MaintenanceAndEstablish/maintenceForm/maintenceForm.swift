//
//  maintenceForm.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

protocol maintenceFormDelegate {
    func didTapButton()
    func didTapNextButton()
}


import UIKit

class maintenceForm: UIView {
    
    @IBOutlet weak var servicesTypeTF: UITextField!
    @IBOutlet weak var DateTIme: UITextField!
    @IBOutlet weak var decratibonTV: UITextView!
    @IBOutlet weak var totalPrice: UILabel!
    
    
    var delegate: maintenceFormDelegate?
    private var datePiker: UIDatePicker?
    
    
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
        decratibonTV.textContainerInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        createDatePiker()
        
    }
    
    func createDatePiker(){
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .dateAndTime
        datePiker?.addTarget(self, action: #selector(maintenceForm.dateChanged(datePiker:)), for: .valueChanged)
        DateTIme.inputView = datePiker
        
    }
    
    @objc func dateChanged(datePiker: UIDatePicker) {
           let dateFormater = DateFormatter()
           dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
           DateTIme.text = dateFormater.string(from: datePiker.date)
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
    
   
    @IBAction func servicesTypeBTN(_ sender: Any) {
        delegate?.didTapButton()
    }
   
    @IBAction func nextBtn(_ sender: Any) {
        delegate?.didTapNextButton()
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
