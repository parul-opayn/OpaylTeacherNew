//
//  PaymentListiewModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 24/11/21.
//

import Foundation

class PaymentListViewModel: BaseAPI{
    
    var paymentListModel = PaymentListDataModel()
    
    func getPaymentListApi(completion:@escaping(Bool,String)->()){
        let request = Request(url: (URLS.baseUrl, APISuffix.PaymentList), method: .get, parameters: nil, headers: true)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            if let data = receivedData as? [String:Any]{
                if data["code"] as? Int ?? -91 == 200{
                    if let packagesData = data["data"] as? [[String:Any]]{
                        do{
                            let json = try JSONSerialization.data(withJSONObject: packagesData, options: .prettyPrinted)
                            self.paymentListModel = try JSONDecoder().decode(PaymentListDataModel.self, from: json)
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
}
