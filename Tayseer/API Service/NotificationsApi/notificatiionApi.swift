//
//  notificatiionApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/25/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire


class notificatiionApi: NSObject {
    
    class func listNotificatiion(completion: @escaping(_ error: Error?,_ success: Bool,_ orderListt: allNotificaitons?)-> Void){
        
        let url = URLs.allNotificaitons
        
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
                    let orderListt = try JSONDecoder().decode(allNotificaitons.self, from: response.data!)
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
    
    class func sendKayFireBase(firebaseToken: String, completion: @escaping(_ error: Error?,_ success: Bool,_ message: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        let parametars = [
            "lang": URLs.mainLang,
            "firebaseToken": firebaseToken
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(parametars)
        
        let url = URLs.updateFirebaseToken
        
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
