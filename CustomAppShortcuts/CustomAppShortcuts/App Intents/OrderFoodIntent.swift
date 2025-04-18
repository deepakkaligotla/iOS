//
//  OrderFood.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 27/06/24.
//

import AppIntents
import UIKit

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct OrderFoodIntent: AppIntent {
    static let intentClassName = ShortcutConstants.orderFoodActivity
    static var title: LocalizedStringResource = "Order Food"
    static var description: IntentDescription = "Order food from menu available in shortcut"
    static var openAppWhenRun: Bool = true
    static var isDiscoverable: Bool = true
    static var authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed
    
    @Parameter(title: "Select Food Item", optionsProvider: FoodItemOptionsProvider())
    var foodItemName: String
    
    @Parameter(title: "Provide quantity", optionsProvider: QuantityOptionsProvider())
    var foodItemQuantity: Int
    
    @Parameter(title: "Make payment", optionsProvider: PaymentOptionsProvider())
    var selectedPayment: String
    
    struct FoodItemOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            return ["Idly", "Biryani", "Pizza", "Cake", "Ice Cream"].compactMap { item in item }
        }
    }

    struct QuantityOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [Int] {
            return [1, 2, 3, 4, 5].compactMap { quantity in quantity }
        }
    }
    
    struct PaymentOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            return ["Internet Banking", "Debit Card", "Credit Card", "UPI", "COD"].compactMap { payment in payment }
        }
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Order for \(\.$foodItemName) of \(\.$foodItemQuantity) quantity, \(\.$selectedPayment) payment succesful") {
            \.$foodItemName
            \.$foodItemQuantity
            \.$selectedPayment
        }
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        var searchURL = URLComponents()
        searchURL.scheme = "customappshortcuts"
        searchURL.host = "orderfood"
        searchURL.queryItems = [
            URLQueryItem(name: "foodItemName", value: foodItemName),
            URLQueryItem(name: "foodItemQuantity", value: String(foodItemQuantity)),
            URLQueryItem(name: "selectedPayment", value: selectedPayment)
        ]
        guard let url = searchURL.url else {
            throw NSError(domain: "IntentError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to create URL"])
        }
        UIApplication.shared.open(url, options: [:]) { success in
            if success {
                print("Opening \(url)")
            } else {
                print("Failed to open \(url)")
            }
        }
        return .result()
    }
}
