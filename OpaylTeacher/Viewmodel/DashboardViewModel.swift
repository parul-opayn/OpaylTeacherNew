//
import Foundation

class DashboardViewModel: BaseAPI{

    var totalPages = 0
    var dashboardModel = MyClassesModel()
    
    func dashboardApi(page:Int,completion: @escaping(Bool, String)->()){
        let request = Request(url: (URLS.baseUrl, APISuffix.teacherClassListing), method: .get, parameters: nil, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let classesData = (data["data"] as? [String:Any])?["data"] as? [[String:Any]]{
                        self.totalPages = data["total"] as? Int ?? 0
                        do{
                            let json = try JSONSerialization.data(withJSONObject: classesData, options: .prettyPrinted)
                            let decodedData = try JSONDecoder().decode(MyClassesModel.self, from: json)
                            
                            self.dashboardModel += decodedData
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
