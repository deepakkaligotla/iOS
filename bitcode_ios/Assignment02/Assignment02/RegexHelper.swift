//
//  RegexHelper.swift
//  Assignment02
//
//  Created by Deepak Kaligotla on 11/03/25.
//

import Foundation

class RegexHelper {
    static func isValidMathExpression(_ expression: String) -> Bool {
        let pattern = #"^\s*-?(\d+(\.\d+)?)(\s*[\+\-\*/]\s*-?(\d+(\.\d+)?))*\s*$"#
        return expression.range(of: pattern, options: .regularExpression) != nil
    }

    static func cleanExpression(_ expression: String) -> String {
        var cleanedExpression = expression
        cleanedExpression = cleanedExpression.replacingOccurrences(of: "\\s+", with: "", options: .regularExpression) // Remove spaces
        cleanedExpression = cleanedExpression.replacingOccurrences(of: "--", with: "+") // Fix double negatives
        cleanedExpression = cleanedExpression.replacingOccurrences(of: "\\+{2,}", with: "+", options: .regularExpression) // Remove duplicate +
        cleanedExpression = cleanedExpression.replacingOccurrences(of: "-{2,}", with: "-", options: .regularExpression) // Remove duplicate -
        cleanedExpression = cleanedExpression.replacingOccurrences(of: "[\\*/]{2,}", with: "*", options: .regularExpression) // Fix repeated * or /
        return cleanedExpression
    }
}
