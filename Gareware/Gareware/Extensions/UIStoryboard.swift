//
//  UIStoryboard.swift
//  Gareware
//

import UIKit

extension UIStoryboard  {
    
    class func LaunchViewController() -> RegisterViewController {
        let launchStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        return launchStoryboard.instantiateViewController(withIdentifier: "RegisterViewControllerID") as!
        RegisterViewController
    }
    
    class func DetailViewController() -> DetailViewController {
        let launchStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        return launchStoryboard.instantiateViewController(withIdentifier: "DetailViewControllerID") as!
        DetailViewController
    }
    
    class func ArchitectSunFilmsController() -> ArchitectSunFilmsController {
        let launchStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        return launchStoryboard.instantiateViewController(withIdentifier: "ArchitectSunFilmsControllerID") as!
        ArchitectSunFilmsController
    }
    
    class func SelectRegionViewController() -> SelectRegionViewController {
        let launchStoryboard =  UIStoryboard(name: "Main", bundle: nil)
        return launchStoryboard.instantiateViewController(withIdentifier: "SelectRegionViewControllerID") as!
        SelectRegionViewController
    }
    
    
}


