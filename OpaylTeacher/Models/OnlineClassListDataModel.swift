//
//  OnlineClassListDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 17/12/21.
//

import Foundation

// MARK: - OnlineClassListDataModelElement

struct OnlineClassListDataModelElement: Codable {
    
    let id, teacherID, service: Int?
    let serviceCategory: Int?
    let title: String?
    let thumbnail: String?
    let seat: Int?
    let startDate, endDate, duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let updatedAt, createdAt: String?
    let teacher: Teachers?
    let review_count:Int?
    let rating:Double?

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
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case teacher
        case review_count
        case rating
    }
}

// MARK: - Teacher
struct Teachers: Codable {
    let id: Int?
    let name: String?
    let profile: TeacherProfiles?
}

// MARK: - Profile
struct TeacherProfiles: Codable {
    let id, userID: Int?
    let experience: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case experience
    }
}

typealias OnlineClassListDataModel = [OnlineClassListDataModelElement]
