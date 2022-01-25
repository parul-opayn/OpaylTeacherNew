//
//  GuestEmailDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 12/11/21.
//

import Foundation


// MARK: - GuestEmailDataModel

struct GuestEmailDataModel: Codable {
    let code: Int?
    let createdAt, expiryTime: String?
    let id: Int?
    let updatedAt: String?
    let userID: Int?

    enum CodingKeys: String, CodingKey {
        case code
        case createdAt = "created_at"
        case expiryTime = "expiry_time"
        case id
        case updatedAt = "updated_at"
        case userID = "user_id"
    }
}
