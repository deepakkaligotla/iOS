//
//  OdometerView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 23/08/24.
//

import SwiftUI
import CoreMotion

struct OdometerView: View {
    @StateObject private var odometerManager = OdometerManager()
    
    var body: some View {
        VStack {
            Text("Odometer")
                .font(.title)
                .padding()
            
            Image(systemName: "speedometer")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .padding()
            
            VStack {
                Text("Speed: \(odometerManager.speed, specifier: "%.2f") km/h")
                Text("Delta Distance: \(odometerManager.deltaDistance, specifier: "%.2f") meters")
                Text("Slope: \(odometerManager.slope ?? 0.0, specifier: "%.2f") degrees")
                Text("Altitude Change: \(odometerManager.deltaAltitude, specifier: "%.2f") meters")
                Text("Speed Accuracy: \(odometerManager.speedAccuracy, specifier: "%.2f") km/h")
                Text("Distance Accuracy: \(odometerManager.deltaDistanceAccuracy, specifier: "%.2f") meters")
            }
            .font(.body)
            .padding()
        }
        .onAppear {
            odometerManager.startFetchingOdometerData()
        }
        .onDisappear {
            odometerManager.stopFetchingOdometerData()
        }
    }
}

class OdometerManager: NSObject, ObservableObject {
    @Published var speed: CLLocationSpeed = 0.0
    @Published var deltaDistance: CLLocationDistance = 0.0
    @Published var slope: Double? = nil
    @Published var deltaAltitude: CLLocationDistance = 0.0
    @Published var speedAccuracy: CLLocationSpeedAccuracy = 0.0
    @Published var deltaDistanceAccuracy: CLLocationAccuracy = 0.0
    
    private var timer: Timer?

    func startFetchingOdometerData() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.fetchOdometerData()
        }
    }
    
    func stopFetchingOdometerData() {
        timer?.invalidate()
        timer = nil
    }
    
    private func fetchOdometerData() {
        let sampleData = CMOdometerData()
        
        DispatchQueue.main.async {
            self.speed = sampleData.speed * 3.6
            self.deltaDistance = sampleData.deltaDistance
            self.slope = sampleData.slope
            self.deltaAltitude = sampleData.deltaAltitude
            self.speedAccuracy = sampleData.speedAccuracy * 3.6
            self.deltaDistanceAccuracy = sampleData.deltaDistanceAccuracy
        }
    }
}

#Preview {
    OdometerView()
}
