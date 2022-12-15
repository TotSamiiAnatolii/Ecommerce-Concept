//
//  UITextView+.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import UIKit

extension UITextView {

    public func setMyStyle(textAligment: NSTextAlignment, font: UIFont) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment = textAligment
        self.layer.borderWidth = 1
        self.layer.borderColor = Colors.borderFromAndTo
        self.font = font
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        return self
    }
}
