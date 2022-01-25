//
//  IeltsReadingModel.swift
//  IletsLearning
//
//  Created by OPAYN on 29/10/21.
//

import Foundation

// MARK: - IeltsReadingModel

struct IeltsReadingModel: Codable {
    let id, serviceID: Int?
    let name: String?
    let content: [String]?
    let image: String?
    let updatedAt, createdAt: String?
    //let resouce: [Resouce]?
    let test: [Test]?
    let video: [Videos]?
    let studyMaterial: [StudyMaterials]?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case name, content, image
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case test
        case video = "video"
        case studyMaterial = "study_material"
    }
}

// MARK: - StudyMaterial

struct StudyMaterials: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let type: Int?
    let title: String?
    let resourceID: Int?
    let updatedAt, createdAt: String?
    let resource: Resouce?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title
        case resourceID = "resource_id"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case resource
    }
}

// MARK: - Video

struct Videos: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let title: String?
    let thumbnail: String?
    let video: String?
    let updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case title, thumbnail, video
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}


// MARK: - Resouce
struct Resouce: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let type, title: String?
    let resource: String?
    let thumbnail: String?
    let size, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type, title, resource, thumbnail, size
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - Test
struct Test: Codable {
    let id, serviceID, serviceCategoryID, userID: Int?
    let type: Int?
    let title: String?
    let locked: Int?
    let timing, testDescription, updatedAt, createdAt: String?
    let views, attempt: String?
    let noOfQuestion:Int?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case serviceCategoryID = "service_category_id"
        case userID = "user_id"
        case type, title, locked, timing
        case testDescription = "description"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case noOfQuestion = "no_of_question"
        case views, attempt
    }
}
