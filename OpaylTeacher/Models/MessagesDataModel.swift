//
//  MessagesDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 25/11/21.
//

import Foundation

// MARK: - Message

struct Message: Codable {
    let id, courseID: Int?
    let userID: UserID?
    let tutorID: Int?
    let message: String?
    let updatedAt: String?
    let createdAt: String?
    let attachment:String?

    enum CodingKeys: String, CodingKey {
        case id
        case courseID = "course_id"
        case userID = "user_id"
        case tutorID = "tutor_id"
        case message
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case attachment = "attachment"
    }
}
typealias Messages = [Message]
