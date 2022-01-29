//
//  OnlineClassViewModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 17/12/21.
//

import Foundation

class OnlineClassViewModel: BaseAPI{
    
    var moreDataArray = [subMenu]()
    var classDetail: ClassDetailDataModel?
    var reviews:ReviewsListing?
//    var classCheckoutData: ClassCheckoutDataModel?
//    var totalPages = 0
//    var popular_class = false
//    var onlineClassesData = OnlineClassListDataModel()
//    var favorites:FavouriteDateModel?
//    var favouritesListDataModel:FavouritesListModel?
    
    
//    func onlineClassListing(page:Int,params:baseParameters? = nil,completion:@escaping(Bool,String)->()){
//        
//        let request = Request(url: (URLS.baseUrl, APISuffix.onlineClassList(page)), method: .get, parameters: params, headers: true)
//        
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            
//            if responseCode == 1{
//                
//                if let data = receivedData as? [String:Any],let mainData = data["data"] as? [String:Any], let classes = mainData["classes"] as? [String:Any],let dataArray = classes["data"] as? [[String:Any]]{
//                    
//                    self.totalPages = classes["last_page"] as? Int ?? 0
//                    self.popular_class = mainData["popular_class"] as? Bool ?? false
//                    
//                    do{
//                        let json = try JSONSerialization.data(withJSONObject: dataArray, options: .prettyPrinted)
//                        let jsonDecode = try JSONDecoder().decode(OnlineClassListDataModel.self, from: json)
//                        
//                        if self.onlineClassesData.last?.id != jsonDecode.first?.id{
//                            self.onlineClassesData += jsonDecode
//                        }
//                        
//                        completion(true,message ?? "")
//                    }
//                    catch{
//                        completion(false,message ?? "")
//                    }
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//            else{
//                completion(false,message ?? "")
//            }
//        }
//    }
    
