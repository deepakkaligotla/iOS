//
//  HomeView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import SwiftUI
import CoreLocation

struct PermissionView: View {
    @StateObject private var locationManager = LocationManager()
    @ObservedObject var locationsHandler = LocationsHandler.shared
    @State private var navigateToMain = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if locationManager.locationPermissionStatus == .authorizedAlways || locationManager.locationPermissionStatus == .authorizedWhenInUse {
                    VStack {
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
                    }
                } else if CLLocationManager.locationServicesEnabled() {
                    VStack {
                        Section(header: Text("Grant location permission").font(.title2).bold()) {
                            Button(self.locationsHandler.updatesStarted ? "Stop Location Updates" : "Start Location Updates") {
                                self.locationsHandler.updatesStarted ? self.locationsHandler.stopLocationUpdates() : self.locationsHandler.startLocationUpdates()
                            }
                            .buttonStyle(.bordered)
                        }
                       
                        Section(header: Text("Grant background location permission").font(.title2).bold()) {
                            Button(self.locationsHandler.backgroundActivity ? "Stop BG Activity Session" : "Start BG Activity Session") {
                                self.locationsHandler.backgroundActivity.toggle()
                            }
                            .buttonStyle(.bordered)
                        }
                    }
                } else {
                    VStack {
                        Text("Location is not turned ON.")
                            .font(.headline)
                            .padding()
                        
                        Button(action: {
                            if let settingsUrl = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
                            }
                        }) {
                            Text("Turn ON device Location Settings")
                                .font(.headline)
                                .bold()
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, maxHeight: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                                .padding(.horizontal, 40)
                        }
                    }
                }
                
                NavigationLink(
                    destination: MainView().navigationBarBackButtonHidden(true),
                    isActive: $navigateToMain,
                    label: {
                        EmptyView()
                    }
                )
            }
            .onChange(of: locationManager.locationPermissionStatus) { newValue in
                if (newValue == .authorizedAlways || newValue == .authorizedWhenInUse) && CLLocationManager.locationServicesEnabled() {
                    navigateToMain = true
                }
            }
        }
    }
}

#Preview {
    PermissionView()
}
