//
//  Drive2WorkIntent.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 20/06/24.
//

import AppIntents
import UIKit

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct Drive2WorkIntent: AppIntent {
    static let intentClassName = ShortcutConstants.drive2WorkActivity
    static var title: LocalizedStringResource = "Drive to Work Intent"
    static var description: IntentDescription = IntentDescription("Drive 2 Work functionality")
    static var openAppWhenRun: Bool = true
    static var isDiscoverable: Bool = true
    static var authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed
    
    @Parameter(title: "Select Origin Place", optionsProvider: OriginOptionsProvider())
    var selectedOrigin: String
    
    struct OriginOptionsProvider: DynamicOptionsProvider {
        func results() async throws -> [String] {
            return ["Home", "Marathalli", "Kr Puram", "Whitefield", "Electronic City"].compactMap { origin in origin }
        }
    }
    
    static var parameterSummary: some ParameterSummary {
        Summary("Book ride to work from \(\.$selectedOrigin)") {
            \.$selectedOrigin
        }
    }

    @MainActor
    func perform() async throws -> some IntentResult {
//        guard let selectedOrigin = selectedOrigin, !selectedOrigin.isEmpty else {
//            throw NSError(domain: "IntentError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Invalid selected origin"])
//        }
        var drive2WorkURL = URLComponents()
        drive2WorkURL.scheme = "customappshortcuts"
        drive2WorkURL.host = "drive2work"
        drive2WorkURL.queryItems = [
            URLQueryItem(name: "originFromShortcut", value: selectedOrigin)
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
