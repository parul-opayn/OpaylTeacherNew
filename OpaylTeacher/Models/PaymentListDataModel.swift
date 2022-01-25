//
//  PaymentListDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 24/11/21.
//

import Foundation

// MARK: - PaymentListDataModelElement

struct PaymentListDataModelElement: Codable {
    let id: Int?
    let transactionID: String?
    let gatewayTransactionID: String?
    let onlineClassID: OnlineClassID?
    let courseID: CourseID?
    let packageID: String?
    let price, userID, status: Int?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case transactionID = "transaction_id"
        case gatewayTransactionID = "gateway_transaction_id"
        case onlineClassID = "online_class_id"
        case courseID = "course_id"
        case packageID = "package_id"
        case price
        case userID = "user_id"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - OnlineClassID
struct OnlineClassID: Codable {
    let id, teacherID, service: Int?
    let serviceCategory: Int?
    let title: String?
    let thumbnail: String?
    let seat: Int?
    let startDate, endDate, duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let rating: Double?
    let reviewCount: Int?
    let meetingLink: String?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case teacherID = "teacher_id"
        case service
        case serviceCategory = "service_category"
        case title, thumbnail, seat
        case startDate = "start_date"
        case endDate = "end_date"
        case duration, price, content
        case dayTime = "day_time"
        case rating
        case reviewCount = "review_count"
        case meetingLink = "meeting_link"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

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
