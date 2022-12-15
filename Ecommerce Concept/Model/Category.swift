//
//  Category.swift
//  Ecommerce Concept
//
//  Created by APPLE on 09.12.2022.
//

import Foundation

struct CategoryModel: Codable {
    let name: String
    let image: String
    var isSelected: Bool
}

struct Category {

   private let categoryPhones = CategoryModel(name: "Phones",
                                       image: "Phones",
                                       isSelected: true)
    
   private let categoryComputer = CategoryModel(name: "Computer",
                                       image: "Computer",
                                       isSelected: false)
    
   private let categoryHealth = CategoryModel(name: "Health",
                                       image: "Health",
                                       isSelected: false)
    
   private let categoryBooks = CategoryModel(name: "Books",
                                       image: "Books",
                                       isSelected: false)

   private let categoryAllCategory = CategoryModel(name: "AllCategory",
                                       image: "Books",
                                       isSelected: false)
    
    func getCategory() -> [CategoryModel] {
        return [categoryPhones, categoryComputer, categoryHealth, categoryBooks, categoryAllCategory ]
    }
}
