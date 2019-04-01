//
//  APIHandler.swift
//  UAETour
//
//  Created by SHILEI CUI on 3/28/19.
//  Copyright © 2019 scui5. All rights reserved.
//

import Foundation

import UIKit

let baseAPIUrl                  =  "http://mccollinsmedia.com/myproject/service/"
let RegistrationApi             =  "registerUser"
let LoginApi                    =  "checklogin"
let ListAttractionsApi          =  "listAttractions"
let UpdateUserApi               =  "updateUser"


enum PossibleErrors : Error {
    
    case errorInResponse
    case emptyFile
    
}
class APIHandler: NSObject {
    
    
    let urlFactory = URLFactory()
    static var sharedInstance = APIHandler()
    private override init() {}
    var user  :  User?
    
    
    func registration(user:User, completion: @escaping (_ registerInfo: String?, _ error: String?) -> Void) {
        let dic = ["fname"      :user.fName,
                   "lname"      :user.lName,
                   "email"      :user.emailId,
                   "mobile"     :user.mobile,
                   "password"   :user.paswd,
                   "cpassword"  :user.paswd,
                   "dob"        :user.dob,
                   "gender"     :user.gender
        ]
        
        urlFactory.webServiceCall(methodName: RegistrationApi, with: dic as! Dictionary<String, String>) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print(jsonResult)
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["data"] as! String
                            completion(nil , info)
                        }else{
                            let info = jsonResult["message"] as! String
                            completion(info , nil)
                            
                        }
                    }
                }else{
                    completion(nil , "Unknown error")
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    
    func updateUser(user:User, completion: @escaping (_ registerInfo: String?, _ error: String?) -> Void) {
        let dic = ["id"         :user.id,
                   "fname"      :user.fName,
                   "lname"      :user.lName,
                   "email"      :user.emailId,
                   "mobile"     :user.mobile,
                   "dob"        :user.dob,
                   "gender"     :user.gender]
                   //"password"   :user.paswd]
        
        urlFactory.webServiceCall(methodName: UpdateUserApi, with: dic as! Dictionary<String, String>) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    print("jsonresult is : \(jsonResult)")
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            //let info = jsonResult["data"] as! String
                            let info = jsonResult["message"] as! String
                            completion(nil , info)
                        }else{
                            //let info = jsonResult["message"] as! String
                            let info = jsonResult["data"] as! String
                            completion(info , nil)
                            
                        }
                    }
                }
            }catch{
                print(error)
                
            }
            
        }
    }
    
    func login(userName email:String, withPassword pwd:String, completion: @escaping (_ user: User?, _ error: String?) -> Void) {
        let dic = ["email":email,
                   "password":pwd]
        
        urlFactory.webServiceCall(methodName: LoginApi, with: dic) { (data, response, jsonError) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    //print(jsonResult)
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["message"] as! String
                            completion(nil , info)
                        }else{
                            if  let datajson = jsonResult["data"] as? [[String:Any]]{
                                let user = self.setupCustomer(jsonResult: datajson[0])
                                completion(user , nil)
                            }
                        }
                    }
                }else{
                    completion(nil , "Unknown error")
                }
            }catch{
                print(error)
            }
        }
    }
    
    func setupCustomer(jsonResult : Dictionary<String, Any>) -> User{

        var customer : User?

        customer = User.init(id: jsonResult["user_id"] as? String, fName: jsonResult["fname"] as? String, lName: jsonResult["lname"] as? String, emailId: jsonResult["email"] as? String, mobile: jsonResult["mobile"] as? String, paswd: jsonResult["password"] as? String, dob: jsonResult["dob"] as? String, gender: jsonResult["gender"] as? String)
        
        return customer!
    }
    
    
    func getAttractions(email:String, completion: @escaping (_ orderArray: Attraction?, _ error: String?) -> Void) {
        let dict = ["email":email]
        urlFactory.webServiceCall(methodName: ListAttractionsApi , with: dict) { (data, response, error) in
            do{
                if let jsonResult =  try JSONSerialization.jsonObject(with: data, options:[]) as? Dictionary<String, Any>{
                    // print(jsonResult)
                    if let iserror = jsonResult["iserror"] as? String{
                        if iserror == "Yes" {
                            let info = jsonResult["message"] as! String
                            completion(nil , info)
                        }else{
                            if  let datajson = jsonResult["data"] as? [[String:Any]]{
                                let attractions = self.setupAttractions(array: datajson)
                                completion(attractions , nil)
                            }
                            
                        }
                    }
                }else{
                    completion(nil , "Unknown error")
                }
            }catch{
                print(error)
                completion([] , error.localizedDescription)
            }
        }
    }
    
    func setupAttractions(array : Array<Dictionary<String,Any>>)->Attraction{
        var attr : Attraction = []
        for item in array{
            attr.append(AttractionElement.init(title: item["title"] as! String, description: item["description"] as! String, image: item["image"] as! String, latitude: item["latitude"] as! String, longitude: item["longitude"] as! String, contact: item["contact"] as! String, timing: item["timing"] as! String, sitelink: item["sitelink"] as! String))
        }
        return attr
    }
    
    
    
}


