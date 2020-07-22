//
//  newAddressVC.swift
//  Tayseer
//
//  Created by Ahmed farid on 3/24/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
protocol AddreessdData {

    func getAddressData(Name: String,Id: Int)
}


import UIKit
import NVActivityIndicatorView

class newAddressVC: UIViewController, NVActivityIndicatorViewable {

    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var phone: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var area: UITextField!
    @IBOutlet weak var zones: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var buildingNo: UITextField!
    @IBOutlet weak var floor: UITextField!
    @IBOutlet weak var apartmeentNo: UITextField!
    @IBOutlet weak var editOrAdd: coustomRoundedButton!
    @IBOutlet weak var defaultAddress: coustomRoundedButton!
    
    var new: Bool = true
    var singelItem: adressListData?
    
    var delegate: AddreessdData?
    
    var country = [countriesData]()
    var cites = [citiesData]()
    var areas = [areasData]()
    
    let areaPickerView = UIPickerView()
    let cityPickerView = UIPickerView()
    let countryPickerView = UIPickerView()
    
    var price = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        creatCountryPiker()
        setUpNavColore(false, "Address")
        if new == true {
            editOrAdd.setTitle("Add", for: .normal)
            defaultAddress.isHidden = true
        }else {
            editOrAdd.setTitle("Edit", for: .normal)
            fullName.text = singelItem?.customerName
            phone.text = singelItem?.phone
            city.text = singelItem?.country
            area.text = singelItem?.city
            zones.text = singelItem?.area
            address.text = singelItem?.address
            buildingNo.text = singelItem?.numberHouse
            floor.text = singelItem?.numberFloor
            apartmeentNo.text = singelItem?.numberFlat
        }
    }

    
    
    func creatCountryPiker() {
        area.isEnabled = false
        zones.isEnabled = false
        city.isEnabled = false
        countryPickerView.delegate = self
        countryPickerView.dataSource = self
        city.inputView = countryPickerView
        loaderHelper()
        addressAPi.countriesList{(error,success,country) in
            if let country = country{
                self.country = country.data ?? []
                self.cityPickerView.reloadAllComponents()
                self.city.isEnabled = true
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    func creatCityPiker(country_id: String) {
        zones.isEnabled = false
        area.isEnabled = false
        cityPickerView.delegate = self
        cityPickerView.dataSource = self
        area.inputView = cityPickerView
        loaderHelper()
        addressAPi.cityList(country_id: country_id){ (error,success,cites) in
            if let cites = cites{
                self.cites = cites.data ?? []
                self.cityPickerView.reloadAllComponents()
                self.area.isEnabled = true
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    func areaCityPiker(city_id: String) {
        zones.isEnabled = false
        areaPickerView.delegate = self
        areaPickerView.dataSource = self
        zones.inputView = areaPickerView
        addressAPi.areaList(city_id: city_id){ (error,success,areas) in
            if let areas = areas{
                self.areas = areas.data ?? []
                self.areaPickerView.reloadAllComponents()
                self.zones.isEnabled = true
                self.stopAnimating()
            }
            self.stopAnimating()
        }
        
    }
    
    func addOrEdit(Url: String) {
        loaderHelper()
        addressApi.addNewAddress(url: Url, area_price: singelItem?.areaPrice ?? price, customer_name: fullName.text ?? "", country: city.text ?? "", city: area.text ?? "", area: zones.text ?? "", address: address.text ?? "", number_house: buildingNo.text ?? "", number_floor: floor.text ?? "", number_flat: apartmeentNo.text ?? "", phone: phone.text ?? "", notes: "", address_id: "\(singelItem?.id ?? 0)") { (error, success, message) in
            if success {
                self.showAlert(title: "", message: message?.data ?? "")
                self.stopAnimating()
                if Url == URLs.creatUserAddress {
                self.fullName.text = ""
                self.city.text = ""
                self.area.text = ""
                self.zones.text = ""
                self.address.text = ""
                self.buildingNo.text = ""
                self.floor.text = ""
                self.apartmeentNo.text = ""
                self.phone.text = ""
                }else {
                    
                }
            }
            self.stopAnimating()
        }
    }

    @IBAction func addBtn(_ sender: Any) {
        if new == true {
            addOrEdit(Url: URLs.creatUserAddress)
        }else {
            addOrEdit(Url: URLs.editUserAddress)
        }
    }
    
    
    
    @IBAction func defualtAddreeBTNAction(_ sender: Any) {
        loaderHelper()
        addressApi.activeUserAddress(address_id: singelItem?.id ?? 0) { (error, success, message) in
            if success {
                //self.showAlert(title: "", message: message?.data ?? "")
                self.delegate?.getAddressData(Name: self.singelItem?.address ?? "", Id: self.singelItem?.id ?? 0)
                helperLogin.saveLangData(mainAddressID: "\(self.singelItem?.id ?? 0)", mianAddressName: "\(self.singelItem?.area ?? ""), \(self.singelItem?.city ?? ""), \(self.singelItem?.country ?? "")", mianAddressPrice: self.singelItem?.areaPrice ?? "")
                self.dismiss(animated: true)
                self.stopAnimating()
            }
            self.stopAnimating()
        }
    }
}


extension newAddressVC: UIPickerViewDataSource, UIPickerViewDelegate{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == cityPickerView{
            return cites.count
        }else if pickerView == countryPickerView{
            return country.count
        } else{
            return areas.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == cityPickerView{
            return cites[row].title
        }else if pickerView == countryPickerView {
            return country[row].title
        }
        else{
            return "\(areas[row].title ?? "")||\(areas[row].price ?? "") \(URLs.currancy)"
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == cityPickerView{
            if cites.count != 0 {
                self.area.text = cites[row].title
                self.areaCityPiker(city_id: "\(cites[row].id ?? 0)")
            }
        }else if pickerView == countryPickerView {
            if country.count != 0 {
            self.city.text = country[row].title
            self.creatCityPiker(country_id: "\(country[row].id ?? 0)")
            }
        }else{
            if areas.count != 0 {
                self.zones.text =  "\(areas[row].title ?? "") || \(areas[row].price ?? "") \(URLs.currancy)"
                self.price = areas[row].price ?? ""
            }
        }
    }
}

