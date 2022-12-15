//
//  UILabel+.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

extension UILabel {
    
    public func setMyStyle(numberOfLines: Int, textAlignment: NSTextAlignment, font: UIFont) -> Self {
        self.numberOfLines = numberOfLines
        self.textAlignment = textAlignment
        self.font = font
        self.translatesAutoresizingMaskIntoConstraints = false
        return self
    }
    
    public func setTextColor(color: UIColor) -> Self {
        self.textColor = color
        return self
    }
    
    public func setHidden() -> Self {
        self.isHidden = true
        return self
    }
    
    public func setLineBreakMode(lineBreak: NSLineBreakMode ) -> Self {
        self.lineBreakMode = lineBreak
        return self
    }
    
 
    public func setStrikethroughStyle() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}
