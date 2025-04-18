//
//  OpenTimeEfficientIntent.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 21/06/24.
//

import AppIntents
import UIKit

struct OpenAppIntent: AppIntent {
    static let intentClassName = ShortcutConstants.openMyAppActivity
    static var title: LocalizedStringResource = "Open App"
    static var description: IntentDescription = "Open App functionality"
    static var openAppWhenRun: Bool = true
    static var isDiscoverable: Bool = true
    static var authenticationPolicy: IntentAuthenticationPolicy = .alwaysAllowed
    
    @MainActor
    func perform() async throws -> some IntentResult {
        return .result()
    }
}
