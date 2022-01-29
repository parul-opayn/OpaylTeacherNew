//
//  PaymentListDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 24/11/21.
//

import Foundation

struct PaymentListDataModelElement: Codable {
    let id: Int?
    let userID: PaymentUserID?
    let purchaseType: String?
    let onlineClassID: [OnlineClassID]?
    let courseID, packageID: CourseID?
    let paymentID: PaymentID?
    let status: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case purchaseType = "purchase_type"
        case onlineClassID = "online_class_id"
        case courseID = "course_id"
        case packageID = "package_id"
        case paymentID = "payment_id"
        case status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - OnlineClassID
struct OnlineClassID: Codable {
    let id, teacherID, serviceID, serviceCatID: Int?
    let title: String?
    let thumbnail: String?
    let startDate, endDate: String?
    let seat: Int?
    let duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let rating, reviewCount: Double?
    let classStatus: Int?
    let merithubClassID, hostURL, participantURL, meetingURL: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case teacherID = "teacher_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case title, thumbnail
        case startDate = "start_date"
        case endDate = "end_date"
        case seat, duration, price, content
        case dayTime = "day_time"
        case rating
        case reviewCount = "review_count"
        case classStatus = "class_status"
        case merithubClassID = "merithub_class_id"
        case hostURL = "host_url"
        case participantURL = "participant_url"
        case meetingURL = "meeting_url"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}



// MARK: - UserID
struct PaymentUserID: Codable {
    let id: Int?
    let name, email: String?
    let introduction, userIDDescription: String?
    let emailVerifiedAt, socialID, firebaseToken: String?
    let userCategory, courseLevel: Int?
    let timezone, contactNumber: String?
    let experience: String?
    let status, accountVerificationStatus: Int?
    let merithubUserID: String?
    let image: String?
    let introVideo, deletedAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, introduction
        case userIDDescription = "description"
        case emailVerifiedAt = "email_verified_at"
        case socialID = "social_id"
        case firebaseToken = "firebase_token"
        case userCategory = "user_category"
        case courseLevel = "course_level"
        case timezone
        case contactNumber = "contact_number"
        case experience, status
        case accountVerificationStatus = "account_verification_status"
        case merithubUserID = "merithub_user_id"
        case image
        case introVideo = "intro_video"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

//typealias PaymentListDataModel = [PaymentListDataModelElement]
// MARK: - CourseID

struct CourseID: Codable {
    let createdAt, courseIDDescription, duration, hours: String?
    let id: Int?
    let lesson: String?
    let price: Int?
    let rating, reviews: String?
    let serviceID: Int?
    let thumbnail: String?
    let title: String?
    let type: Int?
    let updatedAt: String?
    let userID: Int?
    
    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case courseIDDescription = "description"
        case duration, hours, id, lesson, price, rating, reviews
        case serviceID = "service_id"
        case thumbnail, title, type
        case updatedAt = "updated_at"
        case userID = "user_id"
    }
}


typealias PaymentListDataModel = [PaymentListDataModelElement]
