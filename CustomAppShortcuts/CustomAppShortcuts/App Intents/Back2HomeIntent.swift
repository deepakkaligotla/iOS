//
//  Drive2HomeIntent.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 20/06/24.
//

import AppIntents
import UIKit

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct Back2HomeIntent: AppIntent {
    static let intentClassName = ShortcutConstants.back2HomeActivity
    static var title: LocalizedStringResource = "Back to Home Intent"
    static var description: IntentDescription = "Back 2 Home functionality"
    static var openAppWhenRun: Bool = true
    static var isDiscoverable: Bool = true
    static var authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed
    
    @Parameter(title: "Select Origin Place", optionsProvider: OriginOptionsProvider())
    var selectedOrigin: String
    
    @Parameter(title: "Select vehicle type", optionsProvider: VehicleOptionsProvider())
    var selectedVehicle: String
    
    struct OriginOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            return ["Work", "Marathalli", "Kr Puram", "Whitefield", "Electronic City"].compactMap { origin in origin }
        }
    }

    struct VehicleOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            return ["Prime Sedan", "Prime SUV", "Mini", "Auto", "Bike", "E-Bike"].compactMap { vehicleType in vehicleType }
        }
    }

    static var parameterSummary: some ParameterSummary {
        Summary("Book ride to work from \(\.$selectedOrigin) using \(\.$selectedVehicle)") {
            \.$selectedOrigin
            \.$selectedVehicle
        }
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        var drive2WorkURL = URLComponents()
        drive2WorkURL.scheme = "customappshortcuts"
        drive2WorkURL.host = "back2home"
        drive2WorkURL.queryItems = [
            URLQueryItem(name: "originFromShortcut", value: selectedOrigin),
            URLQueryItem(name: "vehicleFromShortcut", value: selectedVehicle)
        ]
        guard let url = drive2WorkURL.url else {
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
