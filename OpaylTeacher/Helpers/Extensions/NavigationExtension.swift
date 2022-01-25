//
//  NavigationExtension.swift
//  Hart Store
//
//  Created by OPAYN on 30/09/21.
//

import Foundation
import UIKit

protocol customNavigationDelegates {
    func didTapRightButton(buttonType type:rightButtontype)
    func didTapLeftbutton(buttonType type:LeftButtonType)
}

var navigationButtonsDelegate:customNavigationDelegates?

extension UIViewController{
    
    //MARK:- NavigationBar
    
    func navigationWithBack(navtTitle:String,titleType:NavigationTitleType,titleColor:UIColor){
        self.navigationController?.isNavigationBarHidden = false
        
        if UIDevice().userInterfaceIdiom == .pad{
            let spacer = UIBarButtonItem()
            spacer.width = 16
            let icon = UIImage(named: "backBtn")
            let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
            let iconButton = UIButton(frame: iconSize)
            iconButton.setBackgroundImage(icon, for: .normal)
            let barButton = UIBarButtonItem(customView: iconButton)
            iconButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
            navigationItem.setLeftBarButtonItems([spacer,barButton], animated: false)
        }
        else{
            let button = UIButton(type: .custom)
            button.setImage(#imageLiteral(resourceName: "backBtn"), for: .normal)
            button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50))
            button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            // button.layer.cornerRadius = 20
            button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
            navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        }
        //       let button = UIButton(type: .custom)
        //      // button.backgroundColor = .red
        //       button.setImage(#imageLiteral(resourceName: "backBtn"), for: .normal)
        //       button.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50))
        //       button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        //      // button.layer.cornerRadius = 20
        //       button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        //       navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        navigationItem.title = navtTitle
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.navigationBar.shadowImage = UIImage()
        detectDeviceForFont(titleType: titleType, color: titleColor)
    }
    
    func leftTitleAndRightBtn(navtTitle:String,titleType:NavigationTitleType,titleColor:UIColor,rightIcon:UIImage, rightBtnType:rightButtontype){
        let button = UIButton(type: .custom)
        button.setTitle(navtTitle, for: .normal)
        button.setTitleColor(titleColor, for: .normal)
        button.isUserInteractionEnabled = false
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        switch titleType {
            
        case .normal:
            button.titleLabel?.font = UIFont(name: "Asap-Regular", size: 17)
            
        case .large:
            button.titleLabel?.font = UIFont(name: "Asap-SemiBold", size: 20)
            
        case .xlarge:
            button.titleLabel?.font = UIFont(name: "Asap-Bold", size: 30)
        }
        let cart = UIButton()
        cart.imageView?.contentMode =  .scaleAspectFit
        cart.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 40))
        cart.setImage(rightIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        
        if rightBtnType == .filter{
            cart.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        }
        else if rightBtnType == .like{
            cart.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        }
        else if rightBtnType == .videocall{
            cart.addTarget(self, action: #selector(didTapVideoCall), for: .touchUpInside)
        }
        else if rightBtnType == .addFeed{
            cart.addTarget(self, action: #selector(didTapAddFeed), for: .touchUpInside)
        }
        else if rightBtnType == .cart{
            cart.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        }
        else if rightBtnType == .cross{
            cart.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        }
        
        let rightBarItem = UIBarButtonItem(customView: cart)
        rightBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    func navigationWithTitleOnly(titleString:String,titleType:NavigationTitleType,titleColor:UIColor){
        
        navigationItem.title = titleString
        //  navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        detectDeviceForFont(titleType: titleType, color: titleColor)
    }
    
    func detectDeviceForFont(titleType:NavigationTitleType,color:UIColor){
        if UIDevice.current.userInterfaceIdiom == .pad{
            
            var attrs = [NSAttributedString.Key : Any]()
            
            switch titleType {
                
            case .normal:
                attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Asap-Medium", size: 27)!
                ]
                
                break
                
            case .large:
                attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Asap-SemiBold", size: 30)!
                ]
                
                break
                
            case .xlarge:
                
                attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Asap-Medium", size: 40)!
                ]
                
                break
                
            }
            
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
        else{
            
            var attrs = [NSAttributedString.Key : Any]()
            
            switch titleType {
                
            case .normal:
                attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Asap-Medium", size: 17)!
                ]
                
                break
                
            case .large:
                attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Asap-SemiBold", size: 20)!
                ]
                
                break
                
            case .xlarge:
                
                attrs = [
                    NSAttributedString.Key.foregroundColor: color,
                    NSAttributedString.Key.font: UIFont(name: "Asap-Medium", size: 30)!
                ]
                
                break
                
            }
            self.navigationItem.setHidesBackButton(true, animated: true)
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
        navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.tintColor = color
    }
    
    func navigationWithTwoRightButtons(){
        let menu = UIButton(type: .custom)
        menu.setImage(#imageLiteral(resourceName: "menu"), for: .normal)
        menu.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30))
        menu.layer.cornerRadius = 20
        menu.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menu)
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        let filter = UIButton()
        filter.imageView?.contentMode =  .scaleAspectFit
        filter.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 20, height: 20))
        filter.setImage(#imageLiteral(resourceName: "sliders"), for: .normal)
        filter.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        
        self.navigationItem.rightBarButtonItems = [UIBarButtonItem(customView: filter)]
        
        // navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        // self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        if UIDevice.current.userInterfaceIdiom == .pad{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "Asap-Medium", size: 27)!
            ]
            
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
        else{
            let attrs = [
                NSAttributedString.Key.foregroundColor: UIColor.black,
                NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 17)!
            ]
            navigationController?.navigationBar.barTintColor = UIColor.white
            navigationController?.navigationBar.titleTextAttributes = attrs
        }
    }
    
    func bothSideIcons(titleString:String,titleType:NavigationTitleType,leftIcon:UIImage,rightIcon:UIImage,titleColor:UIColor,leftBtnType:LeftButtonType,rightBtnType:rightButtontype){
        
        navigationController?.isNavigationBarHidden = false
        navigationItem.title = titleString
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        
        var button = UIButton()
        //       button.imageView?.contentMode =  .scaleAspectFit
        //       button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 6, bottom: 4, right: 2)
        //       button.setImage(leftIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        
        
        if UIDevice().userInterfaceIdiom == .pad{
            
            let spacer = UIBarButtonItem()
            spacer.width = 16
            
            let icon = leftIcon
            let iconSize = CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 30))
            button = UIButton(frame: iconSize)
            button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 16, bottom: 4, right: 2)
            button.setBackgroundImage(icon, for: .normal)
            
            
            let leftBarItem = UIBarButtonItem(customView: button)
            //   leftBarItem.customView?.translatesAutoresizingMaskIntoConstraints = true
            // leftBarItem.customView?.heightAnchor.constraint(equalToConstant: 30).isActive = true
            // leftBarItem.customView?.widthAnchor.constraint(equalToConstant: 40).isActive = true
            navigationItem.setLeftBarButtonItems([spacer,leftBarItem], animated: false)
        }
        else{
            
            button = UIButton(type: .custom)
            button.imageView?.contentMode =  .scaleAspectFit
            button.imageEdgeInsets = UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 2)
            button.setImage(leftIcon.withRenderingMode(.alwaysOriginal), for: .normal)
            
            let leftBarItem = UIBarButtonItem(customView: button)
            leftBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
            leftBarItem.customView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
            leftBarItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
            navigationItem.leftBarButtonItem = leftBarItem
            
        }
        
        if leftBtnType == .back{
            button.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        }
        else if leftBtnType == .referesh{
            button.addTarget(self, action: #selector(didTapRefresh), for: .touchUpInside)
        }
        else if leftBtnType == .menu{
            button.addTarget(self, action: #selector(didTapMenu), for: .touchUpInside)
        }
        
        
        
        
        //       let cart = UIButton()
        //       cart.imageView?.contentMode =  .scaleAspectFit
        //       cart.frame = CGRect(origin: CGPoint.zero, size: CGSize(width: 40, height: 40))
        //       cart.setImage(rightIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        //cart.imageEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        let rightbutton = UIButton(type: .system)
        rightbutton.imageView?.contentMode =  .scaleAspectFit
        rightbutton.setImage(rightIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        
        if rightBtnType == .filter{
            rightbutton.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        }
        else if rightBtnType == .like{
            rightbutton.addTarget(self, action: #selector(didTapLike), for: .touchUpInside)
        }
        else if rightBtnType == .videocall{
            rightbutton.addTarget(self, action: #selector(didTapVideoCall), for: .touchUpInside)
        }
        else if rightBtnType == .addFeed{
            rightbutton.addTarget(self, action: #selector(didTapAddFeed), for: .touchUpInside)
        }
        else if rightBtnType == .cart{
            rightbutton.addTarget(self, action: #selector(didTapCart), for: .touchUpInside)
        }
        else if rightBtnType == .cross{
            rightbutton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        }
        else if rightBtnType == .expand{
            rightbutton.addTarget(self, action: #selector(didTapExpand), for: .touchUpInside)
        }
        else if rightBtnType == .notification{
            rightbutton.addTarget(self, action: #selector(didTapNotification), for: .touchUpInside)
        }
        let rightBarItem = UIBarButtonItem(customView: rightbutton)
        rightBarItem.customView?.translatesAutoresizingMaskIntoConstraints = false
        rightBarItem.customView?.heightAnchor.constraint(equalToConstant: 50).isActive = true
        rightBarItem.customView?.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        self.navigationItem.rightBarButtonItem = rightBarItem
        
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.barTintColor = UIColor.white
        detectDeviceForFont(titleType: titleType, color: titleColor)
    }
    
    
    @objc func didTapMenu(){
        navigationButtonsDelegate?.didTapLeftbutton(buttonType: .menu)
    }
    
    @objc func didTapBack(){
        navigationButtonsDelegate?.didTapLeftbutton(buttonType: .back)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func didTapSearch(){
        //
        print("search")
    }
    
    
    @objc func didTapRefresh(){
        navigationButtonsDelegate?.didTapLeftbutton(buttonType: .referesh)
        print("Refresh")
    }
    
    @objc func didTapFilter(){
        navigationButtonsDelegate?.didTapRightButton(buttonType: .filter)
    }
    
    @objc func didTapLike(){
        navigationButtonsDelegate?.didTapRightButton(buttonType: .like)
        print("didTapLike")
    }
    
    @objc func didTapVideoCall(){
        navigationButtonsDelegate?.didTapRightButton(buttonType: .videocall)
        print("didTapVideoCall")
    }
    
    @objc func didTapAddFeed(){
        print("Add feed")
        navigationButtonsDelegate?.didTapRightButton(buttonType: .addFeed)
    }
    
    @objc func didTapCart(){
        print("Add feed")
        navigationButtonsDelegate?.didTapRightButton(buttonType: .cart)
    }
    
    @objc func didTapExpand(){
        print("Expand")
        navigationButtonsDelegate?.didTapRightButton(buttonType: .expand)
    }
    
    @objc func didTapNotification(){
        print("Notification")
        navigationButtonsDelegate?.didTapRightButton(buttonType: .notification)
    }
}
