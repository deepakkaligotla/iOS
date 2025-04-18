//
//  CustomAppShortcutsProvider.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import AppIntents
import SwiftUI

@available(iOS 16.0, macOS 13.0, watchOS 9.0, tvOS 16.0, *)
struct CustomAppShortcutsProvider: AppShortcutsProvider {
    static var shortcutTileColor: ShortcutTileColor = ShortcutTileColor.purple
    static var shortcutsLinkStyle: ShortcutsLinkStyle = ShortcutsLinkStyle.automaticOutline
    
    @AppShortcutsBuilder
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: SearchIntent(),
            phrases: [
                "Search \(.applicationName)",
            ],
            shortTitle: "Search",
            systemImageName: "magnifyingglass"
        )
        AppShortcut(
            intent: Drive2WorkIntent(),
            phrases: [
                "Go to Work \(.applicationName)",
            ],
            shortTitle: "Go to Work",
            systemImageName: "arrow.turn.up.right"
        )
        AppShortcut(
            intent: Back2HomeIntent(),
            phrases: [
                "Back to Home \(.applicationName)",
            ],
            shortTitle: "Back to Home",
            systemImageName: "arrow.turn.left.down"
        )
        AppShortcut(
            intent: OrderFoodIntent(),
            phrases: [
                "Order food \(.applicationName)",
            ],
            shortTitle: "Order food",
            systemImageName: "fork.knife.circle"
        )
        AppShortcut(
            intent: AppIntent1(),
            phrases: [
                "Lets Play game \(.applicationName)",
            ],
            shortTitle: "Lets Play games",
            systemImageName: "gamecontroller"
        )
        AppShortcut(
            intent: AppIntent1(),
            phrases: [
                "Gym time \(.applicationName)",
            ],
            shortTitle: "Gym time",
            systemImageName: "figure.core.training"
        )
        AppShortcut(
            intent: AppIntent1(),
            phrases: [
                "Watch Movie \(.applicationName)",
            ],
            shortTitle: "Watch Movie",
            systemImageName: "movieclapper"
        )
        AppShortcut(
            intent: AppIntent1(),
            phrases: [
                "Take a Selfie \(.applicationName)",
            ],
            shortTitle: "Take a Selfie",
            systemImageName: "camera.aperture"
        )
        AppShortcut(
            intent: AppIntent1(),
            phrases: [
                "Texting \(.applicationName)",
            ],
            shortTitle: "Texting",
            systemImageName: "message"
        )
        AppShortcut(
            intent: AppIntent1(),
            phrases: [
                "Shutdown \(.applicationName)",
            ],
            shortTitle: "Shutdown",
            systemImageName: "bed.double"
        )
    }
}
