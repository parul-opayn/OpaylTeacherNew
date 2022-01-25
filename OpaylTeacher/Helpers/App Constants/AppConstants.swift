////
////  AppConstants.swift
////  IletsLearning
////
////  Created by OPAYN on 24/12/21.
////
//
//import Foundation
//import UIKit
//
//enum AppScreenConstants{
//
//    case splash
//    case walkthrough
//    case login
//    case signup
//    case forotPassword
//    case otpVerificaton
//    case createPassword
//    case home
//    case guestDrawer
//    case userDrawer
//    case courseList
//    case filters
//    case caseSearchResult
//    case videoPlay
//    case freeTrial
//    case faq
//    case aboutUs
//}
//
//func getScreenName(name:UIViewController)->String{
//
//    switch name {
//
//    case is BasicInfoViewController:
//        return "walkthrough"
//
//    case is LoginViewController:
//        return "login"
//
//    case is SignupViewController:
//        return "signup"
//
//    case is ForgotPasswordViewController:
//        return "forotPassword"
//
//    case is PasscodeViewController:
//        return "otpVerificaton"
//
//    case is CreateNewPasswordViewController:
//        return "createPassword"
//
//    case is IntroductionViewController:
//        return "home"
//
//    case is CoursesListViewController:
//        return "courses"
//
//    case is FilterViewController:
//        return "filters"
//
//    case is SearchCoursesViewController:
//        return "coursesearchResult"
//
//    case is VideoPlayViewController:
//        return "videoPlay"
//
//    case is FreeTrialViewController:
//        return "freeTrial"
//
//    case is FaqViewController:
//        return "faq"
//
//    case is FaqViewController:
//        return "aboutUs"
//
//    case is EditProfileViewController:
//        return "profile"
//
//    case is ChangePasswordViewController:
//        return "changePassword"
//
//    case is PaymentViewController:
//        return "payment"
//
//    case is MainDashboardViewController:
//        return "dashboard"
//
//    case is PackagesViewController:
//        return "viewMorePackage"
//
//    case is AboutCourseViewController:
//        return "aboutCourse"
//
//    case is ContactusViewController:
//        return "contactUs"
//
//    case is OnlineClassesViewController:
//        return "onlineClasses"
//
//    case is FilterViewController:
//        return "filters"
//
//    case is SelectedClassViewController:
//        return "onlineClassDetails"
//
//    case is RatingViewController:
//        return "rating"
//
//    case is NotificationViewController:
//        return "notification"
//
//    case is PaymentListViewController:
//        return "purchaseHistory"
//
//    case is CheckoutViewController:
//        return "checkout"
//
//    case is TestTypePopUpViewController:
//        return "testPopup"
//
//    case is ieltsReadingViewController:
//        return "ielts\((Singleton.sharedInstance.moduleTypes[Singleton.sharedInstance.moduleIndex]).lowercased())"
//
//    case is TestInstructionViewController:
//        return "\((Singleton.sharedInstance.moduleTypes[Singleton.sharedInstance.moduleIndex]).lowercased())Instructions"
//
//    case is TestParagraphViewController:
//        return "readingTest"
//
//    case is WritingTask1ViewController:
//        return "writingTest"
//
//    case is TestQuestionViewController:
//
//        if Singleton.sharedInstance.moduleIndex == 0{
//            return "readingQuestions"
//        }
//        else{
//            return "listenTest"
//        }
//
//    case is CloseTestPopUpViewController:
//        return "closeTest"
//
//    case is TestresultViewController:
//        return "testResults"
//
//    case is CustomCameraViewController:
//        return "captureTest"
//
//    case is SpeakingTestIntroViewController:
//        return "speakingTest"
//
//    case is EmailPopupViewController:
//        return "testEmailPopup"
//
//    case is VerifyOTPViewController:
//        return "verifyTestOtp"
//
//    default:
//        return String(describing:name.classForCoder)
//    }
//
//}
