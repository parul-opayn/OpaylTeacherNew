//
//  TicketsModel.swift
//  IletsLearning
//
//  Created by OPAYN on 09/11/21.
//

import Foundation

// MARK: - Issue
struct Issue: Codable {
    let issueDescription: String?

    enum CodingKeys: String, CodingKey {
        case issueDescription = "description"
    }
}

typealias Issues = [Issue]
