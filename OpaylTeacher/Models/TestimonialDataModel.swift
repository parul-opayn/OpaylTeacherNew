//
//  TestimonialDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 09/11/21.
//

import Foundation
// MARK: - TestimonialDataModelElement
struct TestimonialDataModelElement: Codable {
    let id: Int
    let title, designation, testimonialDataModelDescription: String
    let image: String
    let updatedAt: String?
    let createdAt: String

    enum CodingKeys: String, CodingKey {
        case id, title, designation
        case testimonialDataModelDescription = "description"
        case image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

typealias TestimonialDataModel = [TestimonialDataModelElement]
