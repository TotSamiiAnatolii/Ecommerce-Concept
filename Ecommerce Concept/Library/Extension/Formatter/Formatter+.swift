//
//  Formatter+.swift
//  Ecommerce Concept
//
//  Created by APPLE on 13.12.2022.
//

import Foundation

extension Formatter {
    
    static let formatter = NumberFormatter()
    
    static func formatToCurrency(maximumFractionDigits: Int ) -> NumberFormatter {
        formatter.roundingMode = .up
        formatter.numberStyle = .currencyISOCode
        formatter.locale = Locale.init(identifier: "en_US")
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 1
        formatter.maximumFractionDigits = maximumFractionDigits
        formatter.groupingSeparator = " "
        return formatter
    }
}

