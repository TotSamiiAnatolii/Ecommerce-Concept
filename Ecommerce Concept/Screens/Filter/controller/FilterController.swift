//
//  FilterController.swift
//  Ecommerce Concept
//
//  Created by APPLE on 08.12.2022.
//

import UIKit

protocol FilterDelegate: AnyObject {
    func filterBrand(brand: String)
    func filterPrice(from: Int, to: Int)
}

final class FilterController: UIViewController {
   
    private var model: ModelFilterView!
    
    fileprivate var filterView: FilterView {
        guard let view = self.view as? FilterView else { return FilterView() }
        return view
    }
    
    weak var delegate: FilterDelegate?
    
    public let transition = PanelTransition()
    
    public var coordinator: ((PositionFilter) -> Void)?
    
    private var fromPrice: Int = 0
    
    private var toPrice: Int = 0
    
    private var brand = ""
    
    override func loadView() {
        super.loadView()
        self.view = FilterView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        model = ModelFilterView(
             onAction: { [weak self] type in
                 self?.buttonAction(type: type)
             },
             onACtionNavBar: { [weak self] item in
                 self?.navBarItemAction(item: item)
             },
             brandPlaceholder: "Samsung",
             pricePlaceholder: "$200 - $800",
             sizePlaceholder: "4.5 - 5.5 inches")
        configureView(model: model)
    }

    private func configureView(model: ModelFilterView) {
        let radius: CGFloat = 30
       
        filterView.configure(with: model)
        self.view.layer.cornerRadius = radius
    }
    
    private func buttonAction(type: PositionFilter) {
        switch type {
        case .brand:
            coordinator?(.brand)
        case .price:
            coordinator?(.price)
        case .size:
            coordinator?(.size)
        }
    }
    
    private func navBarItemAction(item: NavBarItem) {
        
        switch item {
        case .close:
            self.dismiss(animated: true)
        case .done:
            delegate?.filterPrice(from: fromPrice, to: toPrice)
            delegate?.filterBrand(brand: brand)
            self.dismiss(animated: true)
        }
    }
}
extension FilterController: BrandDelegate {
    func titleBrand(title: String) {
        self.brand = title
        model.brandPlaceholder = title
        configureView(model: model)
    }
}
extension FilterController: PriceDelegate {
    func priceRange(from: Int, to: Int) {
        self.fromPrice = from
        self.toPrice = to
        model.pricePlaceholder = "$\(fromPrice) - $\(toPrice)"
        configureView(model: model)
        print(from)
        print(to)
    }
}
