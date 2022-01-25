//
//  MenuModel.swift
//  Hart Store
//
//  Created by OPAYN LLC on 01/10/21.
//

import Foundation
import UIKit

struct Menu{
    var heading: String
    var subHeading: [subMenu]
    var collapsed:Bool
    var leftImage:UIImage? = nil
}

struct subMenu{
    
    var viewName: String
    var image:UIImage?
    var leftImage:UIImage? = nil
}


