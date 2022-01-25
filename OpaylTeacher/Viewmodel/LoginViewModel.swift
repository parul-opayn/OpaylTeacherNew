//
//  LoginViewModel.swift
//  IletsLearning
//
//  Created by OPAYN on 26/10/21.
//

import Foundation
import UIKit

class LoginViewModel: BaseAPI {
    
    func login(email:String,password:String,completion:@escaping(Bool,String)->()){
        
        let param = ["email":email,"password":password,"device_token":UserDefaults.standard.value(forKey: "fcmToken") as? String ?? ""] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.login), method: .post, parameters: param, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let userData = data["data"] as? [String:Any]{
                        
                        do{
                            UserDefault.sharedInstance?.removeUserData()
                            try UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:userData, requiringSecureCoding:true), forKey: "userData")
                            UserDefault.sharedInstance?.updateUserData()
                            completion(true,message ?? "")
                        }
                        catch{
                            completion(false,error.localizedDescription)
                        }
                        
                    }
                    else{
                        completion(false,message ?? "")
                    }
                    
                    if let token = data["token"] as? String{
                        UserDefaults.standard.setValue(token, forKey: "token")
                    }
                    else{
                        print("Please review the token is missing")
                    }
                   
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
        
    }
    
    func validations(email:String,password:String)->(Bool,String){
        
        if email.replacingOccurrences(of: " ", with: "") == ""{
           return (false,"Please enter email")
        }
        else if !(Validation().validateEmailId(emailID: email)){
            return (false,"Please enter valid email")
        }
        else if password.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter password")
        }
        else{
            return(true,"")
        }
        
    }
    
    func socialLogin(email:String,name:String,id: String,completion:@escaping(Bool,String)->()){
        
        let param = ["email":email,"name":name,"id":id, "timezone":Singleton.sharedInstance.userTimeZone,"device_token":UserDefaults.standard.value(forKey: "fcmToken") as? String ?? ""] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.socialLogin), method: .post, parameters: param, headers: false)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let userData = data["data"] as? [String:Any]{
                        
                        do{
                            UserDefault.sharedInstance?.removeUserData()
                            try UserDefaults.standard.setValue(NSKeyedArchiver.archivedData(withRootObject:userData, requiringSecureCoding:true), forKey: "userData")
                            UserDefault.sharedInstance?.updateUserData()
                            completion(true,message ?? "")
                        }
                        catch{
                            completion(false,error.localizedDescription)
                        }
                        
                    }
                    else{
                        completion(false,message ?? "")
                    }
                    
                    if let token = data["token"] as? String{
                        UserDefaults.standard.setValue(token, forKey: "token")
                    }
                    else{
                        print("Please review the token is missing")
                    }
                   
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
        
    }
    
    func appTracking(screenName:String,completion:@escaping(Bool,String)->()){
        
        var param = ["screen_name":screenName,"device_id":(UIDevice().identifierForVendor?.uuidString ?? "")] as baseParameters
        
        if let userId = UserDefault.sharedInstance?.getUserDetails()?.id{
            param["user_id"] = userId as AnyObject
        }
        
        print("Parameters = \(param)")
        let request = Request(url: (URLS.baseUrl, APISuffix.track), method: .post, parameters: param, headers: false)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                
                if data["code"] as? Int ?? -91 == 200{
                    completion(true,message ?? "")
                }
                else{
                    completion(false,message ?? "")
                }
            }
            else{
                completion(false,message ?? "")
            }
        }
        
    }
    
}

/**
 
 <string name="v_username">Please enter user name</string>
 <string name="v_email">Please enter email</string>
 <string name="v_validemail">Please enter valid email</string>
 <string name="v_password">Please enter password</string>
 <string name="passwordlength">Password length should be six characters</string>
 <string name="passwordnotmatch">Password not match</string>
 */
