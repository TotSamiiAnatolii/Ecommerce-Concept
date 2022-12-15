//
//  ModelDetailsView.swift
//  Ecommerce Concept
//
//  Created by APPLE on 10.12.2022.
//

import Foundation

struct ModelDetailsView {
    
    let onAction: ((DetailsButton) -> Void)
    
    let title = "Product Details"
    
    let nameProduct: String
    
    let camera: String
    
    let cpu: String
    
    let ssd: String
    
    let sd: String
    
    let color: [String]
    
    let capacity: [String]
    
    let selectColor = "Select color and capacity"
}
