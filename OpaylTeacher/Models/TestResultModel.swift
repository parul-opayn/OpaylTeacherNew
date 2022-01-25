//
//  TestResultModel.swift
//  IletsLearning
//
//  Created by OPAYN on 12/11/21.
//

import Foundation

// MARK: - ResultModel

struct ResultModel: Codable {
    
    let correctAnswer, incorrectAnswer: Int?
    let score: Double?
    let totalQuestion: Int?
    
    enum CodingKeys: String, CodingKey {
        case correctAnswer = "correct_answer"
        case incorrectAnswer = "incorrect_answer"
        case score
        case totalQuestion = "total_question"
    }
    
}
