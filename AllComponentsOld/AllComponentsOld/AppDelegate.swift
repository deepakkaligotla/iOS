//
//  AppDelegate.swift
//  AllComponentsOld
//
//  Created by Deepak Kaligotla on 02/05/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder {
    var window: UIWindow?
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "AllComponentsOld")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SplashVC")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            if let window = windowScene.windows.first {
                window.rootViewController = initialViewController
                window.makeKeyAndVisible()
            }
        }
        let imageViews = UIApplicationShortcutItem(type: "in.kaligotla.AllComponentsOld.ImageViews", localizedTitle: "New Note", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(templateImageName: "new_note_icon"), userInfo: nil)
        application.shortcutItems = [imageViews]
        return true
    }
}

// MARK: UISceneSession Lifecycle
extension AppDelegate {
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}

// MARK: - Core Data Saving support
extension AppDelegate {
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
