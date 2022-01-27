//
//  SignupViewmodel.swift
//  IletsLearning
//
//  Created by OPAYN on 26/10/21.
//

import Foundation

class SignupViewModel: BaseAPI {
    
    //MARK: - Variables
    
    var teacherServices = TeacherServicesDataModel()
    var teacherQualifications = TeacherQualificationsDataModel()
    
    //MARK: - API Calls
    
    func signup(name:String,email:String,password:String,mobile:String,experience:String,services:[String],qualifications:[String],introduction:String,about:String,fileName:[String],fileType:[String],fileData:[Data],fileParam:[String],completion:@escaping(Bool,String)->()){
        
        let param = ["name":name,"email":email,"password":password, "contact_number":mobile,"experience":experience, "services":services, "introduction":introduction,"description":about,"qualification":qualifications, "timezone":Singleton.sharedInstance.userTimeZone] as baseParameters
        
       // let request = Request(url: (URLS.baseUrl, APISuffix.signUp), method: .post, parameters: param, headers: true)
        
        let request = RequestFilesData(url: (URLS.baseUrl, APISuffix.addTeacher), method: .post, parameters: param, headers: false, fileData: fileData, fileName: fileName, fileMimetype: fileType, fileParam: fileParam, numberOfFiles: fileData.count)
        
        super.hitApiWithMultipleFile(requests: request) { receivedData, message, responseCode in
            
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
    
    func getServices(completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.teacherServices), method: .get, parameters: nil, headers: false)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
               
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let services = data["data"] as? [[String:Any]]{
                        
                        do{
                            let json = try JSONSerialization.data(withJSONObject: services, options: .prettyPrinted)
                            self.teacherServices = try JSONDecoder().decode(TeacherServicesDataModel.self, from: json)
                            completion(true,message ?? "")
                        }
                        catch{
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
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    func getQualifications(completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.qualifications), method: .get, parameters: nil, headers: false)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
               
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let services = data["data"] as? [[String:Any]]{
                        
                        do{
                            let json = try JSONSerialization.data(withJSONObject: services, options: .prettyPrinted)
                            self.teacherQualifications = try JSONDecoder().decode(TeacherQualificationsDataModel.self, from: json)
                            completion(true,message ?? "")
                        }
                        catch{
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
            else{
                completion(false,message ?? "")
            }
        }
    }
    
    //MARK: - Validations
    
    func validations(uploadedProfileImage:Bool,name:String,email:String,mobile:String,experience:String,password:String,servicesCount:Int,qualificationsCount:Int,documentsCount:Int,intro:String,about:String)->(Bool,String){
        
        if !uploadedProfileImage{
            return (false,"Please select profile image")
        }
        else if name.replacingOccurrences(of: " ", with: "") == ""{
           return (false,"Please enter user name")
        }
        else if email.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter email")
        }
        else if !(Validation().validateEmailId(emailID: email)){
            return (false,"Please enter valid email")
        }
        else if mobile.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter mobile number")
        }
        else if experience.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter your experience")
        }
        else if password.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Password enter password")
        }
        else if servicesCount == 0{
            return (false,"Please select your services")
        }
        else if qualificationsCount == 0{
            return (false,"Please select your qualifications")
        }
        else if documentsCount == 0{
            return (false,"Please select your documents")
        }
        else if intro.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter introduction")
        }
        else if about.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter description about yourself")
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
