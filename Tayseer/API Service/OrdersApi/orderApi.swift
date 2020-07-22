//
//  orderApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/15/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire


class orderApi: NSObject {
    
    class func creatOrder(address_id: String,order_total_price: String,coupone_value:String,coupone_code: String,coupone_type: String,total_price_coupon: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "lang": URLs.mainLang,
            "address_id": address_id,
            "payment_method": "1",
            "customer_postal_code": "1",
            "order_total_price": order_total_price,
            "total_price_coupon": total_price_coupon,
            "coupone_type": coupone_type,
            "coupone_code": coupone_code,
            "coupone_value": coupone_value
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(parametars)
        
        AF.request(URLs.createOrder, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
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
    
    class func orderlist(completion: @escaping(_ error: Error?,_ success: Bool,_ orderListt: orderList?)-> Void){
        
        let url = URLs.orderList
        print(url)
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
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
                    let orderListt = try JSONDecoder().decode(orderList.self, from: response.data!)
                    if orderListt.status == false {
                        completion(nil,true,orderListt)
                    }else {
                        completion(nil,true,orderListt)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func orderProductList(Url: String,order_id: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ orderListt: orderListProductDetails?,_ orderListtServies: OrderListServices?)-> Void){
        
       
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil,nil)
            return
        }
        
        let parametars = [
            "lang": URLs.mainLang,
            "order_id": order_id
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        AF.request(Url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let orderListt = try JSONDecoder().decode(orderListProductDetails.self, from: response.data!)
                    let orderListtServies = try JSONDecoder().decode(OrderListServices.self, from: response.data!)
                    if orderListt.status == true {
                        completion(nil,true,orderListt,nil)
                    }else {
                        completion(nil,true,orderListt,nil)
                    }
                    
                    if orderListtServies.status == true {
                        completion(nil,true,nil,orderListtServies)
                    }else {
                        completion(nil,true,nil,orderListtServies)
                    }
                }catch{
                    completion(nil,true,nil,nil)
                    print("error")
                }
            }
        }
    }
    
    class func orderServicesList(Url: String,order_id: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ orderListt: OrderListServices?)-> Void){
        
        
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "lang": URLs.mainLang,
            "order_id": order_id
            ] as [String : Any]
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        AF.request(Url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let orderListt = try JSONDecoder().decode(OrderListServices.self, from: response.data!)
                    if orderListt.status == false {
                        completion(nil,true,orderListt)
                    }else {
                        completion(nil,true,orderListt)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
}
