//
//  SetView.swift
//  Wouk
//
//  Created by Amalendu Kar on 11/8/19.
//  Copyright © 2019 Promatics Technologies Private Limited. All rights reserved.
//

import Foundation
import UIKit

//@IBDesignable
class SetView: UIView {
    
    @IBInspectable open var BorderColor:UIColor = UIColor.lightGray {
        didSet {
            self.UpdateBorder()
        }
    }
    
    @IBInspectable open var BorderWidth:CGFloat = 0 {
        didSet {
            self.UpdateBorder()
        }
    }
    
    @IBInspectable open var isCircle:Bool = false {
        didSet {
            self.UpdateCornerRadious()
        }
    }

    @IBInspectable open var CornerRadius:CGFloat = 0 {
        didSet {
            self.UpdateCornerRadious()
            
        }
    }
    
    @IBInspectable open var EnableShadow:Bool = false {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowColor:UIColor = UIColor.lightGray {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowRadius:CGFloat = 0 {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowOpacity:Float = 0 {
        didSet {
            self.SetShadow()
        }
    }

    @IBInspectable open var ShadowOffsetX:CGFloat = 0 {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var ShadowOffsetY:CGFloat = 0 {
        didSet {
            self.SetShadow()
        }
    }
    
    @IBInspectable open var BounceButton:Bool = false
    
    func UpdateBorder(){
        self.layer.borderWidth = BorderWidth
        self.layer.borderColor = BorderColor.cgColor
        self.layer.masksToBounds = true
    }
    
    func UpdateCornerRadious(){
        if isCircle {
            self.layer.cornerRadius = self.frame.size.width/2
        }else {
            self.layer.cornerRadius = CornerRadius
        }
    }
    
//    @IBInspectable open var SetGardient:Bool = false {
//        didSet {
//            self.updateGardient()
//        }
//    }
    
    func SetShadow(){
        
        if EnableShadow {
            
            self.layer.masksToBounds = false
            
            self.layer.shadowColor = ShadowColor.cgColor
            
            self.layer.shadowOpacity = ShadowOpacity
            
            self.layer.shadowOffset = CGSize(width: ShadowOffsetX, height: ShadowOffsetY)
            
            self.layer.shadowRadius = ShadowRadius
            
        }
        else{
            self.layer.masksToBounds = false
            
            self.layer.shadowColor = UIColor.clear.cgColor
            
            self.layer.shadowOffset = CGSize(width: 0, height: 0)
            
        }
        
    }
    
//    private func updateGardient() {
//
//        self.setGradientColor(with: [UIColor.appLightGreen, UIColor.appLightBlue])
//
//    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if(self.BounceButton){
            self.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)

            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 2, options: .allowUserInteraction, animations: {
                
                self.transform = CGAffineTransform.identity
                
            }, completion: nil)
        }

        super.touchesBegan(touches, with: event)
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.isUserInteractionEnabled = true
        super.touchesEnded(touches, with: event)
    }
    
    
   
}


extension UIView{
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(
                roundedRect: bounds,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: radius, height: radius)
            )
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
    
    func roundParticularCorners(topLeft: CGFloat = 0, topRight: CGFloat = 0, bottomLeft: CGFloat = 0, bottomRight: CGFloat = 0) {//(topLeft: CGFloat, topRight: CGFloat, bottomLeft: CGFloat, bottomRight: CGFloat) {
        let topLeftRadius = CGSize(width: topLeft, height: topLeft)
        let topRightRadius = CGSize(width: topRight, height: topRight)
        let bottomLeftRadius = CGSize(width: bottomLeft, height: bottomLeft)
        let bottomRightRadius = CGSize(width: bottomRight, height: bottomRight)
        let maskPath = UIBezierPath(shouldRoundRect: bounds, topLeftRadius: topLeftRadius, topRightRadius: topRightRadius, bottomLeftRadius: bottomLeftRadius, bottomRightRadius: bottomRightRadius)
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
        self.clipsToBounds = true
        self.layer.cornerRadius = 10
        self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
    
}



//Different Border Widths to UIView

extension UIView{
    
    func addTopBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleBottomMargin]
        border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addBottomBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.frame = CGRect(x: 0, y: frame.size.height - borderWidth, width: frame.size.width, height: borderWidth)
        addSubview(border)
    }

    func addLeftBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.frame = CGRect(x: 0, y: 0, width: borderWidth, height: frame.size.height)
        border.autoresizingMask = [.flexibleHeight, .flexibleRightMargin]
        addSubview(border)
    }

    func addRightBorder(with color: UIColor?, andWidth borderWidth: CGFloat) {
        let border = UIView()
        border.backgroundColor = color
        border.autoresizingMask = [.flexibleHeight, .flexibleLeftMargin]
        border.frame = CGRect(x: frame.size.width - borderWidth, y: 0, width: borderWidth, height: frame.size.height)
        addSubview(border)
    }
    
}


extension UIBezierPath {
    convenience init(shouldRoundRect rect: CGRect, topLeftRadius: CGSize = .zero, topRightRadius: CGSize = .zero, bottomLeftRadius: CGSize = .zero, bottomRightRadius: CGSize = .zero){

        self.init()

        let path = CGMutablePath()

        let topLeft = rect.origin
        let topRight = CGPoint(x: rect.maxX, y: rect.minY)
        let bottomRight = CGPoint(x: rect.maxX, y: rect.maxY)
        let bottomLeft = CGPoint(x: rect.minX, y: rect.maxY)

        if topLeftRadius != .zero{
            path.move(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.move(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        if topRightRadius != .zero{
            path.addLine(to: CGPoint(x: topRight.x-topRightRadius.width, y: topRight.y))
            path.addCurve(to:  CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height), control1: CGPoint(x: topRight.x, y: topRight.y), control2:CGPoint(x: topRight.x, y: topRight.y+topRightRadius.height))
        } else {
             path.addLine(to: CGPoint(x: topRight.x, y: topRight.y))
        }

        if bottomRightRadius != .zero{
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y-bottomRightRadius.height))
            path.addCurve(to: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y), control1: CGPoint(x: bottomRight.x, y: bottomRight.y), control2: CGPoint(x: bottomRight.x-bottomRightRadius.width, y: bottomRight.y))
        } else {
            path.addLine(to: CGPoint(x: bottomRight.x, y: bottomRight.y))
        }

        if bottomLeftRadius != .zero{
            path.addLine(to: CGPoint(x: bottomLeft.x+bottomLeftRadius.width, y: bottomLeft.y))
            path.addCurve(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height), control1: CGPoint(x: bottomLeft.x, y: bottomLeft.y), control2: CGPoint(x: bottomLeft.x, y: bottomLeft.y-bottomLeftRadius.height))
        } else {
            path.addLine(to: CGPoint(x: bottomLeft.x, y: bottomLeft.y))
        }

        if topLeftRadius != .zero{
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y+topLeftRadius.height))
            path.addCurve(to: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y) , control1: CGPoint(x: topLeft.x, y: topLeft.y) , control2: CGPoint(x: topLeft.x+topLeftRadius.width, y: topLeft.y))
        } else {
            path.addLine(to: CGPoint(x: topLeft.x, y: topLeft.y))
        }

        path.closeSubpath()
        cgPath = path
    }
}

