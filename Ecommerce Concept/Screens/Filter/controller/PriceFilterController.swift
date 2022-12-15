//
//  PriceFilterController.swift
//  Ecommerce Concept
//
//  Created by APPLE on 11.12.2022.
//

import UIKit

protocol PriceDelegate: AnyObject {
    func priceRange(from: Int, to: Int) 
}

final class PriceFilterController: UIViewController {
    
    fileprivate var priceFilterView: PriceFilterView {
        guard let view = self.view as? PriceFilterView else { return PriceFilterView() }
        return view
    }
    
    weak var delegate: PriceDelegate?
    
    private var fromPrice: Int = 0
    
    private var toPrice: Int = 0
    
    override func loadView() {
        super.loadView()
        self.view = PriceFilterView(frame: UIScreen.main.bounds)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView() {
        let radius: CGFloat = 30
        self.view.layer.cornerRadius = radius
        priceFilterView.configure(with: ModelPriceView(
            onAction: {[weak self] type in
                self?.navBarItemAction(item: type)
            }))
        
        priceFilterView.sliderAction = {[weak self] from, to in
            
            self?.fromPrice = Int(from)
            self?.toPrice = Int(to)
        }
    }
    
    private func navBarItemAction(item: NavBarItem) {
        switch item {
        case .close:
            self.dismiss(animated: true)
        case .done:
            self.delegate?.priceRange(from: fromPrice, to: toPrice)
            self.dismiss(animated: true)
        }
    }
}
