//
//  LocationHandler.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import CoreLocation

@MainActor class LocationsHandler: ObservableObject {
    static let shared = LocationsHandler()
    private let manager: CLLocationManager
    private var background: CLBackgroundActivitySession?
    
    @Published var lastLocation = CLLocation()
    @Published var count = 0
    @Published var isStationary = false
    
    @Published
    var updatesStarted: Bool = UserDefaults.standard.bool(forKey: "liveUpdatesStarted") {
        didSet { UserDefaults.standard.set(updatesStarted, forKey: "liveUpdatesStarted") }
    }
    
    @Published
    var backgroundActivity: Bool = UserDefaults.standard.bool(forKey: "BGActivitySessionStarted") {
        didSet {
            backgroundActivity ? self.background = CLBackgroundActivitySession() : self.background?.invalidate()
            UserDefaults.standard.set(backgroundActivity, forKey: "BGActivitySessionStarted")
        }
    }
    
    private init() {
        self.manager = CLLocationManager()
    }
    
    func startLocationUpdates() {
        if self.manager.authorizationStatus == .notDetermined {
            self.manager.requestAlwaysAuthorization()
        }
        Task() {
            do {
                self.updatesStarted = true
                let updates = CLLocationUpdate.liveUpdates()
                for try await update in updates {
                    if !self.updatesStarted { break }
                    if let loc = update.location {
                        self.lastLocation = loc
                        self.isStationary = update.isStationary
                        self.count += 1
                    }
                }
            } catch {
                print("Could not start location updates")
            }
            return
        }
    }
    
    func stopLocationUpdates() {
        self.updatesStarted = false
    }
}

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var locationPermissionStatus: CLAuthorizationStatus = CLLocationManager.authorizationStatus()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        DispatchQueue.main.async {
            self.locationPermissionStatus = status
        }
    }
}
