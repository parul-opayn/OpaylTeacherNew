//
//  ApisSuffix.swift
//  GoFitNUp
//
//  Created by Sourabh Mittal on 16/01/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation

enum APISuffix {
    
    case signUp
    case login
    case emailVerify
    case products
    case forgotPassword
    case resetPassword
    case changePassword
    case updateProfile
    case generalContent
    case sliderListing
    case serviceListing
    case serviceDetail(String)
    case categoryDetails(String,String)
    case test(String)
    case submitTest
    case guestEmailSubmission
    case allCourses(String)
    case courseListing
    case courseDetail(Int, String)
    case courseFilters
    case walkthrough
    case teams
    case contactUs
    case packages
    case faqs
    case testimonial
    case dashboard
    case buyCourse
    case myPackages
    case packageCourses
    case packageDetails(String)
    case resendCode
    case socialLogin
    case PaymentList
    case messages
    case message
    case review
    case addFavourate
    case startTest
    case onlineClassList(Int)
    case classFilter
    case classDetail(String, String)
    case classCheckout
    case classPaymentStatus
    case wishlist
    case track
    case applyCoupen
    case home
    case mentorDetail(String)
    case notifications
    case teacherServices
    case qualifications
    case addTeacher
    case teacherClassListing
    case updateTeacher
    case customUrl
    case generateLiveClass
    
    func getDescription() -> String {
        
        switch self {
        
        case .signUp :
            return "teacher/signup"
            //"sign-up"
            
        case .login :
            return "login"
            
        case .emailVerify:
            return "email-verify"
            
        case .products:
            return "products"
            
        case .forgotPassword:
            return "forgot-password"
            
        case .resetPassword:
            return "reset-password"
            
        case .changePassword:
            return "change-password"
            
        case .updateProfile:
            return "user/update"
            
        case .generalContent:
            return "general-content"
            
        case .sliderListing:
            return "sliderListing"
            
        case .serviceListing:
            return "service/listing"
            
        case .serviceDetail(let id):
            return "service/detail/\(id)"
            
        case .categoryDetails(let id, let type):
            return "category/\(id)?type=\(type)"
            
        case .test(let id):
            return "test/\(id)"
            
        case .submitTest:
            return "test/submit"
            
        case .guestEmailSubmission:
            return "test/result"
            
        case .allCourses(let word):
            return "courses?keyword=\(word)"
            
        case .courseListing:
            return "course/listing"
            
        case .courseDetail(let id, let userId):
            return "course/detail/\(id)?user_id=\(userId)"
            
        case .courseFilters:
            return "course/filters"
            
        case .walkthrough:
            return "walkthrough"
            
        case .teams:
            return "teams"
            
        case .contactUs:
            return "user/ticket"
            
        case .packages:
            return "packages"
            
        case .packageDetails(let id):
            return "package/detail/\(id)"
            
        case .faqs:
            return "faqs"
            
        case .testimonial:
            return "testimonials"
            
        case .dashboard:
            return "dashboard"
            
        case .buyCourse:
            return "course/buy"
            
        case .myPackages:
            return "my-packages"
            
        case .packageCourses:
            return "package/course/listing"
            
        case .resendCode:
            return "resend-code"
            
        case .socialLogin:
            return "social/login"
            
        case .PaymentList:
            return "teacher/payments"
            //"payment/list"
            
        case .messages:
            return "messages"
            
        case .message:
            return "message"
            
        case .review:
            return "review"
            
        case .addFavourate:
            return "add-favourate"
            
        case .startTest:
            return "test/start"
            
        case .onlineClassList(let page):
            return "class?page=\(page)"
            
        case .classFilter:
            return "class/filters"
            
        case .classDetail(let id, let userId):
            return "class/detail/\(id)?user_id=\(userId)"
            
        case .classCheckout:
            return "checkout"
            //"class/checkout"
            
        case .classPaymentStatus:
            return "update/payment/status"
            
        case .wishlist:
            return "wishlist"
            
        case .track:
            return "track"
            
        case .applyCoupen:
            return "apply-coupen"
            
        case .home:
            return "home"
            
        case .mentorDetail(let id):
            return "mentor/detail/\(id)"
            
        case .notifications:
            return "notifications"
            
        case .teacherServices:
            return "service/listing"
            
        case .qualifications:
            return "qualifications"
            
        case .addTeacher:
            return "admin/addteacher"
            
        case .teacherClassListing:
            return "teacher/class-list"
            
        case .updateTeacher:
            return "admin/teacher/update"
            
        case .customUrl:
            return "teacher/custom/meeting_link"
            
        case .generateLiveClass:
            return "teacher/class/join"
        }
        
    }
}


enum URLS {
    
    case baseUrl
    case googlePlaces
    case reversePlaceId(String)
    
    func getDescription() -> String {
        
    let liveUrl = "http://3.22.185.42/opaynly-api/public/api/"
    let localUrl = "https://6b1b-180-188-237-118.ngrok.io/ielts-app/public/api/"
        
        switch self {
       
        case .baseUrl :
            return localUrl
            //liveUrl
            
        case .googlePlaces:
            return "https://maps.googleapis.com/maps/api/place/autocomplete/json?key="
            
        case .reversePlaceId(let placeId):
            return "https://maps.googleapis.com/maps/api/place/details/json?input=bar&placeid=\(placeId)"
        }
    }
}
