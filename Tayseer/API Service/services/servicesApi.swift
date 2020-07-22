//
//  servicesApi.swift
//  Tayseer
//
//  Created by Ahmed farid on 6/7/20.
//  Copyright © 2020 E-bakers. All rights reserved.
//

import Foundation
import Alamofire

class servicesApi: NSObject {
    class func servicesLsitApi(section_id: Int,completion: @escaping(_ error: Error?,_ success: Bool,_ service: services?)-> Void){
        
        let parametars = [
            "lang": URLs.mainLang,
            "section_id": section_id
            ] as [String : Any]
        
        let url = URLs.services
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
                    let service = try JSONDecoder().decode(services.self, from: response.data!)
                    if service.status == false {
                        completion(nil,true,service)
                    }else {
                        completion(nil,true,service)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    
    class func AddMainatceservicesL(section_id: Int,service_id: String,descriptionss: String,date: String,completion: @escaping(_ error: Error?,_ success: Bool,_ service: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let parametars = [
            "type": 1,
            "section_id": section_id,
            "service_id": service_id,
            "description": descriptionss,
            "date": date,
            "request_preview": 0
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)",
            "Content-Type": "application/json"
        ]
        
        let url = URLs.addCartServices
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
                    let service = try JSONDecoder().decode(messages.self, from: response.data!)
                    if service.status == false {
                        completion(nil,true,service)
                    }else {
                        completion(nil,true,service)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func AddEstablishmentServicesL(section_id: Int,address_id: String,request_preview: String,flat_area: String,room_number: String,floor_number: String,customer_note: String,date_time: String,image: UIImage,image2: UIImage,image3: UIImage, image4: UIImage, completion: @escaping(_ error: Error?,_ success: Bool,_ service: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let parametars = [
            "section_id": section_id,
            "address_id": address_id,
            "request_preview": request_preview,
            "flat_area": flat_area,
            "room_number": room_number,
            "floor_number": floor_number,
            "customer_note": customer_note,
            "date_time": date_time
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)",
            "Content-Type": "application/json"
        ]
        
        let url = URLs.requestEstablishment
        print(url)
        print(parametars)
        AF.upload(multipartFormData: { multiPart in
            for p in parametars {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
            multiPart.append(image2.jpegData(compressionQuality: 0.4)!, withName: "image2", fileName: "file2.jpg", mimeType: "image2/jpg")
            multiPart.append(image3.jpegData(compressionQuality: 0.4)!, withName: "image3", fileName: "file3.jpg", mimeType: "image3/jpg")
            multiPart.append(image4.jpegData(compressionQuality: 0.4)!, withName: "image4", fileName: "file4.jpg", mimeType: "image4/jpg")
        }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let service = try JSONDecoder().decode(messages.self, from: response.data!)
                    if service.status == false {
                        completion(nil,true,service)
                    }else {
                        completion(nil,true,service)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func AddEmergenciesServicesL(section_id: Int,address_id: String,services_id: String,customer_note: String,date_time: String,image: UIImage,image2: UIImage,image3: UIImage, image4: UIImage, completion: @escaping(_ error: Error?,_ success: Bool,_ service: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let parametars = [
            "section_id": section_id,
            "address_id": address_id,
            "services_id": services_id,
            "customer_note": customer_note,
            "date_time": date_time
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)",
            "Content-Type": "application/json"
        ]
        
        let url = URLs.requestEmergencies
        print(url)
        print(parametars)
        AF.upload(multipartFormData: { multiPart in
            for p in parametars {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
            multiPart.append(image2.jpegData(compressionQuality: 0.4)!, withName: "image2", fileName: "file2.jpg", mimeType: "image2/jpg")
            multiPart.append(image3.jpegData(compressionQuality: 0.4)!, withName: "image3", fileName: "file3.jpg", mimeType: "image3/jpg")
            multiPart.append(image4.jpegData(compressionQuality: 0.4)!, withName: "image4", fileName: "file4.jpg", mimeType: "image4/jpg")
        }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let service = try JSONDecoder().decode(messages.self, from: response.data!)
                    if service.status == false {
                        completion(nil,true,service)
                    }else {
                        completion(nil,true,service)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
    
    class func AddCleannessesServicesL(section_id: Int,address_id: String,period: String,flat_area: String,room_number: String,floor_number: String,customer_note: String,date_time: String,image: UIImage,image2: UIImage,image3: UIImage, image4: UIImage, completion: @escaping(_ error: Error?,_ success: Bool,_ service: messages?)-> Void){
        
        guard let user_token = helperLogin.getAPIToken() else {
            completion(nil, false,nil)
            return
        }
        
        
        let parametars = [
            "section_id": section_id,
            "address_id": address_id,
            "period": period,
            "flat_area": flat_area,
            "room_number": room_number,
            "floor_number": floor_number,
            "customer_note": customer_note,
            "date_time": date_time
            ] as [String : Any]
        
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "Authorization": "Bearer \(user_token)",
            "Content-Type": "application/json"
        ]
        
        let url = URLs.requestCleannesses
        print(url)
        print(parametars)
        AF.upload(multipartFormData: { multiPart in
            for p in parametars {
                multiPart.append("\(p.value)".data(using: String.Encoding.utf8)!, withName: p.key)
            }
            multiPart.append(image.jpegData(compressionQuality: 0.4)!, withName: "image", fileName: "file.jpg", mimeType: "image/jpg")
            multiPart.append(image2.jpegData(compressionQuality: 0.4)!, withName: "image2", fileName: "file2.jpg", mimeType: "image2/jpg")
            multiPart.append(image3.jpegData(compressionQuality: 0.4)!, withName: "image3", fileName: "file3.jpg", mimeType: "image3/jpg")
            multiPart.append(image4.jpegData(compressionQuality: 0.4)!, withName: "image4", fileName: "file4.jpg", mimeType: "image4/jpg")
        }, to: url, method: .post, headers: headers) .uploadProgress(queue: .main, closure: { progress in
            print("Upload Progress: \(progress.fractionCompleted)")
        }).responseJSON(completionHandler: { data in
            print("upload finished: \(data)")
        }).response { (response) in
            switch response.result
            {
            case .failure(let error):
                completion(error, false,nil)
                print(error)
            case .success:
                do{
                    print(response)
                    let service = try JSONDecoder().decode(messages.self, from: response.data!)
                    if service.status == false {
                        completion(nil,true,service)
                    }else {
                        completion(nil,true,service)
                    }
                }catch{
                    completion(nil,true,nil)
                    print("error")
                }
            }
        }
    }
}
