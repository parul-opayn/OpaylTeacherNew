//
//  CourseDetailViewModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 03/11/21.
//

import Foundation

class CourseDetailViewmodel: BaseAPI{
    
    var courseData: CourseDetailDataModel?
  //  var messages = Messages()
  //  var favorites:FavouriteDateModel?
  //  var reviews:ReviewsListing?
    
    func getCourseDetail(courseId: Int, userId: String, completion: @escaping(Bool, String)->()){
        super.hitApi(requests: Request(url: (URLS.baseUrl, APISuffix.courseDetail(courseId, userId)), method: .get, parameters: nil, headers: false), completion: { receivedData, message, responseCode in
            if responseCode == 1{
                do{
                    let jsonData = try JSONSerialization.data(withJSONObject: (receivedData as? [String: AnyObject])?["data"] as? [String: AnyObject] ?? [String: AnyObject](), options: .prettyPrinted)
                    self.courseData = try JSONDecoder().decode(CourseDetailDataModel.self, from: jsonData)
                }catch{
                    completion(false, error.localizedDescription)
                }
                completion(true, message ?? "")
            }else{
                completion(false, message ?? "")
            }
            
        })
    }
    
//    func paymentApi(course_id: String, payment_id: String,type:String,completion: @escaping(Bool, String)->()){
//        let param = ["course_id": course_id, "payment_id": payment_id,"type":type] as baseParameters
//        let request = Request(url: (URLS.baseUrl, APISuffix.buyCourse), method: .post, parameters: param, headers: true)
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
//    func getMessages(course_id: String,isOnlineClass:Bool? = nil,completion: @escaping(Bool, String)->()){
//
//        var param = ["course_id": course_id] as baseParameters
//        param["type"] = "2" as AnyObject
//        //This would only work for online class
//
//        if let onlineClass = isOnlineClass{
//            if onlineClass{
//                param = [:]
//                param["online_class_id"] = course_id as AnyObject
//                param["type"] = "1" as AnyObject
//            }
//        }
//
//        let request = Request(url: (URLS.baseUrl, APISuffix.messages), method: .get, parameters: param, headers: true)
//
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//
//            if let dataReceived = receivedData as? [String:Any], let data = dataReceived["data"] as? [[String:Any]]{
//
//                if dataReceived["code"] as? Int ?? -91 == 200{
//
//                    do{
//                        let jsonData = try JSONSerialization.data(withJSONObject: data, options: .prettyPrinted)
//                        self.messages = try JSONDecoder().decode(Messages.self, from: jsonData)
//                        completion(true, message ?? "")
//                    }
//                    catch{
//                        completion(false, error.localizedDescription)
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
//
//    func postMessages(course_id: String,tutorId:String,messageToSend:String,isOnlineClass:Bool? = nil,fileName:String? = nil, fileType:String? = nil, fileData:Data? = nil,completion: @escaping(Bool, String)->()){
//
//        var param = ["tutor_id":tutorId,"course_id": course_id,"message":messageToSend] as baseParameters
//
//        //This would only work for online class
//
//        if let onlineClass = isOnlineClass{
//            if onlineClass{
//                param.removeValue(forKey: "tutor_id")
//                param.removeValue(forKey: "course_id")
//                param["online_class_id"] = course_id as AnyObject
//            }
//        }
//
//        if fileData != nil{
//
//            let requestFile = RequestFileData(url: (URLS.baseUrl, APISuffix.message), method: .post, parameters: param, headers: true, fileData: fileData!, fileName: fileName ?? "IELTS_iOS", fileMimetype: fileType ?? ".png", fileParam: "attachment")
//
//            super.hitApiWithSingleFile(requests: requestFile) { receivedData, message, responseCode in
//
//                if let dataReceived = receivedData as? [String:Any]{
//
//                    if dataReceived["code"] as? Int ?? -91 == 200{
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                        let currentDate = dateFormatter.string(from: Date())
//
//                        self.messages.append(Message(id: 0, courseID: Int(course_id), userID: UserID(id: UserDefault.sharedInstance?.getUserDetails()?.id, name: UserDefault.sharedInstance?.getUserDetails()?.name), tutorID: 0, message: messageToSend, updatedAt: currentDate, createdAt: currentDate,attachment: (dataReceived["data"] as? [String:Any])?["attachment"] as? String ?? ""))
//                        completion(true, message ?? "")
//                    }
//                    else{
//                        completion(false,message ?? "")
//                    }
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//        }
//        else{
//
//            let request = Request(url: (URLS.baseUrl, APISuffix.message), method: .post, parameters: param, headers: true)
//
//            super.hitApi(requests: request) { receivedData, message, responseCode in
//
//                if let dataReceived = receivedData as? [String:Any]{
//
//                    if dataReceived["code"] as? Int ?? -91 == 200{
//                        let dateFormatter = DateFormatter()
//                        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//                        let currentDate = dateFormatter.string(from: Date())
//
//                        self.messages.append(Message(id: 0, courseID: Int(course_id), userID: UserID(id: UserDefault.sharedInstance?.getUserDetails()?.id, name: UserDefault.sharedInstance?.getUserDetails()?.name), tutorID: 0, message: messageToSend, updatedAt: currentDate, createdAt: currentDate, attachment: nil))
//                        completion(true, message ?? "")
//                    }
//                    else{
//                        completion(false,message ?? "")
//                    }
//                }
//                else{
//                    completion(false,message ?? "")
//                }
//            }
//        }
//
//    }
//
//    func addReview(course_id: String,rating:String,messageToSend:String,isOnlineClass:Bool? = nil,completion: @escaping(Bool, String)->()){
//
//        var param = ["rating":rating,"course_id": course_id,"message":messageToSend] as baseParameters
//
//        if let onlineClass = isOnlineClass{
//            if onlineClass{
//                param.removeValue(forKey: "course_id")
//                param["online_class_id"] = course_id as AnyObject
//            }
//        }
//
//        let request = Request(url: (URLS.baseUrl, APISuffix.review), method: .post, parameters: param, headers: true)
//
//        super.hitApi(requests: request) { receivedData, message, responseCode in
//
//            if let dataReceived = receivedData as? [String:Any]{
//
//                if dataReceived["code"] as? Int ?? -91 == 200{
//
//                    completion(true, message ?? "")
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
//    func favourites(course_id: String,completion: @escaping(Bool, String)->()){
//
//        let param = ["course_id": course_id] as baseParameters
//        let request = Request(url: (URLS.baseUrl, APISuffix.addFavourate), method: .post, parameters: param, headers: true)
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
//    func reviewsListing(course_id: String,completion: @escaping(Bool, String)->()){
//
//        let param = ["course_id": course_id] as baseParameters
//        let request = Request(url: (URLS.baseUrl, APISuffix.review), method: .get, parameters: param, headers: true)
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
//                            self.reviews = try JSONDecoder().decode(ReviewsListing.self, from: jsonData)
//                            completion(true, message ?? "")
//                        }
//                        catch{
//                            completion(false, message ?? "")
//                        }
//                    }
//                    else{
//                        self.reviews = nil
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
    
}
