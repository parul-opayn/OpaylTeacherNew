//
//  TeacherServicesModel.swift
//  OpaylTeacher
//
//  Created by OPAYN on 27/01/22.
//

import Foundation

// MARK: - TeacherServicesDataModelElement
struct TeacherServicesDataModelElement: Codable {
    let id: Int?
    let name, createdAt, updatedAt: String?
    var isSelected:Bool?
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias TeacherServicesDataModel = [TeacherServicesDataModelElement]






// MARK: - TeacherQualificationsDataModelElement

struct TeacherQualificationsDataModelElement: Codable {
    let id: Int?
    let title, createdAt, updatedAt: String?
    var isSelected:Bool?

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias TeacherQualificationsDataModel = [TeacherQualificationsDataModelElement]
