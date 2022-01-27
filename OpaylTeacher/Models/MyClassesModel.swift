//
//  MyClassesModel.swift
//  OpaylTeacher
//
//  Created by OPAYN on 27/01/22.
//

import Foundation

// MARK: - MyClassesModelElement

struct MyClassesModelElement: Codable {
    let seat: Int?
    let serviceID: ServiceID?
    let thumbnail: String?
    let classStatus: Int?
    let title: String?
    let teacher: Teacher?
    let duration, updatedAt, endDate: String?
    let hostURL: String?
    let teacherID: Int?
    let merithubClassID, participantURL: String?
    let id, serviceCatID: Int?
    let deletedAt, meetingURL: String?
    let dayTime: Int?
    let reviewCount: Int?
    let startDate, createdAt: String?
    let price: Int?
    let rating: Double?
    let content: String?

    enum CodingKeys: String, CodingKey {
        case seat
        case serviceID = "service_id"
        case thumbnail
        case classStatus = "class_status"
        case title, teacher, duration
        case updatedAt = "updated_at"
        case endDate = "end_date"
        case hostURL = "host_url"
        case teacherID = "teacher_id"
        case merithubClassID = "merithub_class_id"
        case participantURL = "participant_url"
        case id
        case serviceCatID = "service_cat_id"
        case deletedAt = "deleted_at"
        case meetingURL = "meeting_url"
        case dayTime = "day_time"
        case reviewCount = "review_count"
        case startDate = "start_date"
        case createdAt = "created_at"
        case price, rating, content
    }
}

// MARK: - ServiceID
struct ServiceID: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Teacher
struct Teacher: Codable {
    let status: Int?
    let image: String?
    let updatedAt: String?
    let merithubUserID: String?
    let contactNumber: String?
    let socialID: String?
    let name: String?
    let courseLevel: Int?
    let id: Int?
    let firebaseToken, introVideo: String?
    let email: String?
    let deletedAt: String?
    let timezone, introduction, emailVerifiedAt: String?
    let userCategory: String?
    let experience, accountVerificationStatus: Int?
    let createdAt, teacherDescription: String?

    enum CodingKeys: String, CodingKey {
        case status, image
        case updatedAt = "updated_at"
        case merithubUserID = "merithub_user_id"
        case contactNumber = "contact_number"
        case socialID = "social_id"
        case name
        case courseLevel = "course_level"
        case id
        case firebaseToken = "firebase_token"
        case introVideo = "intro_video"
        case email
        case deletedAt = "deleted_at"
        case timezone, introduction
        case emailVerifiedAt = "email_verified_at"
        case userCategory = "user_category"
        case experience
        case accountVerificationStatus = "account_verification_status"
        case createdAt = "created_at"
        case teacherDescription = "description"
    }
}

typealias MyClassesModel = [MyClassesModelElement]
