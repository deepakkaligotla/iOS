//
//  SearchIntent.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 20/06/24.
//

import AppIntents
import UIKit

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct SearchIntent: AppIntent {
    static let intentClassName = ShortcutConstants.searchActivity
    static var title: LocalizedStringResource = "Search Intent"
    static var description: IntentDescription = "Open search functionality"
    static var openAppWhenRun: Bool = true
    static var isDiscoverable: Bool = true
    static var authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed
    
    @Parameter(title: "Search")
    var searchString: String
    
    static var parameterSummary: some ParameterSummary {
        Summary("Searching \(\.$searchString) in app") {
            \.$searchString
        }
    }

    @MainActor
    func perform() async throws -> some IntentResult {
        var searchURL = URLComponents()
        searchURL.scheme = "customappshortcuts"
        searchURL.host = "search"
        searchURL.queryItems = [
            URLQueryItem(name: "searchString", value: searchString)
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
