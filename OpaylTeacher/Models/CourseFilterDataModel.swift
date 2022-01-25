//
//  CourseFilterDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 03/11/21.
//

import Foundation
// MARK: - CourseFilterDataModelElement
struct CourseFilterDataModelElement: Codable {
    let id: Int?
    let name: String?
}

typealias CourseFilterDataModel = [CourseFilterDataModelElement]

struct Filter{
    var heading: String
    var subHeading: [subFilter]
    var collapsed:Bool
}

struct subFilter{
    var viewName: String
    var viewId: String
}


// MARK: - ClassFilterDataModel
struct ClassFilterDataModel: Codable {
    let services: [Classses]?
    let classShift: [Int]?
    let sortBy: [String]?

    enum CodingKeys: String, CodingKey {
        case services
        case classShift = "class_shift"
        case sortBy = "sort_by"
    }
}

// MARK: - Service
struct Classses: Codable {
    let id: Int?
    let name: String?
}
