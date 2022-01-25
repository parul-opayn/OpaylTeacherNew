//
//  RoundTextField.swift
//  Greet Upp
//
//  Created by OPAYN on 06/09/21.
//

import Foundation
import UIKit

protocol rightImageTapDelegate{
    func didTapRightImage(textfield:UITextField)
}

@IBDesignable
class RoundTextField : UITextField,UIGestureRecognizerDelegate{
    @IBInspectable var cornerRadius : CGFloat = 0{
        didSet{
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    @IBInspectable var borderWidth : CGFloat = 0 {
        didSet{
            layer.borderWidth = borderWidth
        }
    }

    @IBInspectable var borderColor : UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var bgColor : UIColor? {
        didSet {
            backgroundColor = bgColor
        }
    }

    @IBInspectable var leftImage : UIImage? {
        didSet {
            if let image = leftImage{
                leftViewMode = .always
                var imageView = UIImageView()
                var view = UIView()
                if UIDevice().userInterfaceIdiom == .pad{
                     imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 20, height: 20))
                     view = UIView(frame : CGRect(x: 0, y: 0, width: 20, height: 20))
                }
                else{
                     imageView = UIImageView(frame: CGRect(x: 20, y: 0, width: 15, height: 15))
                    view = UIView(frame : CGRect(x: 0, y: 0, width: 15, height: 15))
                }
                
                imageView.image = image
                imageView.contentMode = .scaleAspectFit
                imageView.tintColor = tintColor
                
                view.addSubview(imageView)
                leftView = view
            }else {
                leftViewMode = .never
            }

        }
    }
    
    @IBInspectable var rightImage : UIImage? {
        didSet {
            if let image = rightImage{
                rightViewMode = .always
                let imageView = UIImageView(frame: CGRect(x: -08, y: 0, width: 15, height: 15))
                imageView.image = image
                imageView.isUserInteractionEnabled = true
                imageView.addGestureRecognizer(tap)
                tap.delegate = self
                tap.addTarget(self, action: #selector(didTapImage))
                imageView.tintColor = .black
                imageView.contentMode = .scaleAspectFit
                let view = UIView(frame : CGRect(x: 20, y: 0, width: 15, height: 15))
                view.addSubview(imageView)
                rightView = view
            }else {
                leftViewMode = .never
            }

        }
    }
    
    @IBInspectable var isRightViewPassword : Bool = false{
        didSet{
            
        }
    }

    @IBInspectable var placeholderColor : UIColor? {
        didSet {
            let rawString = attributedPlaceholder?.string != nil ? attributedPlaceholder!.string : ""
            let str = NSAttributedString(string: rawString, attributes: [NSAttributedString.Key.foregroundColor : placeholderColor!])
            attributedPlaceholder = str
        }
    }

    var tap = UITapGestureRecognizer()
    var rightTapDelegate:rightImageTapDelegate?
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 50, dy: 5)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.insetBy(dx: 50, dy: 5)
    }

    
    @objc func didTapImage(){
        if isRightViewPassword{
            if !self.isSecureTextEntry{
                self.rightImage = #imageLiteral(resourceName: "eye")
                self.isSecureTextEntry = true
            }
            else{
                self.rightImage = #imageLiteral(resourceName: "closed eye")
                self.isSecureTextEntry = false
            }
            
        }
        rightTapDelegate?.didTapRightImage(textfield: self)
    }
}
