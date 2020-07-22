//
//  promoCodeApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/28/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire


class promoCodeApi: NSObject {
    
    class func checkPromoCodeApi(code: String, completion: @escaping(_ error: Error?,_ success: Bool,_ couponeData :couponeType?,_ ApiError: Bool?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil,nil)
            return
        }
        
        let parametars = [
            "lang": URLs.mainLang,
            "code": code
        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(user_token)"
        ]
        
        print(parametars)
        
        let url = URLs.checkPromoCode
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.queryString, headers: headers).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let couponeData = try JSONDecoder().decode(couponeType.self, from: response.data!)
                    if couponeData.status == false {
                        completion(nil,true,couponeData,nil)
                    }else {
                        completion(nil,true,couponeData,nil)
                    }
                }catch{
                    print("error")
                    completion(nil,true,nil,true)
                }
            }
        }
    }
}
