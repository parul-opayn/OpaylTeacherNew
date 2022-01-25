//
//  CourseDetailDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 03/11/21.
//

import Foundation

// MARK: - CourseDetailDataModel
struct CourseDetailDataModel: Codable {
    let id, userID, serviceID: Int?
    let title, courseDetailDataModelDescription: String?
    let type: Int?
    var price: Double?
    let thumbnail: String?
    let reviews, rating, hours: String?
    let lesson: Int?
    let duration, updatedAt, createdAt: String?
    let user: [User]?
    var videoSection: [VideoSection]?
    let review: [Review]?
    let author: Author?
    let wishlist:Wishlist?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case title
        case courseDetailDataModelDescription = "description"
        case type, price, thumbnail, reviews, rating, hours, lesson, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case user
        case videoSection = "course_section"
        case review, author
        case wishlist
    }
}

// MARK: - Author
struct Author: Codable {
    let createdAt, email, emailVerifiedAt, firebaseToken: String?
    let id: Int?
    let name, socialID: String?
    let type: Int?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case createdAt = "created_at"
        case email
        case emailVerifiedAt = "email_verified_at"
        case firebaseToken = "firebase_token"
        case id, name
        case socialID = "social_id"
        case type
        case updatedAt = "updated_at"
    }
}


// MARK: - Wishlist
struct Wishlist: Codable {
    let courseID: Int?
    let createdAt: String?
    let id: Int?
    let updatedAt: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case userID = "user_id"
    }
}


// MARK: - User
struct User: Codable {
    let id: Int?
    let name, email, emailVerifiedAt: String?
    let type: Int?
    let socialID: Int?
    let createdAt, updatedAt: String?
    let pivot: CoursePivot?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case type
        case socialID = "social_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
    }
}

// MARK: - Review

struct Review: Codable {
    let id: Int?
    let userID: UserID?
    let content: String?
    let rating: Int?
    let updatedAt: String?
    let createdAt: String?
    let pivot: ReviewPivot?
    
    let profile:RveiwerProfile?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case content, rating
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pivot,profile
        
    }
}


// MARK: - Profile

struct RveiwerProfile: Codable {
    let id, userID: Int?
    let image: String?
    let userCategory, courseLevel: Int?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image
        case userCategory = "user_category"
        case courseLevel = "course_level"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}


// MARK: - UserID
struct UserID: Codable {
    let id: Int?
    let name: String?
}

// MARK: - ReviewPivot

struct ReviewPivot: Codable {
    let courseID, reviewID: Int?

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case reviewID = "review_id"
    }
}

// MARK: - Pivot
struct CoursePivot: Codable {
    let courseID, userID: Int?

    enum CodingKeys: String, CodingKey {
        case courseID = "course_id"
        case userID = "user_id"
    }
}

// MARK: - VideoSection
struct VideoSection: Codable {
    let id, courseID: Int?
    let title: String?
    var video: [Video]?

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case title, video
    }
}

// MARK: - Video
struct Video: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let sectionID: Int?
    let type, title: String?
    let resource: String?
    let thumbnail: String?
    let size: String?
    var view: Int?
    let duration, updatedAt, createdAt: String?
    let locked: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case sectionID = "section_id"
        case type, title, resource, thumbnail, size, view, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case locked = "locked"
    }
}
