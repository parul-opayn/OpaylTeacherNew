//
//  StoryboardIdentifiers.swift
//  Hart Store
//
//  Created by OPAYN on 01/10/21.
//

import Foundation
import UIKit

enum storyBoardIdentifiers {
    case main
    case courses
//    case iPadMain
 //   case iPadCourse
    
    func getStoryBoard()->UIStoryboard{
        
        switch self {
        
        case .main:
            
            if UIDevice().userInterfaceIdiom == .pad{
                return UIStoryboard(name: "Main-iPad", bundle: nil)
            }
            else{
                return UIStoryboard(name: "Main", bundle: nil)
            }
            
            
        case .courses:
            
            if UIDevice().userInterfaceIdiom == .pad{
                return UIStoryboard(name: "Course-iPad", bundle: nil)
            }
            else{
                return UIStoryboard(name: "Course", bundle: nil)
            }
            
            
       // case .iPadMain:
         //   return UIStoryboard(name: "Main-iPad", bundle: nil)
           
       // case .iPadCourse:
          //  return UIStoryboard(name: "Course-iPad", bundle: nil)
        }
    }
}
