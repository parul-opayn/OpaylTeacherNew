//
//  ChangePasswordViewModel.swift
//  IletsLearning
//
//  Created by OPAYN on 27/10/21.
//

import Foundation

class ChagePasswordViewModel:BaseAPI{
    
    func changePassword(oldPassword:String,newPassword:String,completion:@escaping(Bool,String)->()){
        
        let param = ["old_password":oldPassword,"new_password":newPassword] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.changePassword), method: .post, parameters: param, headers: true)
        
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
    
    func validation(oldPass:String,newPas:String,confirmPass:String)->(Bool,String){
       
        if oldPass.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter current password")
        }
        else if newPas.replacingOccurrences(of: " ", with: "") == ""{
            return (false,"Please enter new password")
        }
       else if confirmPass.replacingOccurrences(of: " ", with: "") == ""{
           return (false,"Please enter confirm password")
        }
        else if newPas != confirmPass{
            return(false,"New password and confirm password did not match")
        }
        else{
            return(true,"success")
        }
    }
    
}
