//
//  homeApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class homeApi: NSObject {
    
    
    class func sliderApi(completion: @escaping(_ error: Error?,_ success: Bool,_ photos: slider?)-> Void){
        
        let parametars = [
            "lang": URLs.mainLang
        ]
        
        let url = URLs.slider
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let images = try JSONDecoder().decode(slider.self, from: response.data!)
                    if images.status == false {
                        completion(nil,true,images)
                    }else {
                        completion(nil,true,images)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func categoryApi(completion: @escaping(_ error: Error?,_ success: Bool,_ cat: sections?)-> Void){
        
        let parametars = [
            "lang": URLs.mainLang
        ]
        
        let url = URLs.sections
        print(url)
        print(parametars)
        AF.request(url, method: .post, parameters: parametars, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let cat = try JSONDecoder().decode(sections.self, from: response.data!)
                    if cat.status == false {
                        completion(nil,true,cat)
                    }else {
                        completion(nil,true,cat)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
}
