//
//  addressApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/9/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class addressApi: NSObject {
    
    class func addNewAddress(url: String,area_price: String,customer_name: String,country: String,city: String,area: String,address: String,number_house: String,number_floor: String,number_flat: String,phone: String,notes: String,address_id:String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "customer_name": customer_name,
            "country": country,
            "city": city,
            "area": area,
            "address": address,
            "number_house": number_house,
            "number_floor": number_floor,
            "number_flat": number_flat,
            "phone": phone,
            "notes": notes,
            "address_id": address_id,
            "area_price": area_price
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(messages.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func activeUserAddress(address_id: Int, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "address_id": address_id
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.activeUserAddress
        print(url)
        print(parametars)
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let message = try JSONDecoder().decode(messages.self, from: response.data!)
                    if message.status == false {
                        completion(nil,true,message)
                    }else {
                        completion(nil,true,message)
                    }
                }catch{
                    print("error")
                }
            }
        }
    }
    
    class func addressListApi(completion: @escaping(_ error: Error?,_ success: Bool,_ address: adressList?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.listUserAddress
        print(url)
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        AF.request(url, method: .post, parameters: nil, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let address = try JSONDecoder().decode(adressList.self, from: response.data!)
                    if address.status == false {
                        completion(nil,true,address)
                    }else {
                        completion(nil,true,address)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
}

