//
//  MyPackagesDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 16/11/21.
//

import Foundation

// MARK: - MyPackagesDataModel
struct MyPackagesDataModel: Codable {
    let id: Int?
    let name, email, emailVerifiedAt: String?
    let type: Int?
    let createdAt, updatedAt: String?
    var myPackages: [MyPackage]?

    enum CodingKeys: String, CodingKey {
        case id, name, email
        case emailVerifiedAt = "email_verified_at"
        case type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case myPackages = "my_packages"
    }
}

// MARK: - MyPackage
struct MyPackage: Codable {
    let id, serviceID, serviceCatID, type: Int?
    let title: String?
    let content: [String]?
    let price, duration: String?
    let updatedAt: String?
    let createdAt: String?
    let pivot: MyPackagePivot?
    let packageCourse: [PackageCourse]?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title, content, price, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pivot
        case packageCourse = "package_course"
    }
}

// MARK: - PackageCourse
struct PackageCourse: Codable {
    let id, userID, serviceID: Int?
    let title, packageCourseDescription, price: String?
    let thumbnail: String?
    let reviews, rating: String?
    let hours, lesson: Int?
    let duration, updatedAt, createdAt: String?
    let pivot: PackageCoursePivot?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case title
        case packageCourseDescription = "description"
        case price, thumbnail, reviews, rating, hours, lesson, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case pivot
    }
}

// MARK: - PackageCoursePivot
struct PackageCoursePivot: Codable {
    let packageID, courseID: Int?

    enum CodingKeys: String, CodingKey {
        case packageID = "package_id"
        case courseID = "course_id"
    }
}


// MARK: - PackageCoursDataModelElement
struct PackageCoursDataModelElement: Codable {
    let id, serviceID: Int?
    let serviceCatID: Int?
    let type: Int?
    let title, content: String?
    let price: Double?
    let thumbnail: String?
    let duration: String?
    let updatedAt: String?
    let createdAt: String?
    let videosCount, studyMaterialCount, mockTestCount: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title, content, price, thumbnail, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case videosCount = "videos_count"
        case studyMaterialCount = "study_material_count"
        case mockTestCount = "mock_test_count"
    }
}

typealias PackageCoursDataModel = [PackageCoursDataModelElement]
