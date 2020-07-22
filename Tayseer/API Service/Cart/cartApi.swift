//
//  cartApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class cartApi: NSObject {
    
    class func serviceCartListApi(completion: @escaping(_ error: Error?,_ success: Bool,_ serviceCart: CartServices?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.listCartServices
        print(url)
        
        let parametars = [
            "lang": URLs.mainLang
        ]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let serviceCart = try JSONDecoder().decode(CartServices.self, from: response.data!)
                    if serviceCart.status == false {
                        completion(nil,true,serviceCart)
                    }else {
                        completion(nil,true,serviceCart)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func serviceCartListDitelsApi(cart_service_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ serviceCart: CartServicesDitals?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let url = URLs.listCartServicesDetails
        print(url)
        
        let parametars = [
            "lang": URLs.mainLang,
            "cart_service_id": cart_service_id
        ]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let serviceCart = try JSONDecoder().decode(CartServicesDitals.self, from: response.data!)
                    if serviceCart.status == false {
                        completion(nil,true,serviceCart)
                    }else {
                        completion(nil,true,serviceCart)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    
    
    
    class func addCarts(product_id: String,product_quantity: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "product_id": product_id,
            "product_quantity": product_quantity
            ] as [String : Any]
        
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)"
        ]
        
        let url = URLs.addCart
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
    
    class func listOfCart(completion: @escaping(_ error: Error?,_ networkSuccess: Bool,_ codeSucess: Bool ,_ cart: ProductCart?)-> Void){

        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,false,nil)
            return
        }

        let parametars = [
            "lang": URLs.mainLang
        ]

        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]

        let url = URLs.listDataCart
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cart = try JSONDecoder().decode(ProductCart.self, from: response.data!)
                    if cart.status == false {
                        completion(nil,true,true,cart)
                    }else {
                        completion(nil,true,true,cart)
                    }
                }catch{
                    print("error")
                    completion(nil,true,false,nil)
                }
            }
        }
    }
    
    
    class func optionCarts(url: String,cart_id: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "cart_id": cart_id
            ] as [String : Any]
        
        
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)"
        ]
        
        //let url = URLs.plusQuentityCart
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
    
}
