//
//  establishingForm.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

protocol establishingFormDelegate {
    func didTapUploadImage1Button()
    func didTapUploadImage2Button()
    func didTapUploadImage3Button()
    func didTapUploadImage4Button()
    func nextBtn()
    func requestPreviewBTN()
    func changeAddress()
}


import UIKit

class establishingForm: UIView {
    
    @IBOutlet weak var requestPreviewBTN: UIButton!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var numberOfRooms: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var decratibonTV: UITextView!
    @IBOutlet weak var buttonIImage1: UIButton!
    @IBOutlet weak var buttonIImage2: UIButton!
    @IBOutlet weak var buttonIImage3: UIButton!
    @IBOutlet weak var buttonIImage4: UIButton!
    @IBOutlet weak var addressType: UILabel!
    @IBOutlet weak var changgeBTN: UIButton!
    
    var delegate: establishingFormDelegate?
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
        createDatePiker()
        decratibonTV.textContainerInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        if helperLogin.getLangData().mainAddressID == nil {
            changgeBTN.setTitle("Add New Address", for: .normal)
            addressType.text = "delivery price \(helperLogin.getLangData().mianAddressName ?? "")"
        }else {
            changgeBTN.setTitle("Change Address", for: .normal)
            addressType.text = "delivery price \(helperLogin.getLangData().mianAddressName ?? "")"
        }
    }
    
    func createDatePiker(){
        datePiker = UIDatePicker()
        datePiker?.datePickerMode = .dateAndTime
        datePiker?.addTarget(self, action: #selector(maintenceForm.dateChanged(datePiker:)), for: .valueChanged)
        date.inputView = datePiker
        
    }
    
    @objc func dateChanged(datePiker: UIDatePicker) {
           let dateFormater = DateFormatter()
           dateFormater.dateFormat = "yyyy-MM-dd HH:mm:ss"
           date.text = dateFormater.string(from: datePiker.date)
       }
    
    
    func loadViewFromNib() -> UIView {
        let bundle  = Bundle.init(for: type(of: self))
        let nib = UINib(nibName: "establishingForm", bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        addSubview(view)
        
        return view
    }

    
    @IBAction func nextAction(_ sender: Any) {
        print("xxxxx")
        delegate?.nextBtn()
    }
    @IBAction func uploadImage4(_ sender: Any) {
        delegate?.didTapUploadImage4Button()
    }
    @IBAction func uploadImage3(_ sender: Any) {
        delegate?.didTapUploadImage3Button()
    }
    @IBAction func uploadImage2(_ sender: Any) {
        delegate?.didTapUploadImage2Button()
    }
    @IBAction func uploadImage1(_ sender: Any) {
        delegate?.didTapUploadImage1Button()
    }
    @IBAction func addressAction(_ sender: Any) {
        delegate?.changeAddress()
    }
    
    @IBAction func requestPrviewBTNAction(_ sender: Any) {
        print("ccc")
        delegate?.requestPreviewBTN()
    }
}

extension establishingForm: UITextViewDelegate {
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
