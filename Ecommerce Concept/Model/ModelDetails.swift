//
//  ModelDetails.swift
//  Ecommerce Concept
//
//  Created by APPLE on 14.12.2022.
//

import Foundation

// MARK: - ModelDetail
struct ModelDetail: Codable {
    let cpu: String
    let camera: String
    let capacity: [String]
    let color: [String]
    let id: String
    let images: [String]
    let isFavorites: Bool
    let price: Int
    let rating: Double
    let sd: String
    let ssd: String
    let title: String

    enum CodingKeys: String, CodingKey {
        case cpu = "CPU"
        case camera
        case capacity
        case color
        case id
        case images
        case isFavorites
        case price
        case rating
        case sd
        case ssd
        case title
    }
}
