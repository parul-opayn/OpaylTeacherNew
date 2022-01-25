//
//  ClassCheckoutDataModel.swift
//  IletsLearning
//
//  Created by OPAYN LLC on 17/12/21.
//

import Foundation
// MARK: - ClassCheckoutDataModel
struct ClassCheckoutDataModel: Codable {
    let userID: Int?
    let transactionID: String?
    let gatewayTransactionID: String?
    let onlineClassID, status: Int?
    let price:Double?
    let updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case userID = "user_id"
        case transactionID = "transaction_id"
        case gatewayTransactionID = "gateway_transaction_id"
        case onlineClassID = "online_class_id"
        case price, status
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}
