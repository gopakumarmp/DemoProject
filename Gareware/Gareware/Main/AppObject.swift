//
//  App.swift
//  Gareware
//

import UIKit

class AppObject:UIApplication {
    
    class func delegate() -> AppDelegate {
        return UIApplication.shared.delegate! as! AppDelegate
    }
    
    class func nav() -> UINavigationController {
        return self.delegate().navController
    }
}
