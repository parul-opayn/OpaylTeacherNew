//
//  WalkthroughDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 08/11/21.
//

import Foundation
// MARK: - WalkThroughDataModel
struct WalkThroughDataModel: Codable {
    let contents: [Content]?
    let userCategory, services, levels: [Level]?

    enum CodingKeys: String, CodingKey {
        case contents
        case userCategory = "user_category"
        case services, levels
    }
}

// MARK: - Content
struct Content: Codable {
    let id, userID: Int?
    let serviceID, serviceCatID: Int?
    let type, title, contentDescription, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title
        case contentDescription = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Level
struct Level: Codable {
    let id: Int?
    let name: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
