//
//  SignupViewmodel.swift
//  IletsLearning
//
//  Created by OPAYN on 26/10/21.
//

import Foundation

class SignupViewModel: BaseAPI {
    
    //MARK: - API Calls
    
    func signup(name:String,email:String,password:String,user_category:String,services:[String],course_level:String,completion:@escaping(Bool,String)->()){
        
        let param = ["name":name,"email":email,"password":password, "user_category":user_category, "services":services, "course_level":course_level, "timezone":Singleton.sharedInstance.userTimeZone] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.signUp), method: .post, parameters: param, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let userData = data["data"] as? [String:Any]{
                        
                        do{
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
    
    func otpVerification(id:String,code:String,completion:@escaping(Bool,String)->()){
        
        let param = ["id":(Int(id) ?? 0)!,"code":code] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.emailVerify), method: .post, parameters: param, headers: false)
        
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
    
    
    func resendCode(id:String,completion:@escaping(Bool,String)->()){
        
        let param = ["id":id] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.resendCode), method: .post, parameters: param, headers: false)
        
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
    
    func resetPassword(password:String,confirm_password:String,code:String,completion:@escaping(Bool,String)->()){
        
        let param = ["password":password,"code":code,"confirm_password":confirm_password] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.resetPassword), method: .post, parameters: param, headers: false)
        
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
    
    //MARK: - Validations
    
    func validations(name:String,email:String,password:String,confirmPassword:String)->(Bool,String){
        
        if name.replacingOccurrences(of: " ", with: "") == ""{
           return (false,"Please enter user name")
        }
        else if email.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter email")
        }
        else if !(Validation().validateEmailId(emailID: email)){
            return (false,"Please enter valid email")
        }
        else if password.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Password enter password")
        }
        else if confirmPassword.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Password confirm password")
        }
        else if password != confirmPassword{
            return(false,"Password not match")
        }
        else{
            return(true,"")
        }
    }
    
    func createNewPassValidation(newPass:String,confirmPass:String)->(Bool,String){
     
        if newPass.replacingOccurrences(of: " ", with: "") == ""{
            return(false,"Please enter new password")
        }
        else if confirmPass.replacingOccurrences(of: " ", with: "") == ""{
           return(false,"Please confirm passwor")
        }
        else if newPass != confirmPass{
            return(false,"Password not matched")
        }
        else{
            return(true,"")
        }
    }
    
}
