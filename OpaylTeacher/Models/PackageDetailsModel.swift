//
//  File.swift
//  IletsLearning
//
//  Created by OPAYN on 03/12/21.
//

import Foundation

// MARK: - PackageDetailsModel

struct PackageDetailsModel: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let type: Int?
    let title, content, price: String?
    let thumbnail: String?
    let duration, rating: String?
    let updatedAt, createdAt: String?
    let courses: [Courses]?
    let studyMaterial: [StudyMaterial]?
    let mockTest: [MockTest]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title, content, price, thumbnail, duration, rating
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case courses
        case studyMaterial = "study_material"
        case mockTest = "mock_test"
    }
}

// MARK: - MockTestPivot

struct MockTestPivot: Codable {
    let packageID, testID: Int?

    enum CodingKeys: String, CodingKey {
        case packageID = "package_id"
        case testID = "test_id"
    }
}

// MARK: - MockTest
struct MockTest: Codable {
    let id, serviceID, serviceCategoryID, userID: Int?
    let type: Int?
    let title: String?
    let locked: Int?
    let timing, mockTestDescription: String?
    let price: String?
    let status: Int?
    let updatedAt, createdAt: String?
    let noOfQuestion: Int?
    let views, attempt: String?
    let pivot: MockTestPivot?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case serviceCategoryID = "service_category_id"
        case userID = "user_id"
        case type, title, locked, timing
        case mockTestDescription = "description"
        case price, status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case noOfQuestion = "no_of_question"
        case views, attempt, pivot
    }
}

// MARK: - StudyMaterial
struct StudyMaterial: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let type: Int?
    let title: String?
    let resourceID: Int?
    let updatedAt, createdAt: String?
    let pivot: StudyMaterialPivot?
    let resource: Resource?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title
        case resourceID = "resource_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pivot, resource
    }
}

// MARK: - StudyMaterialPivot
struct StudyMaterialPivot: Codable {
    let packageID, studyMaterialID: Int?

    enum CodingKeys: String, CodingKey {
        case packageID = "package_id"
        case studyMaterialID = "study_material_id"
    }
}

// MARK: - Resource
struct Resource: Codable {
    let id, userID: Int?
    let serviceID, serviceCatID, sectionID: String?
    let type, title: String?
    let resource: String?
    let thumbnail: String?
    let size: String?
    let view, duration: String?
    let locked: Int?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case sectionID = "section_id"
        case type, title, resource, thumbnail, size, view, duration, locked
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}


struct Courses: Codable {
    let id, userID, serviceID: Int?
    let title, courseDescription: String?
    let type: Int?
    let price: Double?
    let thumbnail: String?
    let reviews: String?
    let rating, hours: String?
    let lesson, duration: String?
    let updatedAt, createdAt: String?
    let pivot: CoursePivot?
    let videoSection: [VideoSection]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case title
        case courseDescription = "description"
        case type, price, thumbnail, reviews, rating, hours, lesson, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pivot
        case videoSection = "video_section"
    }
}
