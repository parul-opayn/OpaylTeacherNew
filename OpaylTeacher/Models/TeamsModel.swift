//
//  TeamsModel.swift
//  IletsLearning
//
//  Created by OPAYN on 08/11/21.
//

import Foundation

// MARK: - TeamsModelElement

struct TeamsModelElement: Codable {
    let id: Int?
    let name, designation: String?
    let image: String?
    let updatedAt: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name, designation, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

typealias TeamsModel = [TeamsModelElement]
