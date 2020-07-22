//
//  addressAPi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/11/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//
import Foundation
import Alamofire

class addressAPi: NSObject {
    
    class func countriesList(completion: @escaping(_ error: Error?,_ success: Bool,_ country: countries?)-> Void){
        
        let url = URLs.countries
        print(url)
        
        let parametars = [
            "lang": URLs.mainLang,
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
                    let country = try JSONDecoder().decode(countries.self, from: response.data!)
                    if country.status == false {
                        completion(nil,true,country)
                    }else {
                        completion(nil,true,country)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func cityList(country_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ city: cities?)-> Void){
        
        let url = URLs.cities
        print(url)
        
        let parametars = [
            "lang": URLs.mainLang,
            "country_id": country_id
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
                    let city = try JSONDecoder().decode(cities.self, from: response.data!)
                    if city.status == false {
                        completion(nil,true,city)
                    }else {
                        completion(nil,true,city)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func areaList(city_id: String,completion: @escaping(_ error: Error?,_ success: Bool,_ area: areas?)-> Void){
        
        let url = URLs.areas
        print(url)
        
        let parametars = [
            "lang": URLs.mainLang,
            "city_id": city_id
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
                    let area = try JSONDecoder().decode(areas.self, from: response.data!)
                    if area.status == false {
                        completion(nil,true,area)
                    }else {
                        completion(nil,true,area)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
}
