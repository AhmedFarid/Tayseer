//
//  emergencyServicesVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class emergencyServicesVC: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet weak var serviceType: UITextField!
    @IBOutlet weak var decratibonTV: UITextView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var addressTybe: UILabel!
    @IBOutlet weak var changeBTN: UIButton!
    @IBOutlet weak var buttonImage1: UIButton!
    @IBOutlet weak var buttonImage2: UIButton!
    @IBOutlet weak var buttonImage3: UIButton!
    @IBOutlet weak var buttonImage4: UIButton!
    
    private var datePiker: UIDatePicker?
    var singleItem: sectionsData?
    var id = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        decratibonTV.layer.cornerRadius = 8
        decratibonTV.layer.borderWidth = 1
        decratibonTV.layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        decratibonTV.delegate = self
        decratibonTV.text = "Work description"
        decratibonTV.textColor = UIColor.lightGray
        setUpNavColore(false, singleItem?.title ?? "")
        createDatePiker()
        
    }
    
        
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
        decratibonTV.textContainerInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        if helperLogin.getLangData().mainAddressID == nil {
            changeBTN.setTitle("Add New Address", for: .normal)
            addressTybe.text = "\(helperLogin.getLangData().mianAddressName ?? "")\n\(helperLogin.getLangData().mianAddressPrice ?? "")"
        }else {
            changeBTN.setTitle("Change Address", for: .normal)
            addressTybe.text = "\(helperLogin.getLangData().mianAddressName ?? "")\ndelivery price: \(helperLogin.getLangData().mianAddressPrice ?? "") LE"
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
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            //image1.isHidden = false
            self.buttonImage1.setImage(image, for: .normal)
            //self.image1.image = image
        }
    }
    
    var picker_imag2: UIImage? {
        didSet{
            guard let image = picker_imag2 else {return}
            self.buttonImage2.setImage(image, for: .normal)
            //image2.isHidden = false
            //self.image2.image = image
        }
    }
    
    var picker_imag3: UIImage? {
        didSet{
            guard let image = picker_imag3 else {return}
            self.buttonImage3.setImage(image, for: .normal)
            //self.image3.image = image
        }
    }
    
    var picker_imag4: UIImage? {
        didSet{
            guard let image = picker_imag4 else {return}
            self.buttonImage4.setImage(image, for: .normal)
            //image4.isHidden = false
            //self.image4.image = image
        }
    }
    
    func openImagePiker(tag: Int) {
        let piker = UIImagePickerController()
        piker.allowsEditing = true
        piker.sourceType = .photoLibrary
        //piker.sourceType = .camera
        piker.delegate = self
        piker.view.tag = tag
        
        let title = NSLocalizedString("Photo Source", comment: "profuct list lang")
        let message = NSLocalizedString("Chose A Source", comment: "profuct list lang")
        let actionSheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        let titles = NSLocalizedString("Camera", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titles, style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                piker.sourceType = .camera
                self.present(piker, animated: true, completion: nil)
            }else {
                print("notFound")
            }
        }))
        let titless = NSLocalizedString("Photo Library", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titless, style: .default, handler: { (action:UIAlertAction) in
            piker.sourceType = .photoLibrary
            self.present(piker, animated: true, completion: nil)
        }))
        let titlesss = NSLocalizedString("Cancel", comment: "profuct list lang")
        actionSheet.addAction(UIAlertAction(title: titlesss, style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @IBAction func changeAction(_ sender: Any) {
        let vc = addressLsitVC(nibName: "addressLsitVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true,completion: nil)
    }
    
    @IBAction func serviceTypeBtn(_ sender: Any) {
        let vc = servicesTypeVC(nibName: "servicesTypeVC", bundle: nil)
        vc.singleItem = singleItem
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func openImage1(_ sender: Any) {
        openImagePiker(tag: 1)
    }
    
    @IBAction func openImage2(_ sender: Any) {
        openImagePiker(tag: 2)
    }
    @IBAction func openImage3(_ sender: Any) {
        openImagePiker(tag: 3)
    }
    @IBAction func openImage4(_ sender: Any) {
        openImagePiker(tag: 4)
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        guard let serviceTypes = serviceType.text, !serviceTypes.isEmpty else {
            let messages = NSLocalizedString("enter your Services Type", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let dates = date.text, !dates.isEmpty else {
                   let messages = NSLocalizedString("enter your Date", comment: "hhhh")
                   let title = NSLocalizedString("Emergency", comment: "hhhh")
                   self.showAlert(title: title, message: messages)
                   return
               }
               
        guard let decratibonTVs = decratibonTV.text, !decratibonTVs.isEmpty else {
            let messages = NSLocalizedString("enter your work description", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard helperLogin.getLangData().mainAddressID != nil else {
            let messages = NSLocalizedString("add your address", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        loaderHelper()
        servicesApi.AddEmergenciesServicesL(section_id: singleItem?.id ?? 0, address_id: "\(helperLogin.getLangData().mainAddressID ?? "")", services_id: id, customer_note: decratibonTV.text ?? "", date_time: date.text ?? "", image: picker_imag ?? #imageLiteral(resourceName: "placeholder"), image2: picker_imag2 ?? #imageLiteral(resourceName: "placeholder"), image3: picker_imag3 ?? #imageLiteral(resourceName: "placeholder"), image4: picker_imag4 ?? #imageLiteral(resourceName: "placeholder")) { (error, success, message) in
            if success {
                self.showAlert(title: "", message: message?.data ?? "")
                self.stopAnimating()
                self.serviceType.text = ""
                self.decratibonTV.text = ""
                self.date.text = ""
                self.buttonImage1.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.buttonImage2.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.buttonImage3.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.buttonImage4.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.price.text = "Emergency Service 100 EGP"
                
            }
            self.stopAnimating()
        }
    }
}


extension emergencyServicesVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            if picker.view.tag == 1 {
                self.picker_imag = editedImage
            }else if picker.view.tag == 2 {
                self.picker_imag2 = editedImage
            }else if picker.view.tag == 3 {
                self.picker_imag3 = editedImage
            }else if picker.view.tag == 4 {
                self.picker_imag4 = editedImage
            }
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            if picker.view.tag == 0 {
                self.picker_imag = originalImage
            }else if picker.view.tag == 1 {
                self.picker_imag2 = originalImage
            }else if picker.view.tag == 2 {
                self.picker_imag3 = originalImage
            }else if picker.view.tag == 3 {
                self.picker_imag4 = originalImage
            }
        }
        picker.dismiss(animated: true, completion: nil)
    }
}


extension emergencyServicesVC: UITextViewDelegate {
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


extension emergencyServicesVC: servcesIdData {
    func getServiceData(Price: Double, Id: [Int], Name: [String]) {
        
        var servicesName = ""
        if Name.count == 0{
            servicesName = ""
        }else{
            for item in 0...Name.count - 1{
                servicesName.append(contentsOf: "\(Name[item]),")
            }
            servicesName = String(servicesName.dropLast())
        }

        serviceType.text = "\(servicesName)"
        print(Price)
        price.text = "Emergency Service 100 EGP And Total Service Price \(Price) \(URLs.currancy))"
        print(Id)
        
        var servicesIdsString = ""
        if Id.count == 0{
            servicesIdsString = ""
        }else{
            for item in 0...Id.count - 1{
                servicesIdsString.append(contentsOf: "\(Id[item]),")
            }
            id = String(servicesIdsString.dropLast())
        }
    }
    
    
}


extension emergencyServicesVC: AddreessdData{
    func getAddressData(Name: String, Id: Int) {
       if helperLogin.getLangData().mainAddressID == nil {
           changeBTN.setTitle("Add New Address", for: .normal)
           addressTybe.text = "\(helperLogin.getLangData().mianAddressName ?? "")\n\(helperLogin.getLangData().mianAddressPrice ?? "")"
       }else {
           changeBTN.setTitle("Change Address", for: .normal)
           addressTybe.text = "\(helperLogin.getLangData().mianAddressName ?? "")\ndelivery price: \(helperLogin.getLangData().mianAddressPrice ?? "") LE"
       }
    }
}
