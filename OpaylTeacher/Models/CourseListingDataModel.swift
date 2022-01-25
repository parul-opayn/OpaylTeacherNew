//
//  CourseListingDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 01/11/21.
//

import Foundation

// MARK: - CourseListingDataModelElement
// MARK: - CourseListingDataModel
struct CourseListingDataModel: Codable {
    var courses: [Course]?
    var sortBy: [String]?
        let total: Int?

        enum CodingKeys: String, CodingKey {
            case courses
            case sortBy = "sort_by"
            case total
        }
    
}

// MARK: - Course
struct SearchedCourse: Codable {
    let id, userID, serviceID: Int?
        let title, courseDescription: String?
        let type: Int?
        let price: String?
        let thumbnail: String?
        let reviews, rating, hours: String?
        let lesson: Int?
        let duration: String?
        let updatedAt, createdAt: String?
        let videoCount: Int?

        enum CodingKeys: String, CodingKey {
            case id
            case userID = "user_id"
            case serviceID = "service_id"
            case title
            case courseDescription = "description"
            case type, price, thumbnail, reviews, rating, hours, lesson, duration
            case updatedAt = "updated_at"
            case createdAt = "created_at"
            case videoCount = "video_count"
        }
}


