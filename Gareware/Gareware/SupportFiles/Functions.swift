//
//  Functions.swift
//  Gareware
//

import UIKit

func executeAfter(_ sec:Int) {
    
}

func showTransientAlert(_ title:String, message: String) {
    
    let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    AppObject.nav().present(alertController, animated: true, completion: nil)
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 10 , execute: {
        alertController.dismiss(animated: true, completion: {
        })
    })
}

func bgColor(_ view: UIView, title: String) -> UIColor? {
    var retunColor:UIColor?
    UIGraphicsBeginImageContext(view.frame.size)
    UIImage(named: title)?.draw(in: view.bounds)
    
    if let image: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
        UIGraphicsEndImageContext()
        retunColor =  UIColor(patternImage: image)
    }
    return retunColor
}
