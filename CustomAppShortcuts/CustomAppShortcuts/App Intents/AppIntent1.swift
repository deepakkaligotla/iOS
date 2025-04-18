//
//  AppIntent1.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import AppIntents
import UIKit

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct AppIntent1: AppIntent, CustomIntentMigratedAppIntent {
    static let intentClassName = "AppIntent1"
    static var title: LocalizedStringResource = "App Intent 1"
    
    @Parameter(title: "Shortcut Type")
    var shortcutType: String
    
    static var parameterSummary: some ParameterSummary {
        Summary("Perform \(\.$shortcutType)") {
            \.$shortcutType
        }
    }
    
    @MainActor
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
