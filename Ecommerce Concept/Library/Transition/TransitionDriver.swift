//
//  TransitionDriver.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import UIKit

enum TransitionDirection {
    case present, dismiss
}

class TransitionDriver: UIPercentDrivenInteractiveTransition {
    
    // MARK: - Linking
    func link(to controller: UIViewController) {
        presentedController = controller
    }
    
    private weak var presentedController: UIViewController?
    private var panRecognizer: UIPanGestureRecognizer?
    
    
    // MARK: - Override
    override var wantsInteractiveStart: Bool {
        get {
            switch direction {
            case .present:
                return false
            case .dismiss:
                let gestureIsActive = panRecognizer?.state == .began
                return gestureIsActive
            }
        }
        
        set { }
    }
    
    // MARK: - Direction
    var direction: TransitionDirection = .present
}

