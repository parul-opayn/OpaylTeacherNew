//
//  Singleton.swift
//  OpaynKart
//
//  Created by OPAYN on 30/08/21.
//

import Foundation
import UIKit

class Singleton {
    
    static let sharedInstance = Singleton()
    var moduleTypes = ["Reading", "Writing", "Listening", "Speaking"]
    var userTimeZone = TimeZone.current.identifier
    var moduleIndex = 0
    var playedVideoRow: IndexPath?
    var currentFavritesIndex = 0
    var controllerName = UIViewController()
    
    func UTCToLocal(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")

        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat

        return dateFormatter.string(from: dt ?? Date())
    }
    
    
    func UTCToLocalDate(date:String, fromFormat: String, toFormat: String) -> Date {
        
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = fromFormat
//        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
//
//        let dt = dateFormatter.date(from: date)
//       // dateFormatter.timeZone = TimeZone.current
//        //dateFormatter.dateFormat = toFormat
//        return dt ?? Date()
        let strDate = UTCToLocal(date: date, fromFormat: fromFormat, toFormat: toFormat)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
        return dateFormatter.date(from: strDate) ?? Date()
    }

    func changeDateFormat(date:String, fromFormat: String, toFormat: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = fromFormat
        let dt = dateFormatter.date(from: date)
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = toFormat
      return dateFormatter.string(from: dt ?? Date())
    }
    
    func convertToUTC(dateToConvert:String) -> String {
         let formatter = DateFormatter()
         formatter.dateFormat = "HH:mm:ss"
         let convertedDate = formatter.date(from: dateToConvert)
         formatter.timeZone = TimeZone(identifier: "UTC")
         return formatter.string(from: convertedDate ?? Date())
            
        }
    
    func calculateDaysBetweenDates(startDate:String,endDate:String,format:String)->Int{
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let start = dateFormatter.date(from: startDate)!
        let end = dateFormatter.date(from: endDate)!

        let diff = Date.daysBetween(start: start, end: end) // 365
        
        return diff
    }
    
    func formatPoints(from: Int) -> String {

        let number = Double(from)
        let thousand = number / 1000
        let million = number / 1000000
        let billion = number / 1000000000
        
        if billion >= 1.0 {
            return "\(round(billion*10)/10)B"
        } else if million >= 1.0 {
            return "\(round(million*10)/10)M"
        } else if thousand >= 1.0 {
            return ("\(round(thousand*10/10))K")
        } else {
            return "\(Int(number))"
        }
    }
    
    
}

