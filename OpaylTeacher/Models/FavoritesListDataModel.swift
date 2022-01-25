//
//  FavoritesListDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 21/12/21.
//

import Foundation

struct FavouritesListModel: Codable {
    var data: [Datum]?
    let message: String?
    let code: Int?
    var isClassLoaded:Bool?
    var isVideoLoaded:Bool?
    
    enum CodingKeys: String, CodingKey {
        case data
        case message
        case code
    }
    
}

// MARK: - Datum

struct Datum: Codable {
    let id, userID: Int?
    let courseID: Int?
    let onlineClassID, type: Int?
    let updatedAt, createdAt: String?
    let datumClass: ClassData?
    let courses: CoursesList?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case courseID = "course_id"
        case onlineClassID = "online_class_id"
        case type
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case datumClass = "class"
        case courses
    }
}

// MARK: - Courses
struct CoursesList: Codable {
    let id, userID, serviceID: Int?
    let title, coursesDescription: String?
    let type: Int?
    let price: Double?
    let thumbnail: String?
    let reviews: String?
    let rating: String?
    let hours: String?
    let lesson, duration: String?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case title
        case coursesDescription = "description"
        case type, price, thumbnail, reviews, rating, hours, lesson, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - Class

struct ClassData: Codable {
    let id, teacherID, service: Int?
    let serviceCategory: Int?
    let title: String?
    let thumbnail: String?
    let seat: Int?
    let startDate, endDate, duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let rating:Double?
    let reviewCount:Int?
let meetingLink: String?
    let updatedAt, createdAt: String?
    let teacher:TeacherProfileData?

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
        case teacher = "teacher"
    }
}

// MARK: - TeacherProfile

struct TeacherProfileData: Codable {
    let id: Int?
    let name, email: String?
    let emailVerifiedAt: String?
    let type, status: Int?
    let socialID, firebaseToken: String?
    let timezone, createdAt, updatedAt: String?
    let profile: ProfileData?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case type, status
        case socialID = "social_id"
        case firebaseToken = "firebase_token"
        case timezone
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case profile
    }
}

// MARK: - Profile
struct ProfileData: Codable {
    let id, userID: Int?
    let image: String?
    let userCategory, courseLevel: String?
    let updatedAt, createdAt, contactNumber, experience: String?
    let qualification: String?
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
