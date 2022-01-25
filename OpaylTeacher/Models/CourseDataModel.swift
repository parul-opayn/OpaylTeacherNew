//
//  CourseDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 01/11/21.
//

import Foundation

// MARK: - CoursesDataModelElement

struct CoursesDataModelElement: Codable {
    let id: Int?
    let name: String?
    let course: [Course]?
}

// MARK: - Course

struct Course: Codable {
  
    let id, userID, serviceID: Int?
    let title, courseDescription: String?
    let type: Int?
    let price: Double?
    let thumbnail: String?
    let reviews, rating: String?
    let hours: String?
    let lesson: Int?
    let duration: String?
    let updatedAt, createdAt: String?
    let video_count:Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case title
        case courseDescription = "description"
        case type, price, thumbnail, reviews, rating, hours, lesson, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case video_count
    }
}


typealias CoursesDataModel = [CoursesDataModelElement]
