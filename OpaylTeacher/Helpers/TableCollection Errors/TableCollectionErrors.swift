//
//  TableCollectionErrors.swift
//  OpaynKart
//
//  Created by OPAYN on 26/08/21.
//

import Foundation
import UIKit
import iCarousel

public func tableCollectionErrors<T>(view:T,text:String, headerHeight: Int){
    
    if let table = view as? UITableView{
        
       // if headerHeight == 0{
            let label = UILabel()
            label.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.frame.height)
            label.text = text
            label.font = UIFont(name: "Asap-SemiBold", size: 15)
            label.changeFontSize()
            label.textAlignment = .center
            label.textColor = .black
            table.backgroundView = label
  //      }
//        else{
//            let myView = UIView()
//            let label = UILabel()
//            myView.addSubview(label)
//            myView.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.frame.height)
//            if table.parallaxHeader.height > (table.frame.height - 40){
//                label.frame = CGRect(x: 0, y: table.frame.height - 40, width: table.frame.width, height: 50)
//            }else{
//                label.frame = CGRect(x: 0, y: table.parallaxHeader.height, width: table.frame.width, height: (table.frame.height - (table.parallaxHeader.height)))
//            }
//            label.text = text
//            label.font = UIFont(name: "Asap-SemiBold", size: 15)
//            label.changeFontSize()
//            label.textAlignment = .center
//            label.textColor = .black
//            table.backgroundView = myView
//        }
    }
    
    else if let collection = view as? UICollectionView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: collection.frame.width, height: collection.frame.height)
        label.text = text
        label.font = UIFont(name: "Asap-SemiBold", size: 15)
        label.changeFontSize()
        label.textAlignment = .center
        label.textColor = .black
        collection.backgroundView = label
    }
    else{
        print("sdsds")
    }
    
}


public func displayRedErrorMessages<T>(view:T,text:String){
    if let table = view as? UITableView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: table.frame.width, height: table.frame.height)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.changeFontSize()
        label.textAlignment = .center
        label.textColor = .black
        table.backgroundView = label
    }
    else if let collection = view as? UICollectionView{
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: collection.frame.width, height: collection.frame.height)
        label.text = text
        label.font = UIFont.systemFont(ofSize: 20)
        label.changeFontSize()
        label.textAlignment = .center
        label.textColor = .black
        collection.backgroundView = label
    }
    else{
        print("sdsds")
    }
    
}
