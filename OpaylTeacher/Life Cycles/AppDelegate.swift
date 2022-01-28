//
//  AppDelegate.swift
//  OpaylTeacher
//
//  Created by OPAYN on 25/01/22.
//

import UIKit
import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Thread.sleep(forTimeInterval: 2.0)
        
        IQKeyboardManager.shared.enable = true
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        if UserDefault.sharedInstance?.getUserDetails()?.id == nil{
            let viewCont = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            viewCont.hideBack = true
            let navVc = UINavigationController(rootViewController: viewCont)
            self.window?.rootViewController = navVc
        }
        else{
            let viewCont = storyBoardIdentifiers.main.getStoryBoard().instantiateViewController(withIdentifier: "MainDashboardViewController") as! MainDashboardViewController
            let navVc = UINavigationController(rootViewController: viewCont)
            self.window?.rootViewController = navVc
        }
        
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
        }
        
        // adjustLabelFontsForiPad()
        application.registerForRemoteNotifications()
        //fcmConfiguration(application)
        //extendAudioFileLimit()
        window?.makeKeyAndVisible()
        
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        var config = "Default Configuration"
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            print("IPAD - LOADING IPAD CONFIG - \(config)")
            config = "iPadConfiguration"
        }
        return UISceneConfiguration(name: config, sessionRole: connectingSceneSession.role)
        //return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)    }
    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}




