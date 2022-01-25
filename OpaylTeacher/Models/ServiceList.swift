//
//  ServiceList.swift
//  IletsLearning
//
//  Created by OPAYN on 29/10/21.
//

import Foundation

// MARK: - ServiceList
struct ServiceList: Codable {
    let id: Int?
    let name, updatedAt, createdAt: String?
    let category: [Category]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case category
    }
}

// MARK: - Category
struct Category: Codable {
    let id, serviceID: Int?
    let name: String?
    let content: [String]?
    let image: String?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name, content, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
