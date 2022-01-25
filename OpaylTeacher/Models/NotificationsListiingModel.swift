//
//  NotificationsListiingModel.swift
//  IletsLearning
//
//  Created by OPAYN on 18/01/22.
//

import Foundation

// MARK: - NotificationsModel

struct NotificationsModelElement: Codable {
    let id: Int?
    let type: String?
    let userID: Int?
    let onlineClassID: [NotificationOnlineClassID]?
    let courseID, packageID: String?
    let title, message, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, type
        case userID = "user_id"
        case onlineClassID = "online_class_id"
        case courseID = "course_id"
        case packageID = "package_id"
        case title, message
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - OnlineClassID
struct NotificationOnlineClassID: Codable {
    let id, teacherID, serviceID, serviceCatID: Int?
    let title: String?
    let thumbnail: String?
    let startDate, endDate: String?
    let seat: Int?
    let duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let rating, reviewCount: Double?
    let classStatus: Int?
    let merithubClassID, hostURL, participantURL, meetingURL: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case teacherID = "teacher_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case title, thumbnail
        case startDate = "start_date"
        case endDate = "end_date"
        case seat, duration, price, content
        case dayTime = "day_time"
        case rating
        case reviewCount = "review_count"
        case classStatus = "class_status"
        case merithubClassID = "merithub_class_id"
        case hostURL = "host_url"
        case participantURL = "participant_url"
        case meetingURL = "meeting_url"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Link
struct Link: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}

typealias NotificationsModel = [NotificationsModelElement]
