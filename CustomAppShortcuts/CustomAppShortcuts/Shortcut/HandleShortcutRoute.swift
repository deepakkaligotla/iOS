//
//  HandleShortcutRoute.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 21/06/24.
//

import Foundation
import UIKit

public func handleDeepLink(_ url: URL, window: UIWindow?) {
    guard let window = window else {
        print("Main window is not set")
        return
    }
    
    print("Handling deep link - Scheme: \(url.scheme ?? ""), Host: \(url.host ?? "")")
    if url.scheme == "customappshortcuts", let host = url.host {
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        let originFromShortcut = queryItems?.first(where: { $0.name == "originFromShortcut" })?.value
        let searchStringFromShortcut = queryItems?.first(where: { $0.name == "searchString" })?.value
        let vehicleFromShortcut = queryItems?.first(where: { $0.name == "vehicleFromShortcut" })?.value
        let foodItemFromShortcut = queryItems?.first(where: { $0.name == "foodItemName" })?.value
        let foodQuantityFromShortcut = Int(queryItems?.first(where: { $0.name == "foodItemQuantity" })?.value ?? "0")
        let paymentFromShortcut = queryItems?.first(where: { $0.name == "selectedPayment" })?.value
        
        switch host {
        case "search":
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchVC") as? SearchVC else {
                return
            }
            viewController.searchQuery = searchStringFromShortcut
            if let rootViewController = window.rootViewController as? UINavigationController {
                rootViewController.pushViewController(viewController, animated: true)
            }

        case "drive2work":
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Drive2WorkVC") as? Drive2WorkVC else {
                return
            }
            viewController.selectedOrigin = originFromShortcut
            if let rootViewController = window.rootViewController as? UINavigationController {
                rootViewController.pushViewController(viewController, animated: true)
            }
            
        case "back2home":
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Back2HomeVC") as? Back2HomeVC else {
                print("Failed to instantiate SearchVC from storyboard")
                return
            }
            viewController.selectedOrigin = originFromShortcut
            viewController.selectedVehicle = vehicleFromShortcut
            if let rootViewController = window.rootViewController as? UINavigationController {
                rootViewController.pushViewController(viewController, animated: true)
            }
            
        case "orderfood":
            guard let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "OrderFoodVC") as? OrderFoodVC else {
                print("Failed to instantiate OrderFoodVC from storyboard")
                return
            }
            viewController.selectedFoodItem = foodItemFromShortcut
            viewController.foodQuantity = foodQuantityFromShortcut
            viewController.selectedPayment = paymentFromShortcut
            if let rootViewController = window.rootViewController as? UINavigationController {
                rootViewController.pushViewController(viewController, animated: true)
            }

        default:
            break
        }
    }
}
