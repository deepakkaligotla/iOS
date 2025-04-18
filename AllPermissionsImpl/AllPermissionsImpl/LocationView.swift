//
//  LocationView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
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

struct LocationView: View {
    @State var locationPermissionStatus = CLLocationManager().authorizationStatus
    @ObservedObject var locationsHandler = LocationsHandler.shared
    
    var body: some View {
        VStack {
            if locationPermissionStatus == .authorizedAlways || locationPermissionStatus == .authorizedWhenInUse {
                Text("Course: \(self.locationsHandler.lastLocation.course), Accuracy: \(self.locationsHandler.lastLocation.courseAccuracy)")
                Text("Altitude: \(self.locationsHandler.lastLocation.altitude)")
                Text("Horizontal: \(self.locationsHandler.lastLocation.horizontalAccuracy), Vertical: \(self.locationsHandler.lastLocation.verticalAccuracy)")
                Text("Speed: \(self.locationsHandler.lastLocation.speed) & Accuracy: \(self.locationsHandler.lastLocation.speedAccuracy)")
                
                Text("Latitude: \(self.locationsHandler.lastLocation.coordinate.latitude), Longitude: \(self.locationsHandler.lastLocation.coordinate.longitude)")
                    .foregroundColor(.blue)
                    .underline()
                    .onTapGesture {
                        if let url = URL(string: "https://maps.google.com/?q=\(self.locationsHandler.lastLocation.coordinate.latitude), \(self.locationsHandler.lastLocation.coordinate.longitude)") {
                            UIApplication.shared.open(url)
                        }
                    }
                Text("Last Updated on \(self.locationsHandler.lastLocation.timestamp)").font(.caption)
                
                Text("Count: \(self.locationsHandler.count)")
                Image(systemName: "location.fill").foregroundColor(self.locationsHandler.isStationary ? .green : .red)
                
                Button(self.locationsHandler.updatesStarted ? "Stop Location Updates" : "Start Location Updates") {
                    self.locationsHandler.updatesStarted ? self.locationsHandler.stopLocationUpdates() : self.locationsHandler.startLocationUpdates()
                }
                .buttonStyle(.bordered)
                Button(self.locationsHandler.backgroundActivity ? "Stop BG Activity Session" : "Start BG Activity Session") {
                    self.locationsHandler.backgroundActivity.toggle()
                }
                .buttonStyle(.bordered)
            } else {
                Button(action: {
                    self.locationsHandler.startLocationUpdates()
                }) {
                    Text("Grant permission")
                }
            }
        }
    }
}

struct LocationView_Previews: PreviewProvider {
    static var previews: some View {
        LocationView()
    }
}
