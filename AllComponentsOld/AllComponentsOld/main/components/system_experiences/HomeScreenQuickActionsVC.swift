//
//  HomeScreenQuickActionsVC.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 06/05/24.
//

import UIKit
import AppIntents

extension AppDelegate {
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        switch shortcutItem.type {
        case "in.kaligotla.AllComponentsOld.ImageViews":
            return
        default:
            break
        }
        completionHandler(true)
    }
}
