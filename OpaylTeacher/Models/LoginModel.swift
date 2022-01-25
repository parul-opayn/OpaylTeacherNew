import Foundation

// MARK: - LoginModel
struct LoginModel: Codable {
    let id: Int?
    let name, email: String?
    let introduction, loginModelDescription: String?
    let emailVerifiedAt: String?
    let socialID, firebaseToken: String?
    let userCategory: UserCategory?
    let courseLevel: Int?
    let timezone, contactNumber: String?
    let experience: String?
    let status: Int?
    let merithubUserID, image, introVideo, deletedAt: String?
    let createdAt, updatedAt: String?
    let userService: [UserService]?

    enum CodingKeys: String, CodingKey {
        case id, name, email, introduction
        case loginModelDescription = "description"
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
        case userService = "user_service"
    }
}

// MARK: - UserCategory
struct UserCategory: Codable {
    let id: Int?
    let name, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UserService
struct UserService: Codable {
    let id, userID:Int?
    let serviceID: Int?
    let createdAt, updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case serviceID = "service_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


// MARK: - LoginModel
//
//struct LoginModel: Codable {
//    let id: Int?
//    let name, email: String?
//    let emailVerifiedAt: String?
//    let createdAt, updatedAt: String?
//    let profile:Profile?
//
//    enum CodingKeys: String, CodingKey {
//        case id, name, email
//        case emailVerifiedAt = "email_verified_at"
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case profile = "profile"
//    }
//}
//
//// MARK: - Profile
//
//struct Profile: Codable {
//    let createdAt: String?
//    let id: Int?
//    let image: String?
//    let updatedAt: String?
//    let userID: Int?
//    let user_category:UserCategory?
//
//    enum CodingKeys: String, CodingKey {
//        case createdAt = "created_at"
//        case id, image
//        case updatedAt = "updated_at"
//        case userID = "user_id"
//        case user_category = "user_category"
//    }
//}
//
//struct UserCategory:Codable{
//    let id:String?
//    let title:String?
//
//    enum CodingKeys:String,CodingKey{
//        case id = "id"
//        case title = "title"
//    }
//}
//
