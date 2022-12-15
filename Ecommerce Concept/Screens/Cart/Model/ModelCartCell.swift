//
//  ModelCell.swift
//  Ecommerce Concept
//
//  Created by APPLE on 07.12.2022.
//

import UIKit

struct ModelCartCell {
    
    var count: Int
    
    let titleProduct: String

    let price: Int

    var totalSum: Int {
        return price * count
    }
    
    let onAction: ((UIButton)-> Void)
    
    let photo: UIImage
}
