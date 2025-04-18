//
//  AppDelegate.swift
//  CustomAppShortcuts
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import UIKit
import Intents
import CloudKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    // MARK: - Initializing the app
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("AppDelegate: willFinishLaunchingWithOptions")
        return true
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        print("AppDelegate: didFinishLaunchingWithOptions")
        return true
    }

    // MARK: - Configuring and discarding scenes
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print("AppDelegate: configurationForConnecting")
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print("AppDelegate: didDiscardSceneSessions")
    }

    // MARK: - Responding to app life-cycle events
    func applicationDidBecomeActive(_ application: UIApplication) {
        print("AppDelegate: applicationDidBecomeActive")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        print("AppDelegate: applicationWillResignActive")
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        print("AppDelegate: applicationDidEnterBackground")
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("AppDelegate: applicationWillEnterForeground")
    }

    func applicationWillTerminate(_ application: UIApplication) {
        print("AppDelegate: applicationWillTerminate")
    }

    // MARK: - Responding to environment changes
    func applicationProtectedDataDidBecomeAvailable(_ application: UIApplication) {
        print("AppDelegate: applicationProtectedDataDidBecomeAvailable")
    }

    func applicationProtectedDataWillBecomeUnavailable(_ application: UIApplication) {
        print("AppDelegate: applicationProtectedDataWillBecomeUnavailable")
    }

    func applicationDidReceiveMemoryWarning(_ application: UIApplication) {
        print("AppDelegate: applicationDidReceiveMemoryWarning")
    }

    func applicationSignificantTimeChange(_ application: UIApplication) {
        print("AppDelegate: applicationSignificantTimeChange")
    }

    // MARK: - Managing app state restoration
    func application(_ application: UIApplication, shouldSaveSecureApplicationState coder: NSCoder) -> Bool {
        print("AppDelegate: shouldSaveSecureApplicationState")
        return true
    }

    func application(_ application: UIApplication, shouldRestoreSecureApplicationState coder: NSCoder) -> Bool {
        print("AppDelegate: shouldRestoreSecureApplicationState")
        return true
    }

    func application(_ application: UIApplication, viewControllerWithRestorationIdentifierPath identifierComponents: [String], coder: NSCoder) -> UIViewController? {
        print("AppDelegate: viewControllerWithRestorationIdentifierPath")
        return nil
    }

    func application(_ application: UIApplication, willEncodeRestorableStateWith coder: NSCoder) {
        print("AppDelegate: willEncodeRestorableStateWith")
    }

    func application(_ application: UIApplication, didDecodeRestorableStateWith coder: NSCoder) {
        print("AppDelegate: didDecodeRestorableStateWith")
    }

    // MARK: - Downloading data in the background
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        print("AppDelegate: handleEventsForBackgroundURLSession")
    }

    // MARK: - Handling remote notification registration
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("AppDelegate: didRegisterForRemoteNotificationsWithDeviceToken")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("AppDelegate: didFailToRegisterForRemoteNotificationsWithError")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("AppDelegate: didReceiveRemoteNotification")
    }

    // MARK: - Continuing user activity and handling quick actions
    func application(_ application: UIApplication, willContinueUserActivityWithType userActivityType: String) -> Bool {
        print("AppDelegate: willContinueUserActivityWithType")
        return true
    }

    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        print("AppDelegate: continue userActivity")
        return true
    }

    func application(_ application: UIApplication, didUpdate userActivity: NSUserActivity) {
        print("AppDelegate: didUpdate userActivity")
    }

    func application(_ application: UIApplication, didFailToContinueUserActivityWithType userActivityType: String, error: Error) {
        print("AppDelegate: didFailToContinueUserActivityWithType")
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        print("AppDelegate: performActionFor shortcutItem")
    }

    // MARK: - Interacting with WatchKit
    func application(_ application: UIApplication, handleWatchKitExtensionRequest userInfo: [AnyHashable: Any]?, reply: @escaping ([AnyHashable: Any]?) -> Void) {
        print("AppDelegate: handleWatchKitExtensionRequest")
    }

    // MARK: - Interacting with HealthKit
    func applicationShouldRequestHealthAuthorization(_ application: UIApplication) {
        print("AppDelegate: applicationShouldRequestHealthAuthorization")
    }

    // MARK: - Opening a URL-specified resource
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print("AppDelegate: open URL")
        handleDeepLink(url, window: self.window)
        return true
    }

    // MARK: - Disallowing specified app extension types
    func application(_ application: UIApplication, shouldAllowExtensionPointIdentifier extensionPointIdentifier: UIApplication.ExtensionPointIdentifier) -> Bool {
        print("AppDelegate: shouldAllowExtensionPointIdentifier")
        return true
    }

    // MARK: - Handling SiriKit intents
    func application(_ application: UIApplication, handlerFor intent: INIntent) -> Any? {
        print("AppDelegate: handlerFor intent")
        return nil
    }

    // MARK: - Handling CloudKit invitations
    func application(_ application: UIApplication, userDidAcceptCloudKitShareWith cloudKitShareMetadata: CKShare.Metadata) {
        print("AppDelegate: called on the main thread after the user indicates they want to accept a CloudKit sharing invitation in this application")
    }

    // MARK: - Localizing keyboard shortcuts
    func applicationShouldAutomaticallyLocalizeKeyCommands(_ application: UIApplication) -> Bool {
        print("AppDelegate: UIKeyCommand system-wide keyboard shortcut localization support")
        return true
    }

    // MARK: - Managing interface geometry
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        print("SceneDelegate: UIWindowScene coordinate space, interface orientation, or trait collection of a changed")
        return .all
    }
}
