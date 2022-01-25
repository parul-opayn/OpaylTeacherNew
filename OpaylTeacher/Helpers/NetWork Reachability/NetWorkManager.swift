//
//  NetWorkManager.swift
//  IletsLearning
//
//  Created by OPAYN on 22/11/21.
//

import Foundation
import Alamofire

class Connectivity {
    
    class var isConnectedToInternet:Bool {
        
        return NetworkReachabilityManager()!.isReachable
        
    }
    
}
