//
//  productApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/10/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class productApi: NSObject {
    
    class func productList(section_id: String,type: String,completion: @escaping(_ error: Error?,_ success: Bool,_ serviceCart: Product?)-> Void){
        
        let url = URLs.products
        print(url)
        
        let parametars = [
            "lang": URLs.mainLang,
            "section_id": section_id,
            "type": type
            
        ]
        
        
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let serviceCart = try JSONDecoder().decode(Product.self, from: response.data!)
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
}
