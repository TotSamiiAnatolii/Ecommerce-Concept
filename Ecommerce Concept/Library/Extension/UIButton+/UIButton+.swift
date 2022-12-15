//
//  UIButton+.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import UIKit

extension UIButton {
    
    public typealias Func = () -> ()
    
    public func setMyStyle(backgroundColor: UIColor) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = 0
        self.contentMode = .scaleAspectFill
        self.clipsToBounds = false
        return self
    }
    
    public func setTarget( method methodDown: Selector, target: Any, event: UIControl.Event ) -> Self {

        self.addTarget(target, action: methodDown.self, for: event)
        
        return self
    }

    public func addImage(image: UIImage?) -> Self {
        guard let image = image else {return self}
        let highlighted = image.withAlpha(0.5)
        self.setImage(image, for: .normal)
        self.setImage(highlighted, for: .highlighted)
        return self
    }
    
    public func setTitle(font: UIFont, title: String, color: UIColor) -> Self {
        self.titleLabel?.font = font
        self.setTitle(title, for: .normal)
        self.setTitleColor(color, for: .normal)
        self.setTitleColor(color.withAlphaComponent(0.5), for: .highlighted)
        return self
    }
    
    public func setTintColor(color: UIColor) -> Self {
        self.tintColor = color
        return self
    }
    
    public func setBorder(width: CGFloat, color: UIColor) -> Self {
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
        return self
    }
}
extension UIImage {
    func withAlpha(_ a: CGFloat) -> UIImage {
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { (_) in
            draw(in: CGRect(origin: .zero, size: size), blendMode: .normal, alpha: a)
        }
    }
}
