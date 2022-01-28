//
//  Toast.swift
//
//  Created by OPAYN on 23/08/21.
//

import Foundation
import UIKit
//import SnackBar_swift
import TTGSnackbar

import TTGSnackbar



extension UIViewController{

    

    func showToast(message:String){
        //AppSnackBar.make(in: self.view, message: "  \(message)  ", duration: .custom(1.0)).show()
        
//        var style = SnackBarStyle()
//        style.background = .black
//        style.textColor = .white
//        style.actionTextColor = .systemRed
        
        let snackbar = TTGSnackbar(message: message, duration: .middle)
        
        if UIDevice().userInterfaceIdiom == .pad{
            snackbar.messageTextFont = UIFont(name: "Asap-Medium", size: 23)!
        }
        else{
            snackbar.messageTextFont = UIFont(name: "Asap-Regular", size: 17)!
        }
        snackbar.show()
    }

    

    
    
    func showToastWithAction(message:String,ButtonTitle:String,completion:@escaping()->()){
//        AppSnackBar.make(in: self.view, message: message, duration: .lengthLong).setAction(with: "\(ButtonTitle)", action: {
//
//            print("\(ButtonTitle) Tapped")
//            completion()
//
//        }).show()
        
        let snackbar = TTGSnackbar(
            message: message,
            duration: .middle,
            actionText: ButtonTitle,
            actionBlock: { (snackbar) in
                completion()
            }
        )
        if UIDevice().userInterfaceIdiom == .pad{
            snackbar.messageTextFont = UIFont(name: "Asap-Medium", size: 27)!
        }
        else{
            snackbar.messageTextFont = UIFont(name: "Asap-Regular", size: 17)!
        }
        snackbar.show()
        
    }

    
    func dismissToast(){
        TTGSnackbar().dismiss()
    }
}


