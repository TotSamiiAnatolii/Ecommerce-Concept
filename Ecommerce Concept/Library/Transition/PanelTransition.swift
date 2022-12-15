//
//  PanelTransition.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import UIKit

class PanelTransition: NSObject, UIViewControllerTransitioningDelegate {
    
    private let driver = TransitionDriver()
    
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        driver.link(to: presented)
        
        let presentationController = DimmPresentationController(presentedViewController: presented,
                                                                presenting: presenting ?? source)
        presentationController.driver = driver
        return presentationController
    }
}
