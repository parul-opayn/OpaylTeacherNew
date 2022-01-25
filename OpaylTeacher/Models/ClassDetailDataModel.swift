//
//  ClassDetailDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 17/12/21.
//

import Foundation

// MARK: - ClassDetailDataModel
struct ClassDetailDataModel: Codable {
    let id, teacherID, service: Int?
    let serviceCategory: Int?
    let title: String?
    let thumbnail: String?
    let seat: Int?
    let startDate, endDate, duration: String?
    var price: Double?
    let content: String?
    let rating: Double?
    let reviewCount: Int?
    let dayTime: Int?
    let updatedAt, createdAt: String?
    let teacher: Teacher?
    let studyMaterial: [ClassStudyMaterial]?
    let user: [User]?
    let wishlist:Wishlist?
    let meeting_link:String?
    let merithub_class_id:String?
    let participant_url:String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case teacherID = "teacher_id"
        case service
        case serviceCategory = "service_category"
        case title, thumbnail, seat
        case rating
        case reviewCount = "review_count"
        case startDate = "start_date"
        case endDate = "end_date"
        case duration, price, content
        case dayTime = "day_time"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case teacher, user
        case studyMaterial = "study_material"
        case wishlist = "wishlist"
        case meeting_link
        case merithub_class_id
        case participant_url
    }
}

// MARK: - StudyMaterial
struct ClassStudyMaterial: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let type: Int?
    let title: String?
    let resourceID: Int?
   // let resource:Resource?
    let updatedAt,material, createdAt: String?
    //let type:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title
        case resourceID = "resource_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
       // case resource
        case material
    }
}

// MARK: - Teacher
struct Teacher: Codable {
    let id: Int?
    let name, email: String?
    let emailVerifiedAt: String?
    let type, status: Int?
    let socialID, firebaseToken: String?
    let createdAt, updatedAt: String?
    let profile: TeacherProfile?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case type, status
        case socialID = "social_id"
        case firebaseToken = "firebase_token"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile
    }
}

// MARK: - Profile
struct TeacherProfile: Codable {
    let id, userID: Int?
    let image: String?
    let userCategory:Int?
        let courseLevel: Int?
    let updatedAt, createdAt, contactNumber, experience: String?
    let qualification: Qualification?
    let document: String?
    let introduction, profileDescription: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image
        case userCategory = "user_category"
        case courseLevel = "course_level"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case contactNumber = "contact_number"
        case experience, qualification, document, introduction
        case profileDescription = "description"
    }
}

// MARK: - Qualification
struct Qualification: Codable {
    let id: Int?
    let title: String?
}

// MARK: - User
struct ClassUser: Codable {
    let id, userID: Int?
    let purchaseType: String?
    let onlineClassID: Int?
    let paymentID: String?
    let status: Int?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case purchaseType = "purchase_type"
        case onlineClassID = "online_class_id"
        case paymentID = "payment_id"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
