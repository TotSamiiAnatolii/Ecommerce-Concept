//
//  CheckButton.swift
//  Ecommerce Concept
//
//  Created by APPLE on 14.12.2022.
//

import UIKit

final class CheckButton: UIButton {
    override var isHighlighted: Bool {
        didSet {
            tintColor = isHighlighted ? Colors.orange.withAlphaComponent(0.5) : Colors.orange
        }
    }
    
    override var isSelected: Bool {
        didSet {
            
            switch isSelected {
            case true:
                self.setImage(Images.checkmark, for: .normal)
            case false:
                self.setImage(Images.check, for: .normal)
            }
        }
    }
}
