//
//  FavoriteDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 26/11/21.
//

import Foundation

struct FavouriteDateModel: Codable {
    let userID: Int?
    let courseID, updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case courseID = "course_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
