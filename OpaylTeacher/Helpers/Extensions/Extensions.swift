//
//  Extensions.swift
//  Created by OPAYN on 16/08/21.
//

import Foundation
import UIKit
import SideMenu
import CoreLocation

extension UIViewController{
        
    
    //MARK: - Collection view cell width and spacing
    func getLabelCellWidth(strArray: [String], index: Int) -> CGFloat{
        let string = strArray[index]
        var font = UIFont(name: "Asap-Medium", size: 12)
        if UIDevice.current.userInterfaceIdiom == .pad{
            font = UIFont(name: "Asap-Medium", size: 22)
        }
        let fontAttribute = [NSAttributedString.Key.font: font]
        let size = string.size(withAttributes: fontAttribute as [NSAttributedString.Key : Any])
        let extraSpace : CGFloat = 44.0
        let width = size.width + extraSpace
        return width
    }
    
    func CollViewCustomLayout(collecView: UICollectionView){
        let columnLayout = CustomViewFlowLayout()
        collecView.collectionViewLayout = columnLayout
        collecView.contentInsetAdjustmentBehavior = .always
    }
    
    //MARK: - CollectionView Height Manager
    
    func updateCollectionHeight(collectionName : UICollectionView , collectionHeight : NSLayoutConstraint){
        var frame = collectionName.frame
        frame.size.height = collectionName.collectionViewLayout.collectionViewContentSize.height
        collectionName.frame = frame
        collectionName.reloadData()
        collectionName.reloadData()
        collectionName.layoutIfNeeded()
        collectionHeight.constant = CGFloat(collectionName.collectionViewLayout.collectionViewContentSize.height)
        collectionName.layoutIfNeeded()
        
        print("\(collectionName) height = \(CGFloat(collectionName.collectionViewLayout.collectionViewContentSize.height))")
    }
    
    //MARK:- TableView Height Manager
    
    func updateTableHeight(tableName : UITableView , tableHeight : NSLayoutConstraint){
        var frame = tableName.frame
        frame.size.height = tableName.contentSize.height
        tableName.frame = frame
        tableName.reloadData()
        tableName.layoutIfNeeded()
        tableHeight.constant = CGFloat(tableName.contentSize.height)
    }
    
    func presentWithTransition(vc:UIViewController, from presentingController:UIViewController){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        vc.modalPresentationStyle = .overCurrentContext
        presentingController.present(vc, animated: false, completion: nil)
    }
    
    func dismissWithTransition(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        dismiss(animated: false, completion: nil)
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int) {
      return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
    }
    
    func getStringFrom(seconds: Int) -> String {

        return seconds < 10 ? "0\(seconds)" : "\(seconds)"
    }
    
}

extension UILabel{
    
    func strokeLabel(strokeWidth:Double,color:UIColor,textColor:UIColor,font:UIFont,text:String)->NSAttributedString{
        let attrString = NSAttributedString(
            string: text,
            attributes: [
                NSAttributedString.Key.strokeColor: color,
                NSAttributedString.Key.foregroundColor: textColor,
                NSAttributedString.Key.strokeWidth: strokeWidth,
                NSAttributedString.Key.font: font
            ]
        )
        return attrString
    }
    
}


extension UIButton{
    func changeButtonLayout(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            if let c = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
                c.constant = CGFloat((self.frame.height) + 20)
                self.superview?.layoutIfNeeded()
            }
        }
    }
}


extension UIImageView{
    
    func changeLayout(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.heightConstraint?.constant = ((self.frame.height) + 50)
            self.widthConstraint?.constant = ((self.frame.width) + 50)
        }
        
    }
    
    
    var heightConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstraint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
}


extension UIView{
    func changeViewLayout(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            if let c = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
                c.constant = CGFloat((self.frame.height) + 100)
                self.superview?.layoutIfNeeded()
            }
        }
    }
}

//MARK:- Fonts Adjustment As Per Device

extension UIButton{
    
    func changeFontSize(){
      
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize ?? 17) + 10)
        }
        else{
            self.titleLabel?.font = self.titleLabel?.font.withSize((self.titleLabel?.font.pointSize ?? 17))
        }
    }
}

extension UITextField{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 10)
        }
        else{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17))
        }
    }
}


extension UITextView{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 10)
        }
        else{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17))
        }
    }
}

extension UILabel{
    func changeFontSize(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17) + 10)
        }
        else{
            self.font = self.font?.withSize((self.font?.pointSize ?? 17))
        }
    }
}

extension UIStackView{
    func changeSpacin(){
        if UIDevice.current.userInterfaceIdiom == .pad{
            self.spacing = 32
        }
    }
}


extension Notification.Name{
    static let expiredToken = Notification.Name(rawValue: "expiredToken")
    static let updateCartValue = Notification.Name(rawValue: "updateCartValue")
    static let stopAvPlayer = Notification.Name(rawValue: "stopAvPlayer")
    static let currentPlayerRate = Notification.Name(rawValue: "currentPlayerRate")
    static let ThanksViewDismiss = Notification.Name(rawValue: "thanksViewDismiss")
    static let ieltsPreference = Notification.Name(rawValue: "ieltsPreference")
    static let optionsIndex = Notification.Name(rawValue: "optionsIndex")
    static let currentPlayerVideoEnd = Notification.Name(rawValue: "currentPlayerVideoEnd")
}


