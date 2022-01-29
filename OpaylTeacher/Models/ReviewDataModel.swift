//
//  ReviewDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 26/11/21.
//

import Foundation

// MARK: - ReviewsListing

struct ReviewsListing: Codable {
    
    let id, userID, serviceID: Int?
    let title, reviewsListingDescription: String?
    let type: Int?
    let price: String?
    let thumbnail: String?
    let reviews, rating, hours, lesson: String?
    let duration, updatedAt: String?
    let createdAt: String?
    let review: [Review]?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case title
        case reviewsListingDescription = "description"
        case type, price, thumbnail, reviews, rating, hours, lesson, duration
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case review
    }
}
