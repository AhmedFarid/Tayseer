//
//  maintenanceVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/23/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//



import UIKit
import NVActivityIndicatorView

class maintenanceVC: UIViewController,NVActivityIndicatorViewable {
    
    @IBOutlet weak var segmentView: UISegmentedControl!
    @IBOutlet weak var establishinFormView: establishingForm!
    @IBOutlet weak var maintaceFromView: maintenceForm!
    @IBOutlet weak var viewHight: NSLayoutConstraint!
    @IBOutlet weak var headerImage: UIImageView!
    
    
    var singleItem: sectionsData?
    var id = ""
    var requestPrview = "0"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        maintaceFromView.delegate = self
        establishinFormView.delegate = self
        setUpNavColore(false, singleItem?.title ?? "")
        establishinFormView.isHidden = true
        setupSegment()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //self.viewHight.constant = self.maintaceFromView.frame.size.height + self.headerImage.frame.size.height + 30
        refesHcart()
        switch segmentView.selectedSegmentIndex
        {
        case 0:
            establishinFormView.isHidden = true
            maintaceFromView.isHidden = false
            self.viewHight.constant = self.maintaceFromView.frame.size.height + self.headerImage.frame.size.height + 30
        case 1:
            establishinFormView.isHidden = false
            maintaceFromView.isHidden = true
            self.viewHight.constant = self.establishinFormView.frame.size.height + self.headerImage.frame.size.height + 80
        default:
            break;
        }
    }
    
    
    
    
    var picker_imag: UIImage? {
        didSet{
            guard let image = picker_imag else {return}
            self.establishinFormView.buttonIImage1.setImage(image, for: .normal)
        }
    }
    
    var picker_imag2: UIImage? {
        didSet{
            guard let image = picker_imag2 else {return}
            self.establishinFormView.buttonIImage2.setImage(image, for: .normal)
        }
    }
    
    var picker_imag3: UIImage? {
        didSet{
            guard let image = picker_imag3 else {return}
            self.establishinFormView.buttonIImage3.setImage(image, for: .normal)
        }
    }
    
    var picker_imag4: UIImage? {
        didSet{
            guard let image = picker_imag4 else {return}
            self.establishinFormView.buttonIImage4.setImage(image, for: .normal)
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
            self.viewHight.constant = self.establishinFormView.frame.size.height + self.headerImage.frame.size.height + 80
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
        segmentView.layer.borderColor = #colorLiteral(red: 0.2156862745, green: 0.3137254902, blue: 0.6078431373, alpha: 1)
        segmentView.clipsToBounds = true
        segmentView.layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            segmentView.selectedSegmentTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    
}


extension maintenanceVC: establishingFormDelegate {
    func changeAddress() {
        print("xxxxx")
        let vc = addressLsitVC(nibName: "addressLsitVC", bundle: nil)
        vc.delegate = self
        let navigationController = UINavigationController(rootViewController: vc)
        self.present(navigationController, animated: true,completion: nil)
    }
    
    func requestPreviewBTN() {
        if requestPrview == "0" {
            requestPrview = "1"
            establishinFormView.requestPreviewBTN.setImage(UIImage(named: "Group 1761"), for: .normal)
        }else if requestPrview == "1" {
            requestPrview = "0"
            establishinFormView.requestPreviewBTN.setImage(UIImage(named: "Group 1756"), for: .normal)
        }
    }
    
    
    func didTapUploadImage1Button() {
        openImagePiker(tag: 1)
    }
    
    func didTapUploadImage2Button() {
        openImagePiker(tag: 2)
    }
    
    func didTapUploadImage3Button() {
        openImagePiker(tag: 3)
    }
    
    func didTapUploadImage4Button() {
        openImagePiker(tag: 4)
    }
    
    func nextBtn() {
        guard let area = establishinFormView.area.text, !area.isEmpty else {
            let messages = NSLocalizedString("enter your area", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let numberOfRooms = establishinFormView.numberOfRooms.text, !numberOfRooms.isEmpty else {
            let messages = NSLocalizedString("enter your number of room", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let floor = establishinFormView.floor.text, !floor.isEmpty else {
            let messages = NSLocalizedString("enter your floor", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let decratibonTV = establishinFormView.decratibonTV.text, !decratibonTV.isEmpty else {
            let messages = NSLocalizedString("enter your work description", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let date = establishinFormView.date.text, !date.isEmpty else {
            let messages = NSLocalizedString("enter your date", comment: "hhhh")
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
        servicesApi.AddEstablishmentServicesL(section_id: singleItem?.id ?? 0, address_id: "\(helperLogin.getLangData().mainAddressID ?? "")", request_preview: requestPrview, flat_area: establishinFormView.area.text ?? "", room_number: establishinFormView.numberOfRooms.text ?? "", floor_number: establishinFormView.floor.text ?? "", customer_note: establishinFormView.decratibonTV.text ?? "", date_time: establishinFormView.date.text ?? "", image: picker_imag ?? #imageLiteral(resourceName: "placeholder"), image2: picker_imag2 ?? #imageLiteral(resourceName: "placeholder"), image3: picker_imag3 ?? #imageLiteral(resourceName: "placeholder"), image4: picker_imag4 ?? #imageLiteral(resourceName: "placeholder")) { (error, success, message) in
            if success {
                self.showAlert(title: "", message: message?.data ?? "")
                self.stopAnimating()
                
                self.requestPrview = "0"
                self.establishinFormView.area.text = ""
                self.establishinFormView.numberOfRooms.text = ""
                self.establishinFormView.floor.text = ""
                self.establishinFormView.decratibonTV.text = ""
                self.establishinFormView.date.text = ""
                self.establishinFormView.buttonIImage1.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.establishinFormView.buttonIImage2.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.establishinFormView.buttonIImage3.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.establishinFormView.buttonIImage4.setImage(UIImage(named: "Group 1559"), for: .normal)
                self.establishinFormView.requestPreviewBTN.setImage(UIImage(named: "Group 1756"), for: .normal)
                
            }
            self.stopAnimating()
        }
    }
    
    
}

extension maintenanceVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

extension maintenanceVC: maintenceFormDelegate{
    func didTapNextButton() {
        
        guard let decratibonTV = maintaceFromView.decratibonTV.text, !decratibonTV.isEmpty else {
            let messages = NSLocalizedString("enter your work description Services Type", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let servicesTypeTF = maintaceFromView.servicesTypeTF.text, !servicesTypeTF.isEmpty else {
            let messages = NSLocalizedString("enter your Services Type", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        guard let dates = maintaceFromView.DateTIme.text, !dates.isEmpty else {
            let messages = NSLocalizedString("enter your date", comment: "hhhh")
            let title = NSLocalizedString("Emergency", comment: "hhhh")
            self.showAlert(title: title, message: messages)
            return
        }
        
        
        loaderHelper()
        servicesApi.AddMainatceservicesL(section_id: singleItem?.id ?? 0, service_id: id, descriptionss: maintaceFromView.decratibonTV.text ?? "", date: maintaceFromView.DateTIme.text ?? "") { (error, success, message) in
            if success {
                self.showAlert(title: "", message: message?.data ?? "")
                self.stopAnimating()
                self.maintaceFromView.decratibonTV.text = ""
                self.maintaceFromView.servicesTypeTF.text = ""
                self.maintaceFromView.DateTIme.text = ""
            }
            self.stopAnimating()
        }
    }
    
    func didTapButton() {
        let vc = servicesTypeVC(nibName: "servicesTypeVC", bundle: nil)
        vc.singleItem = singleItem
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

extension maintenanceVC: servcesIdData {
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
        
        maintaceFromView.servicesTypeTF.text = "\(servicesName)"
        print(Price)
        maintaceFromView.totalPrice.text = "Total Service Price \(Price) \(URLs.currancy)"
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
extension maintenanceVC: AddreessdData{
    func getAddressData(Name: String, Id: Int, price: String) {
        if helperLogin.getLangData().mainAddressID == nil {
            print(Name)
            establishinFormView.changgeBTN.setTitle("Add New Address", for: .normal)
            establishinFormView.addressType.text = "delivery price \(helperLogin.getLangData().mianAddressName ?? "")"
        }else {
            print(Name)
            establishinFormView.changgeBTN.setTitle("Change Address", for: .normal)
            establishinFormView.addressType.text = "delivery price \(helperLogin.getLangData().mianAddressName ?? "")"
        }
    }
    
    func getAddressData(Name: String, Id: Int) {
        if helperLogin.getLangData().mainAddressID == nil {
            print(Name)
            establishinFormView.changgeBTN.setTitle("Add New Address", for: .normal)
            establishinFormView.addressType.text = "delivery price \(helperLogin.getLangData().mianAddressName ?? "")"
        }else {
            print(Name)
            establishinFormView.changgeBTN.setTitle("Change Address", for: .normal)
            establishinFormView.addressType.text = "delivery price \(helperLogin.getLangData().mianAddressName ?? "")"
        }
    }
}


