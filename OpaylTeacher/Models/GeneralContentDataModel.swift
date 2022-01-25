//
//  GeneralContentDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 28/10/21.
//

import Foundation

// MARK: - GeneralContentModel

struct GeneralContentModel: Codable {
    let id, userID: Int?
    let serviceID, serviceCatID: String?
    let type, generalContentModelDescription, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type
        case generalContentModelDescription = "description"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
