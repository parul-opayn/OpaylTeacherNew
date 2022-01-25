//
//  PackagesModel.swift
//  IletsLearning
//
//  Created by OPAYN on 09/11/21.
//

import Foundation

// MARK: - Package

struct Package: Codable {
    let id: Int?
    let title, price, duration: String?
    let videosCount, studyMaterialCount, mockTestCount: Int?

    enum CodingKeys: String, CodingKey {
        case id, title, price, duration
        case videosCount = "videos_count"
        case studyMaterialCount = "study_material_count"
        case mockTestCount = "mock_test_count"
    }
}

typealias Packages = [Package]
