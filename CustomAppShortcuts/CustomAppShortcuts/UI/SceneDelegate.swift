//
//  SceneDelegate.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    // MARK: - Connecting and disconnecting the scene
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        print("SceneDelegate: willConnectTo")
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        print("SceneDelegate: sceneDidDisconnect")
    }
    
    // MARK: - Transitioning to the foreground
    func sceneWillEnterForeground(_ scene: UIScene) {
        print("SceneDelegate: sceneWillEnterForeground")
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        print("SceneDelegate: sceneDidBecomeActive")
    }
    
    // MARK: - Transitioning to the background
    func sceneWillResignActive(_ scene: UIScene) {
        print("SceneDelegate: sceneWillResignActive")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        print("SceneDelegate: sceneDidEnterBackground")
    }
    
    // MARK: - Opening URLs
    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        print("SceneDelegate: openURLContexts")
        if let url = URLContexts.first?.url {
            handleDeepLink(url, window: self.window)
        }
    }
    
    // MARK: - Continuing user activities
    func scene(_ scene: UIScene, willContinueUserActivityWithType userActivityType: String) {
        print("SceneDelegate: willContinueUserActivityWithType")
    }
    
    func scene(_ scene: UIScene, continue userActivity: NSUserActivity) {
        print("SceneDelegate: continue userActivity")
    }
    
    func scene(_ scene: UIScene, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        print("SceneDelegate: didFailToContinueUserActivityWithType")
    }
    
    // MARK: - Saving the state of the scene
    func stateRestorationActivity(for scene: UIScene) -> NSUserActivity? {
        print("SceneDelegate: stateRestorationActivity")
        return nil
    }
    
    func scene(_ scene: UIScene, restoreInteractionStateWith userActivity: NSUserActivity) {
        print("SceneDelegate: restoreInteractionStateWith")
    }
    
    func scene(_ scene: UIScene, didUpdate userActivity: NSUserActivity) {
        print("SceneDelegate: didUpdate userActivity")
    }
}
