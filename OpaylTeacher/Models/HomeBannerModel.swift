//
//  HomeBannerModel.swift
//  IletsLearning
//
//  Created by OPAYN on 29/10/21.
//

import Foundation

// MARK: - HomeBannerModel
struct HomeBannerModel: Codable {
    let slider: [Slider]?
    let about: About?
    let services: [Service]?
}

// MARK: - About
struct About: Codable {
    let aboutDescription: String?

    enum CodingKeys: String, CodingKey {
        case aboutDescription = "description"
    }
}

// MARK: - Service
struct Service: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Slider
struct Slider: Codable {
    let id, serviceID: Int?
    let title: String?
    let image: String?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case title, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}
