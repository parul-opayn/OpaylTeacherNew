//
//  TestModel.swift
//  IletsLearning
//
//  Created by OPAYN on 29/10/21.
//

import Foundation

// MARK: - TestModel
struct TestModel: Codable {
    let id, serviceID, userID: Int?
    let title: String?
    let locked: Int?
    let timing, testModelDescription, updatedAt, createdAt: String?
    let instruction: Instruction?
    var serviceCategoryID:SericeCategoryID?
    var questions: [Question]?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case serviceCategoryID = "service_category_id"
        case userID = "user_id"
        case title, locked, timing
        case testModelDescription = "description"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case instruction, questions
    }
}

// MARK: - SericeCategoryID

struct SericeCategoryID: Codable {
    let id: Int?
    let name: String?
}


// MARK: - Instruction
struct Instruction: Codable {
    let id, userID, serviceID, serviceCatID: Int?
    let type, instructionDescription, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case type
        case instructionDescription = "description"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

// MARK: - Question
struct Question: Codable {
    let id, testID, type: Int?
    let question, updatedAt, createdAt: String?
    let file:String?
    var answer: [Answer]?
    var duration:String?

    enum CodingKeys: String, CodingKey {
        case id
        case testID = "test_id"
        case type, question
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case file = "file"
        case answer
        case duration
    }
}

// MARK: - Answer
struct Answer: Codable {
    let id, questionID: Int?
    let answer: String?
    let correctAnswer: Int?
    let updatedAt, createdAt: String?
    var userAnswer:String?

    enum CodingKeys: String, CodingKey {
        case id
        case questionID = "question_id"
        case answer
        case correctAnswer = "correct_answer"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
    }
}

