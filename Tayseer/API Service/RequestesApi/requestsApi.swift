//
//  requestsApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire


class requestsApi: NSObject {
    
    class func replayEstablishment(Url: String,id_request: String,acceptances: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "lang": URLs.mainLang,
            "id_request": id_request,
            "acceptances": acceptances
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(parametars)
        
        AF.request(Url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
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
    
    class func listRequestEstablishments(Url: String,completion: @escaping(_ error: Error?,_ success: Bool,_ orderListt: listRequestEstablishment?)-> Void){
           
           
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
           
           AF.request(Url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: headers).responseJSON{ (response) in
               switch response.result
               {
               case .failure(let error):
                   completion(error, false,nil)
                   print(error)
               case .success:
                   do{
                       print(response)
                       let orderListt = try JSONDecoder().decode(listRequestEstablishment.self, from: response.data!)
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
    
    class func listRequestEmergencies(completion: @escaping(_ error: Error?,_ success: Bool,_ orderListt: ListRequestEmergencies?)-> Void){
        
        let url = URLs.listRequestEmergencies
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
                    let orderListt = try JSONDecoder().decode(ListRequestEmergencies.self, from: response.data!)
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
