//
//  ModelCart.swift
//  Ecommerce Concept
//
//  Created by APPLE on 14.12.2022.
//

import Foundation

struct ModelBasket: Codable {
    let basket: [Basket]
    let delivery: String
    let id: String
    var total: Int
}

struct Basket: Codable {
    let id: Int
    let images: String
    let price: Int
    let title: String
}
