//
//  ModelFilterView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 11.12.2022.
//

import UIKit

struct ModelFilterView {
    
    let onAction: ((PositionFilter) -> Void)?
    
    let onACtionNavBar: ((NavBarItem) -> Void)?
    
    let title = "Filter options"
    
    let brand = "Brand"
    
    let price = "Price"
    
    let size = "Size"
    
    var brandPlaceholder: String
    
    var pricePlaceholder: String
    
    let sizePlaceholder: String
}