    func classDetailsApi(classId:String,completion:@escaping(Bool,String)->()){
        
        let request = Request(url: (URLS.baseUrl, APISuffix.classDetail(classId, "\(UserDefault.sharedInstance?.getUserDetails()?.id ?? 0)")), method: .get, parameters: nil, headers: false)
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let data = receivedData as? [String:Any]{
                
                if data["code"] as? Int ?? -91 == 200{
                    
                    if let classData = data["data"] as? [String:Any]{
                        
                        do{
                            let json = try JSONSerialization.data(withJSONObject: classData, options: .prettyPrinted)
                            self.classDetail = try JSONDecoder().decode(ClassDetailDataModel.self, from: json)
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
    
    func reviewsListing(course_id: String,completion: @escaping(Bool, String)->()){
        
        let param = ["online_class_id": course_id] as baseParameters
        let request = Request(url: (URLS.baseUrl, APISuffix.review), method: .get, parameters: param, headers: true)
        
        super.hitApi(requests: request) { receivedData, message, responseCode in
            
            if let dataReceived = receivedData as? [String:Any]{
              
                if dataReceived["code"] as? Int ?? -91 == 200{
                    
                    if let data = dataReceived["data"] as? [String:Any]{
                        do{
                            let jsonData = try
                            JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
                            self.reviews = try JSONDecoder().decode(ReviewsListing.self, from: jsonData)
                            completion(true, message ?? "")
                        }
                        catch{
                            completion(false, message ?? "")
                        }
                    }
                    else{
                        self.reviews = nil
                        completion(true,message ?? "")
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
    
    func addCustomUrl(classId:String,meetingUrl:String,completion:@escaping(Bool,String)->()){
        
        let param = ["online_class_id":classId,"meeting_link":meetingUrl] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.customUrl), method: .post, parameters: param, headers: true)
        
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
    
    func generateLiveClass(classId:String,completion:@escaping(Bool,String)->()){
        
        let param = ["online_class_id":classId] as baseParameters
        
        let request = Request(url: (URLS.baseUrl, APISuffix.generateLiveClass), method: .post, parameters: param, headers: true)
        
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
    
//    
//    func classCheckoutApi(online_class_id: String,isCourse:Bool,couponId:String,completion:@escaping(Bool,String)->()){
//        
//        var param = ["online_class_id": online_class_id,"coupon_id":couponId] as baseParameters
//        
//        if isCourse{
//            param.removeValue(forKey: "online_class_id")
//            param["course_id"] = online_class_id as AnyObject
//        }
//        
//        let request = Request(url: (URLS.baseUrl, APISuffix.classCheckout), method: .post, parameters: param, headers: true)
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            
//            if let data = receivedData as? [String:Any]{
//                
//                if data["code"] as? Int ?? -91 == 200{
//                    
//                    if let classData = data["data"] as? [String:Any]{
//                        
//                        do{
//                            let json = try JSONSerialization.data(withJSONObject: classData, options: .prettyPrinted)
//                            self.classCheckoutData = try JSONDecoder().decode(ClassCheckoutDataModel.self, from: json)
//                            completion(true,message ?? "")
//                        }
//                        catch{
//                            print(error)
//                            completion(false,error.localizedDescription)
//                        }
//                        
//                    }
//                    else{
//                        completion(false,message ?? "")
//                    }
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//            else{
//                completion(false,message ?? "")
//            }
//        }
//    }
//    
//    func updatePaymentStatusApi(online_class_id: String, payment_id: String, transaction_id: String,isCourse:Bool, completion:@escaping(Bool,String)->()){
//       
//        var param = ["online_class_id": online_class_id, "payment_id": payment_id, "transaction_id": transaction_id, "user_id": "\(UserDefault.sharedInstance?.getUserDetails()?.id ?? 0)"] as baseParameters
//        
//        if isCourse{
//            param.removeValue(forKey: "online_class_id")
//            param["course_id"] = online_class_id as AnyObject
//            param["type"] = "course" as AnyObject
//        }
//        else{
//            param["type"] = "class" as AnyObject
//        }
//        
//        let request = Request(url: (URLS.baseUrl, APISuffix.classPaymentStatus), method: .post, parameters: param, headers: true)
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            
//            if let data = receivedData as? [String:Any]{
//                
//                if data["code"] as? Int ?? -91 == 200{
//                    completion(true,message ?? "")
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//            else{
//                completion(false,message ?? "")
//            }
//        }
//    }
//    
//    func favourites(online_class_id: String,completion: @escaping(Bool, String)->()){
//        
//        let param = ["online_class_id": online_class_id] as baseParameters
//        let request = Request(url: (URLS.baseUrl, APISuffix.wishlist), method: .post, parameters: param, headers: true)
//        
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            
//            if let dataReceived = receivedData as? [String:Any]{
//              
//                if dataReceived["code"] as? Int ?? -91 == 200{
//                    
//                    if let data = dataReceived["data"] as? [String:Any]{
//                        do{
//                            let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//                            self.favorites = try JSONDecoder().decode(FavouriteDateModel.self, from: jsonData)
//                            completion(true, message ?? "")
//                        }
//                        catch{
//                            completion(false, message ?? "")
//                        }
//                    }
//                    else{
//                        self.favorites = nil
//                        completion(true,message ?? "")
//                    }
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//            else{
//                completion(false,message ?? "")
//            }
//        }
//    }
//    
//    func favouritesList(type: String,completion: @escaping(Bool, String)->()){
//        
//        let param = ["type": type] as baseParameters
//        let request = Request(url: (URLS.baseUrl, APISuffix.wishlist), method: .get, parameters: param, headers: true)
//        
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            
//            if let dataReceived = receivedData as? [String:Any]{
//              
//                if dataReceived["code"] as? Int ?? -91 == 200{
//                    
//                    do{
//                        let jsonData = try JSONSerialization.data(withJSONObject: dataReceived, options: .prettyPrinted)
//                        self.favouritesListDataModel = try JSONDecoder().decode(FavouritesListModel.self, from: jsonData)
//                        completion(true, message ?? "")
//                        
//                    }
//                    catch{
//                        print(error)
//                        completion(false, message ?? "")
//                    }
//                    
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//            else{
//                completion(false,message ?? "")
//            }
//        }
//    }
//    
//    func applyCoupon(params:baseParameters,completion: @escaping(String,Bool, String)->()){
//        
//        let request = Request(url: (URLS.baseUrl, APISuffix.applyCoupen), method: .post, parameters: params, headers: true)
//        
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//            
//            if let dataReceived = receivedData as? [String:Any]{
//              
//                if dataReceived["code"] as? Int ?? -91 == 200{
//                    
//                    if let data = dataReceived["data"] as? [String:Any], let price = data["price"] as? Double, let id = data["coupen_id"] as? Int{
//                        completion("\(forTrailingZero(temp: price))",true, "\(id)")
//                    }
//                    else{
//                        completion("",false,message ?? "")
//                    }
//                    
//                }
//                else{
//                    completion("",false,message ?? "")
//                }
//            }
//            else{
//                completion("",false,message ?? "")
//            }
//        }
//    }

}
