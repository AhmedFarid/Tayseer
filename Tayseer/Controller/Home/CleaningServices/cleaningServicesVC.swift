//
//  cleaningServicesVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class cleaningServicesVC: UIViewController,NVActivityIndicatorViewable {
    
    
    @IBOutlet weak var date: UITextField!
    @IBOutlet weak var numberOfRooms: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var buttomImage1: UIButton!
    @IBOutlet weak var buttomImage2: UIButton!
    @IBOutlet weak var buttomImage3: UIButton!
    @IBOutlet weak var buttomImage44: UIButton!
    
    @IBOutlet weak var des: UITextView!
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var defaltAddress: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var devirayPrice: UILabel!
    
    var singleItem: sectionsData?
    private var datePiker: UIDatePicker?
    var periodType = "Daily"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSegment()
        setUpNavColore(false, "Cleaning Services ")
        createDatePiker()
        des.delegate = self
        des.text = "Work description"
        des.textColor = UIColor.lightGray
        devirayPrice.text = ""
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        refesHcart()
        des.textContainerInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        if helperLogin.getLangData().mainAddressID == nil {
            addressBtn.setTitle("Add New Address", for: .normal)
            defaltAddress.text = "\(helperLogin.getLangData().mianAddressName ?? "")\n\(helperLogin.getLangData().mianAddressPrice ?? "")"
            devirayPrice.text = ""
        }else {
            addressBtn.setTitle("Change Address", for: .normal)
            defaltAddress.text = "\(helperLogin.getLangData().mianAddressName ?? "")\ndelivery price: \(helperLogin.getLangData().mianAddressPrice ?? "") LE"
            devirayPrice.text = ""
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
            self.buttomImage1.setImage(image, for: .normal)
        }
    }
    
    var picker_imag2: UIImage? {
        didSet{
            guard let image = picker_imag2 else {return}
            self.buttomImage2.setImage(image, for: .normal)
        }
    }
    
    var picker_imag3: UIImage? {
        didSet{
            guard let image = picker_imag3 else {return}
            self.buttomImage3.setImage(image, for: .normal)
        }
    }
    
    var picker_imag4: UIImage? {
        didSet{
            guard let image = picker_imag4 else {return}
            self.buttomImage44.setImage(image, for: .normal)
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
    
    
    
    
    func setupSegment(){
        let titleSelected = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        let titleNormal = [NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)]
        segmentView.setTitleTextAttributes(titleNormal, for: .normal)
        segmentView.setTitleTextAttributes(titleSelected, for: .selected)
        segmentView.layer.borderWidth = 2
        segmentView.layer.borderColor = #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 0.2141054571, green: 0.3131969273, blue: 0.6085140705, alpha: 1)
        }
    }
    
    
    
    @IBAction func segementAction(_ sender: Any) {
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            periodType = "Daily"
        case 1:
            periodType = "Monthly"
        case 2:
            periodType = "Yearly"
        default:
            break;
        }
    }
    
    @IBAction func addAddressAction(_ sender: Any) {
        let vc = addressLsitVC(nibName: "addressLsitVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true,completion: nil)
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
        guard let ares = area.text, !ares.isEmpty else {
            let messages = NSLocalizedString("enter your area", comment: "hhhh")
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
        
        guard let numberOfRoomss = numberOfRooms.text, !numberOfRoomss.isEmpty else {
            let messages = NSLocalizedString("enter your number of room", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let floors = floor.text, !floors.isEmpty else {
            let messages = NSLocalizedString("enter your number floor", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let desc = des.text, !desc.isEmpty else {
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
        servicesApi.AddCleannessesServicesL(section_id: singleItem?.id ?? 0, address_id: "\(helperLogin.getLangData().mainAddressID ?? "")", period: periodType, flat_area: area.text ?? "", room_number: numberOfRooms.text ?? "", floor_number: floor.text ?? "", customer_note: des.text ?? "", date_time: date.text ?? "", image: picker_imag ?? #imageLiteral(resourceName: "placeholder"), image2: picker_imag2 ?? #imageLiteral(resourceName: "placeholder"), image3: picker_imag3 ?? #imageLiteral(resourceName: "placeholder"), image4: picker_imag4 ?? #imageLiteral(resourceName: "placeholder")) { (error, success, message) in
            if success {
                self.showAlert(title: "", message: message?.data ?? "")
                self.stopAnimating()
                self.date.text = ""
                self.floor.text = ""
                self.area.text = ""
                self.des.text = ""
                self.buttomImage1.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.buttomImage2.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.buttomImage3.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.buttomImage44.setImage(UIImage(named: "Group 1559"), for: .normal)
                
                
                
            }
            self.stopAnimating()
        }
    }
}



extension cleaningServicesVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension cleaningServicesVC: AddreessdData {
    func getAddressData(Name: String, Id: Int) {
        if helperLogin.getLangData().mainAddressID == nil {
            addressBtn.setTitle("Add New Address", for: .normal)
            defaltAddress.text = "\(helperLogin.getLangData().mianAddressName ?? "")\n\(helperLogin.getLangData().mianAddressPrice ?? "")"
            devirayPrice.text = ""
        }else {
            addressBtn.setTitle("Change Address", for: .normal)
            defaltAddress.text = "\(helperLogin.getLangData().mianAddressName ?? "")\ndelivery price: \(helperLogin.getLangData().mianAddressPrice ?? "") LE"
            devirayPrice.text = ""
        }
    }
}

extension cleaningServicesVC: UITextViewDelegate {
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
