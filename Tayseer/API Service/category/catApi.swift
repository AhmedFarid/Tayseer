//
//  catApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class categoryApi: NSObject {
    class func sliderApi(section_id: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ photos: slider?)-> Void){
        
        let parametars = [
            "lang": URLs.mainLang,
            "section_id": section_id
            ] as [String : Any]
        
        let url = URLs.slidersSections
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
}
