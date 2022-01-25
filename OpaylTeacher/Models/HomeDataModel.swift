//
//  HomeDataModel.swift
//  IletsLearning
//
//  Created by OPAYN on 11/01/22.
//

import Foundation

// MARK: - HomeDataModel
struct HomeDataModel: Codable {
    let slider: [HomeSlider]?
    let info: HomeInfo?
    let about: HomeAbout?
    let availableClass: HomeAvailableClass?
    let mentors: HomeMentors?
    let packages: HomePackages?
    let testimonials: [Testimonial]?

    enum CodingKeys: String, CodingKey {
        case slider, info, about
        case availableClass = "available_class"
        case mentors, packages, testimonials
    }
}

// MARK: - About
struct HomeAbout: Codable {
    let aboutDescription: String?

    enum CodingKeys: String, CodingKey {
        case aboutDescription = "description"
    }
}

// MARK: - AvailableClass
struct HomeAvailableClass: Codable {
    let currentPage: Int?
    let data: [HomeAvailableClassDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [HomeLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - AvailableClassDatum
struct HomeAvailableClassDatum: Codable {
    let id, teacherID, serviceID: Int?
    let serviceCatID: Int?
    let title: String?
    let thumbnail: String?
    let startDate, endDate: String?
    let seat: Int?
    let duration: String?
    let price: Int?
    let content: String?
    let dayTime: Int?
    let reviewCount: Double?
    let rating:Double?
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

// MARK: - Link
struct HomeLink: Codable {
    let url: String?
    let label: String?
    let active: Bool?
}

// MARK: - Info
struct HomeInfo: Codable {
    let totalUser, totalTeacher, totalClass: Int?

    enum CodingKeys: String, CodingKey {
        case totalUser = "total_user"
        case totalTeacher = "total_teacher"
        case totalClass = "total_class"
    }
}

// MARK: - Mentors
struct HomeMentors: Codable {
    let currentPage: Int?
    let data: [HomeMentorsDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [HomeLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - MentorsDatum
struct HomeMentorsDatum: Codable {
    let id: Int?
    let name, email, introduction, datumDescription: String?
    let emailVerifiedAt: String?
    let socialID, firebaseToken, userCategory, courseLevel: String?
    let timezone, contactNumber: String?
    let experience, status: Int?
    let merithubUserID: String?
    let image: String?
    let introVideo, deletedAt: String?
    let createdAt, updatedAt: String?
    let userService: [HomeUserService]?
    let documents: [Document]?
    let userQualifications: [UserQualification]?
    let teacher_class_count , class_students_count:Int?

    enum CodingKeys: String, CodingKey {
        case id, name, email, introduction
        case datumDescription = "description"
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
        case documents
        case userQualifications = "user_qualifications"
        case teacher_class_count
        case class_students_count
    }
}



// MARK: - Document
struct Document: Codable {
    let id, userID: Int?
    let title, document, type, createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case title, document, type
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UserQualification
struct UserQualification: Codable {
    let id, userID, qualificationID: Int?
    let createdAt, updatedAt: String?
    let qualification: HomeQualification?

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
struct HomeQualification: Codable {
    let id: Int?
    let title, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - UserService
struct HomeUserService: Codable {
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

// MARK: - ServiceID
struct ServiceID: Codable {
    let id: Int?
    let name: String?
}

// MARK: - Packages
struct HomePackages: Codable {
    let currentPage: Int?
    let data: [HomePackagesDatum]?
    let firstPageURL: String?
    let from, lastPage: Int?
    let lastPageURL: String?
    let links: [HomeLink]?
    let nextPageURL: String?
    let path: String?
    let perPage: Int?
    let prevPageURL: String?
    let to, total: Int?

    enum CodingKeys: String, CodingKey {
        case currentPage = "current_page"
        case data
        case firstPageURL = "first_page_url"
        case from
        case lastPage = "last_page"
        case lastPageURL = "last_page_url"
        case links
        case nextPageURL = "next_page_url"
        case path
        case perPage = "per_page"
        case prevPageURL = "prev_page_url"
        case to, total
    }
}

// MARK: - PackagesDatum
struct HomePackagesDatum: Codable {
    let id: Int?
    let title: String?
    let price: Int?
    let coursesCount: Int?
    let studyMaterialCount: Int?
    let mockTestCount:Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case price
        case coursesCount = "courses_count"
        case studyMaterialCount = "studyMaterial_count"
        case mockTestCount = "mockTest_count"
    }
}

// MARK: - Slider
struct HomeSlider: Codable {
    let id, serviceID: Int?
    let title: String?
    let image: String?
    let content, createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case serviceID = "service_id"
        case title, image, content
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - Testimonial
struct Testimonial: Codable {
    let id: Int?
    let title, designation, testimonialDescription: String?
    let image: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id, title, designation
        case testimonialDescription = "description"
        case image
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}
