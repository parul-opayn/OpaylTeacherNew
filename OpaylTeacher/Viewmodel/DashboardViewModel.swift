//
import Foundation

class DashboardViewModel: BaseAPI{
//  DashboardViewModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 10/11/21.
//

    
    var dashboardModel: DashboardDataModel?
    
    func dashboardApi(completion: @escaping(Bool, String)->()){
        let request = Request(url: (URLS.baseUrl, APISuffix.dashboard), method: .get, parameters: nil, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let packagesData = data["data"] as? [String:Any]{
                        do{
                            let json = try JSONSerialization.data(withJSONObject: packagesData, options: .prettyPrinted)
                            self.dashboardModel = try JSONDecoder().decode(DashboardDataModel.self, from: json)
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
