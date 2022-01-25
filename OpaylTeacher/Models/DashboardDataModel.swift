//
//  DashboardDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 10/11/21.
//

import Foundation
// MARK: - DashboardDataModel
struct DashboardDataModel: Codable {
    let id: Int?
    let name, email, emailVerifiedAt: String?
    let type: Int?
    let createdAt, updatedAt: String?
    let popularCourses: [PopularCourse]?
    let recentlyViewed: [RecentlyViewed]?
    let results: [Result]?
    let myPackages: [AvailablePackage]?
    let availablePackages: [AvailablePackage]?
    let myCourses: [PopularCourse]?
    let myClasses: [MyClass]?
    let popularClass: [PopularClass]?
    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case popularCourses = "popular_courses"
        case availablePackages = "available_packages"
        case recentlyViewed = "recently_viewed"
        case results
        case myPackages = "my_packages"
        case myCourses = "my_courses"
        case myClasses = "my_classes"
        case popularClass = "popular_class"
  }
}

// MARK: - MyClass
struct MyClass: Codable {
    let id, userID: Int?
    let purchaseType: String?
    let onlineClassID: [PopularClass]?
    let paymentID: PaymentID?
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

// MARK: - PopularClass
struct PopularClass: Codable {
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
    let ratingCount: Int?
    let updatedAt, createdAt: String?
    let teacher: PopularClassTeacher?

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
        case ratingCount = "rating_count"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case teacher
    }
}

// MARK: - Teacher
struct PopularClassTeacher: Codable {
    let id: Int?
    let name, email: String?
    let emailVerifiedAt: String?
    let type, status: Int?
    let socialID, firebaseToken: String?
    let createdAt, updatedAt: String?
    let profile: PopularClassTeacherProfile?

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
struct PopularClassTeacherProfile: Codable {
    let id, userID: Int?
    let image: String?
    let userCategory: Int?
let courseLevel: Int?
    let contactNumber, experience, qualification: String?
    let document: String?
    let introduction, profileDescription, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case image
        case userCategory = "user_category"
        case courseLevel = "course_level"
        case contactNumber = "contact_number"
        case experience, qualification, document, introduction
        case profileDescription = "description"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - PaymentID
struct PaymentID: Codable {
    let id: Int?
    let transactionID, gatewayTransactionID: String?
    let onlineClassID, price, userID, status: Int?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case transactionID = "transaction_id"
        case gatewayTransactionID = "gateway_transaction_id"
        case onlineClassID = "online_class_id"
        case price
        case userID = "user_id"
        case status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - AvailablePackage
struct AvailablePackage: Codable {
    let id, serviceID, type: Int?
    let serviceCatID: Int?
    let title: String?
    let content, thumbnail: String?
    let price, duration: String?
    let updatedAt: String?
    let createdAt: String?
    let pivot: MyPackagePivot?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title, content, price, duration, thumbnail
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pivot
    }
}

// MARK: - MyPackagePivot
struct MyPackagePivot: Codable {
  let userID, packageID: Int?
  enum CodingKeys: String, CodingKey {
    case userID = "user_id"
    case packageID = "package_id"
  }
}
// MARK: - Pivot
struct Pivot: Codable {
  let userID, courseID: Int?
    enum CodingKeys: String, CodingKey {
      case userID = "user_id"
      case courseID = "course_id"
    }}
// MARK: - PopularCourse
struct PopularCourse: Codable {
  let id, userID, serviceID: Int?
    let title: String?
    let myCourseDescription: String?
    let type: Int?
    let video_count: Int?
    let price: String?
    let thumbnail: String?
    let reviews: String?
    let rating: String?
    let hours: String?
    let lesson: Int?
    let duration: String?
    let updatedAt, createdAt: String?
    let pivot: Pivot?
    enum CodingKeys: String, CodingKey {
      case id
      case userID = "user_id"
      case serviceID = "service_id"
      case title, video_count
      case myCourseDescription = "description"
      case type, price, thumbnail, reviews, rating, hours, lesson, duration
      case updatedAt = "updated_at"
      case createdAt = "created_at"
      case pivot
    }
}
// MARK: - RecentlyViewed
struct RecentlyViewed: Codable {
  let id: Int?
  let title: String?
  let thumbnail: String?
}
// MARK: - Result
struct Result: Codable {
  let id, userID: Int?
  let testID: TestID?
  let totalMarks: Int?
  let getMarks: Double?
  let updatedAt: String?
  let createdAt: String?
  enum CodingKeys: String, CodingKey {
    case id
    case userID = "user_id"
    case testID = "test_id"
    case totalMarks = "total_marks"
    case getMarks = "get_marks"
    case updatedAt = "updated_at"
    case createdAt = "created_at"
  }
}
// MARK: - TestID
struct TestID: Codable {
  let id: Int?
  let title: String?
}
