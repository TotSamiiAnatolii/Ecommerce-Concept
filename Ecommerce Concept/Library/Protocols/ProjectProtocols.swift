//
//  ProjectProtocols.swift
//  Ecommerce Concept
//
//  Created by APPLE on 03.12.2022.
//

import Foundation

protocol ConfigurableView {
    
    associatedtype Model
    
    func configure(with model: Model)
}
