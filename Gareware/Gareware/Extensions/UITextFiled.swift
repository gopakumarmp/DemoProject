//
//  UITextFiled.swift
//  Gareware
//

import UIKit

extension UITextField {
    
    func setPlaceholderWithColor(_ text: String, color: UIColor) {
        // Set the Font
        var placeHolder = NSMutableAttributedString(string:text, attributes: [NSAttributedStringKey.font:UIFont(name: "Helvetica", size: 17.0)!])
        
        // Set the color
        placeHolder.addAttribute(NSAttributedStringKey.foregroundColor, value: color, range:NSRange(location:0,length:text.characters.count))
        
        // Add attribute
        self.attributedPlaceholder = placeHolder
    }
}
