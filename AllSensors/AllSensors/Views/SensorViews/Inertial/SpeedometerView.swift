//
//  SpeedometerView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreLocation
import BackgroundTasks

struct SpeedometerView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            Text("Speed: \(locationManager.speed, specifier: "%.2f") km/h")
                .font(.largeTitle)
                .padding()

            Text("Max Speed: \(locationManager.maxSpeed, specifier: "%.2f") km/h")
                .font(.headline)
                .padding()

            Text("Distance Traveled: \(locationManager.distanceTraveled / 1000, specifier: "%.2f") km")
                .font(.headline)
                .padding()

            Text("Time Running: \(formatTimeInterval(locationManager.timeRunning))")
                .font(.subheadline)
                .padding()

            Text("Time Stopped: \(formatTimeInterval(locationManager.timeStopped))")
                .font(.subheadline)
                .padding()
        }
        .onAppear {
            locationManager.startFetchingLocationData()
        }
        .onDisappear {
            locationManager.stopFetchingLocationData()
        }
    }

    // Helper function to format TimeInterval to hh:mm:ss
    private func formatTimeInterval(_ interval: TimeInterval) -> String {
        let hours = Int(interval) / 3600
        let minutes = (Int(interval) % 3600) / 60
        let seconds = Int(interval) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    @Published var speed: CLLocationSpeed = 0.0
    @Published var maxSpeed: CLLocationSpeed = 0.0
    @Published var distanceTraveled: CLLocationDistance = 0.0
    @Published var timeRunning: TimeInterval = 0.0
    @Published var timeStopped: TimeInterval = 0.0

    private var lastLocation: CLLocation?
    private var isStopped = false
    private var stopStartTime = Date()
    private var startTime = Date()

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }

    func startFetchingLocationData() {
        let identifier = "in.kaligotla.allsensors.backgroundTask"
        let request = BGAppRefreshTaskRequest(identifier: identifier)
        request.earliestBeginDate = Date(timeIntervalSinceNow: 60 * 60)
        do {
            try BGTaskScheduler.shared.submit(request)
        } catch {
            print("Error scheduling background task: \(error)")
        }
    }

    func stopFetchingLocationData() {
        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }

        // Update speed
        speed = location.speed * 3.6 // Convert m/s to km/h
        maxSpeed = max(maxSpeed, speed)

        // Update distance traveled
        if let lastLocation = lastLocation {
            distanceTraveled += location.distance(from: lastLocation)
        }
        lastLocation = location

        // Update time running and time stopped
        timeRunning = Date().timeIntervalSince(startTime)
        if isStopped {
            timeStopped += Date().timeIntervalSince(stopStartTime)
        } else {
            stopStartTime = Date()
        }
        isStopped = location.speed < 0.1 // Adjust the threshold as needed

        objectWillChange.send()
    }

    // Implement BGTaskScheduler delegate methods directly
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Handle remote notification registration
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Handle remote notification registration failure
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Handle remote notification and background fetch
        completionHandler(.newData)
    }
}

#Preview {
    SpeedometerView()
}
