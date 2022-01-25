//
//  ForgotPasswordViewModel.swift
//  IletsLearning
//
//  Created by OPAYN on 26/10/21.
//

import Foundation

class ForgotPasswordViewModel: BaseAPI {
    
    func forgotPassword(email:String,completion:@escaping(Bool,String)->()){
        
        let param = ["email":email] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.forgotPassword), method: .post, parameters: param, headers: true)
        
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
