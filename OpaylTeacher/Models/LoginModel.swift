import Foundation

// MARK: - DataClass
// MARK: - LoginModel
struct LoginModel: Codable {
    let status: Int?
    let image: String?
    let updatedAt: String?
    let merithubUserID: String?
    let contactNumber: String?
    let socialID: String?
    let userService: [UserService]?
    let name: String?
    let courseLevel: Int?
    let id: Int?
    let firebaseToken, introVideo: String?
    let email: String?
    let deletedAt: String?
    let roles: [Role]?
    let timezone, introduction, emailVerifiedAt: String?
    let userCategory: String?
    let experience:VariacType?
    let accountVerificationStatus: Int?
    let createdAt, loginModelDescription: String?

    enum CodingKeys: String, CodingKey {
        case status, image
        case updatedAt = "updated_at"
        case merithubUserID = "merithub_user_id"
        case contactNumber = "contact_number"
        case socialID = "social_id"
        case userService = "user_service"
        case name
        case courseLevel = "course_level"
        case id
        case firebaseToken = "firebase_token"
        case introVideo = "intro_video"
        case email
        case deletedAt = "deleted_at"
        case roles, timezone, introduction
        case emailVerifiedAt = "email_verified_at"
        case userCategory = "user_category"
        case experience
        case accountVerificationStatus = "account_verification_status"
        case createdAt = "created_at"
        case loginModelDescription = "description"
    }
}

// MARK: - Role
struct Role: Codable {
    let pivot: Pivot?
    let id: Int?
    let guardName, name, updatedAt, createdAt: String?

    enum CodingKeys: String, CodingKey {
        case pivot, id
        case guardName = "guard_name"
        case name
        case updatedAt = "updated_at"
        case createdAt = "created_at"
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


public enum VariacType:Codable{
    
    public func encode(to encoder: Encoder) throws {
        
    }
    
    case int(Int)
    case double(Double)
    case string(String)
    
    public init(from decoder: Decoder) throws {
        if let intValue = try? decoder.singleValueContainer().decode(Int.self)  {
            self = .int(intValue)
            return
        }
        if let stringValue = try? decoder.singleValueContainer().decode(String.self){
            self = .string(stringValue)
            return
        }
        if let doubleValue = try? decoder.singleValueContainer().decode(Double.self){
            self = .double(doubleValue)
            return
        }
        throw VariacError.missingValue
    }
    
    
    enum VariacError: Error {
        case missingValue
    }
}

extension VariacType {
    var Value:String {
        switch self {
        case .int(let intvalue):
            return String(intvalue)
        case .string(let stringValue):
            return stringValue
        case .double(let doubleValue):
            return String(doubleValue)
        }
    }
    
}
