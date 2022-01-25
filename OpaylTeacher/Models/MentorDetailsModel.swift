//
//  MentorDetailsModel.swift
//  IletsLearning
//
//  Created by OPAYN on 11/01/22.
//

import Foundation

// MARK: - MentorDetailDataModel

struct MentorDetailDataModel: Codable {
    let data: MentorDataClass?
    let message: String?
    let code: Int?
}

// MARK: - DataClass

struct MentorDataClass: Codable {
    let id: Int?
    let name, email, introduction, dataDescription: String?
    let emailVerifiedAt: String?
    let socialID, firebaseToken, userCategory, courseLevel: String?
    let timezone, contactNumber: String?
    let experience, status: Int?
    let merithubUserID: String?
    let image: String?
    let introVideo, deletedAt: String?
    let createdAt, updatedAt: String?
    let mentorService: [MentorService]?
    let documents: [MentorDocument]?
    let userQualifications: [MentorUserQualification]?
    let teacherClass: [MentorClass]?
    let roles: [MentorRole]?
    

    enum CodingKeys: String, CodingKey {
        case id, name, email, introduction
        case dataDescription = "description"
        case emailVerifiedAt = "email_verified_at"
        case socialID = "social_id"
        case firebaseToken = "firebase_token"
        case userCategory = "user_category"
        case courseLevel = "course_level"
        case timezone
        case contactNumber = "contact_number"
        case experience, status
        case merithubUserID = "merithub_user_id"
        case image
        case introVideo = "intro_video"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case mentorService = "mentor_service"
        case documents
        case userQualifications = "user_qualifications"
        case teacherClass = "teacher_class"
        case roles
    }
}

// MARK: - Document

struct MentorDocument: Codable {
    let id, userID: Int?
    let title: String?
    let document: String?
    let type, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, document, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - MentorService

struct MentorService: Codable {
    let id, userID: Int?
    let serviceID: ServiceID?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - Role
struct MentorRole: Codable {
    let id: Int?
    let name, guardName, createdAt, updatedAt: String?
    let pivot: Pivot?

    enum CodingKeys: String, CodingKey {
        case id, name
        case guardName = "guard_name"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pivot
    }
}

// MARK: - TeacherClass
struct MentorClass: Codable {
    let id, teacherID, serviceID, serviceCatID: Int?
    let title: String?
    let thumbnail: String?
    let startDate, endDate: String?
    let seat: Int?
    let duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let rating, reviewCount: Double?
    let classStatus: Int?
    let merithubClassID, hostURL, participantURL, meetingURL: String?
    let deletedAt: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case teacherID = "teacher_id"
        case serviceID = "service_id"
        case serviceCatID = "service_cat_id"
        case title, thumbnail
        case startDate = "start_date"
        case endDate = "end_date"
        case seat, duration, price, content
        case dayTime = "day_time"
        case rating
        case reviewCount = "review_count"
        case classStatus = "class_status"
        case merithubClassID = "merithub_class_id"
        case hostURL = "host_url"
        case participantURL = "participant_url"
        case meetingURL = "meeting_url"
        case deletedAt = "deleted_at"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UserQualification
struct MentorUserQualification: Codable {
    let id, userID, qualificationID: Int?
    let createdAt, updatedAt: String?
    let qualification: MentorQualification?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case qualificationID = "qualification_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case qualification
    }
}

// MARK: - Qualification
struct MentorQualification: Codable {
    let id: Int?
    let title, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


//// MARK: - MentorDetailDataModel
//struct MentorDetailDataModel: Codable {
//    let data: ?
//    let message: String?
//    let code: Int?
//}
//
//// MARK: - DataClass
//struct MentorDataClass: Codable {
//    let id: Int?
//    let name, email: String?
//    let emailVerifiedAt: String?
//    let type, status: Int?
//    let socialID, firebaseToken: String?
//    let timezone: String?
//    let merithubUserID, deletedAt: String?
//    let createdAt, updatedAt: String?
//    let profile: MentorProfile?
//    let mentorService: [MentorService]?
//    let roles: [MentorRole]?
//    let teacher_class : [MentorClass]?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, email
//        case emailVerifiedAt = "email_verified_at"
//        case type, status
//        case socialID = "social_id"
//        case firebaseToken = "firebase_token"
//        case timezone
//        case merithubUserID = "merithub_user_id"
//        case deletedAt = "deleted_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case profile
//        case mentorService = "mentor_service"
//        case roles
//        case teacher_class
//    }
//}
//
//// MARK: - MentorService
//struct MentorService: Codable {
//    let id, userID: Int?
//    let serviceID: ServiceID?
//    let updatedAt, createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case serviceID = "service_id"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//    }
//}
//
//
//// MARK: - Profile
//struct MentorProfile: Codable {
//    let id, userID: Int?
//    let image: String?
//    let userCategory, courseLevel: Int?
//    let updatedAt, createdAt, contactNumber, experience: String?
//    let qualification: MentorQualification?
//    let document: String?
//    let introduction, profileDescription: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case userID = "user_id"
//        case image
//        case userCategory = "user_category"
//        case courseLevel = "course_level"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//        case contactNumber = "contact_number"
//        case experience, qualification, document, introduction
//        case profileDescription = "description"
//    }
//}
//
//struct MentorQualification:Codable{
//    let id:Int?
//    let title:String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case title
//    }
//}
//
//// MARK: - Role
//struct MentorRole: Codable {
//    let id: Int?
//    let name, guardName, createdAt, updatedAt: String?
//    let pivot: MentorPivot?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name
//        case guardName = "guard_name"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case pivot
//    }
//}
//
//// MARK: - Pivot
//struct MentorPivot: Codable {
//    let modelID, roleID: Int?
//    let modelType: String?
//
//    enum CodingKeys: String, CodingKey {
//        case modelID = "model_id"
//        case roleID = "role_id"
//        case modelType = "model_type"
//    }
//}
//
//// MARK: - MentorClass
//struct MentorClass: Codable {
//    let id, teacherID, service, serviceCategory: Int?
//    let title: String?
//    let thumbnail: String?
//    let seat: Int?
//    let startDate, endDate, duration: String?
//    let price: Int?
//    let content: String?
//    let dayTime: Int?
//    let rating, reviewCount: Int?
//    let classStatus: Int?
//let meetingLink: String?
//    let merithubClassID: String?
//    let hostURL: String?
//    let participantURL: String?
//    let updatedAt, createdAt: String?
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case teacherID = "teacher_id"
//        case service
//        case serviceCategory = "service_category"
//        case title, thumbnail, seat
//        case startDate = "start_date"
//        case endDate = "end_date"
//        case duration, price, content
//        case dayTime = "day_time"
//        case rating
//        case reviewCount = "review_count"
//        case classStatus = "class_status"
//        case meetingLink = "meeting_link"
//        case merithubClassID = "merithub_class_id"
//        case hostURL = "host_url"
//        case participantURL = "participant_url"
//        case updatedAt = "updated_at"
//        case createdAt = "created_at"
//    }
//}
