//
//  FAQDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 09/11/21.
//

import Foundation

// MARK: - FAQDataModelElement

struct FAQDataModelElement: Codable {
    let id: Int?
    let question, answer, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id, question, answer
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

typealias FAQDataModel = [FAQDataModelElement]
