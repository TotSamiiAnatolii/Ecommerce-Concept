//
//  LikeButton.swift
//  Ecommerce Concept
//
//  Created by APPLE on 11.12.2022.
//

import UIKit

final class LikeButton: UIButton {

    override var isHighlighted: Bool {
        didSet {
            tintColor = isHighlighted ? Colors.orange.withAlphaComponent(0.5) : Colors.orange
        }
    }
    
    override var isSelected: Bool {
        didSet {
            
            switch isSelected {
            case true:
                self.setImage(Images.like, for: .normal)
            case false:
                self.setImage(Images.favorites, for: .normal)
            }
        }
    }
}