enum LeftButtonType {
    case back
    case referesh
    case menu
    case text
}

enum rightButtontype{
    case filter
    case videocall
    case like
    case addFeed
    case cart
    case cross
    case expand
    case notification
    case options
}

extension UITableView{
    
    func scrollToBottom(animated: Bool) {
        
        DispatchQueue.main.async {
            
            if self.contentSize.height > self.frame.height {
                
                // First figure out how many sections there are
                let lastSectionIndex = self.numberOfSections - 1
                
                // Then grab the number of rows in the last section
                let lastRowIndex = self.numberOfRows(inSection: lastSectionIndex) - 1
                
                // Now just construct the index path
                let pathToLastRow = NSIndexPath(row: lastRowIndex, section: lastSectionIndex)
                
                // Make the last row visible
                self.scrollToRow(at: pathToLastRow as IndexPath, at: UITableView.ScrollPosition.bottom, animated: false)
            }
        }
    }
}

extension UIScrollView {
   func scrollViewToBottom(animated: Bool) {
     if self.contentSize.height < self.bounds.size.height { return }
     let bottomOffset = CGPoint(x: 0, y: self.contentSize.height - self.bounds.size.height)
     self.setContentOffset(bottomOffset, animated: animated)
  }
}


public func generateUniqueName(withSuffix suffix:String)->String{
    let uuid = UUID().uuidString
    return "HartStore-\(uuid)\(suffix)"
}

//MARK: - String Extension
extension String {
    func strikeThrough() -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0,attributeString.length))
        return attributeString
    }
}

extension Data {
    
    var html2AttributedString: NSAttributedString? {
        
        do {
            var attrStr = try NSMutableAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            attrStr.replaceFont(with: UIFont.systemFont(ofSize: 17))
            return attrStr
        }
        catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String { html2AttributedString?.string ?? "" }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        Data(utf8).html2AttributedString
    }
    var html2String: String {
        html2AttributedString?.string ?? ""
    }
}

// Label Shadow
extension UILabel {
    func lblShadow(color: UIColor , radius: CGFloat, opacity: Float){
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.masksToBounds = false
    }
}

//MARK: - Notification Names

extension Notification.Name{
    
    static let guestEmailVerification = Notification.Name("guestEmailVerification")
    static let trackPresentedScreen = Notification.Name("trackPresentedScreen")
}

extension UISegmentedControl{
    func selectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .selected)
    }
    func unselectedSegmentTintColor(_ color: UIColor) {
        self.setTitleTextAttributes([.foregroundColor: color], for: .normal)
    }
    
    func fixBackgroundSegmentControl( _ segmentControl: UISegmentedControl){
        if #available(iOS 13.0, *) {
            //just to be sure it is full loaded
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                for i in 0...(segmentControl.numberOfSegments-1)  {
                    let backgroundSegmentView = segmentControl.subviews[i]
                    //it is not enogh changing the background color. It has some kind of shadow layer
                    backgroundSegmentView.isHidden = true
                }
            }
        }
    }
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfMonth], from: date, to: self).weekOfMonth ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date)) years ago"   }
        if months(from: date)  > 0 { return "\(months(from: date)) months ago"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date)) weeks ago"   }
        if days(from: date)    > 0 { return "\(days(from: date)) days ago"    }
        if hours(from: date)   > 0 { return "\(hours(from: date)) hours ago"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date)) minutes ago" }
        if seconds(from: date) > 0 { return "\(seconds(from: date)) seconds ago" }
        return ""
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func toCurrentTimezone() -> Date {
        let timeZoneDifference =
        TimeInterval(TimeZone.current.secondsFromGMT())
        return self.addingTimeInterval(timeZoneDifference)
    }

    
    
}

extension Date {
    
    func daysBetween(date: Date) -> Int {
        return Date.daysBetween(start: self, end: date)
    }
    
    static func daysBetween(start: Date, end: Date) -> Int {
        let calendar = Calendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: start)
        let date2 = calendar.startOfDay(for: end)
        
        let a = calendar.dateComponents([.day], from: date1, to: date2)
        return a.value(for: .day)!
    }
}

func forTrailingZero(temp: Double) -> String {
    let tempVar = String(format: "%g", temp)
    return tempVar
}


extension NSMutableAttributedString {
    func replaceFont(with font: UIFont) {
        beginEditing()
        self.enumerateAttribute(.font, in: NSRange(location: 0, length: self.length)) { (value, range, stop) in
            if let f = value as? UIFont {
                let ufd = f.fontDescriptor.withFamily(font.familyName).withSymbolicTraits(f.fontDescriptor.symbolicTraits)!
                let newFont = UIFont(descriptor: ufd, size: f.pointSize)
                removeAttribute(.font, range: range)
                addAttribute(.font, value: newFont, range: range)
            }
        }
        endEditing()
    }
}


