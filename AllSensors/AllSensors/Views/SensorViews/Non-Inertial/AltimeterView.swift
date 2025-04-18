//
//  AltimeterView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct AltimeterView: View {
    @StateObject private var altimeterManager = AltimeterManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Altimeter")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image("altimeter")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
                
                if let altitude = altimeterManager.relativeAltitude {
                    Text("Altitude: \(altitude, specifier: "%.2f") meters")
                        .font(.title)
                        .padding()
                } else {
                    Text("Fetching altimeter data...")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .onAppear {
            altimeterManager.startRelativeAltitudeUpdates()
        }
        .onDisappear {
            altimeterManager.stopAltitudeUpdates()
        }
    }
}

class AltimeterManager: ObservableObject {
    private let altimeter = CMAltimeter()
    @Published var relativeAltitude: Double?
    
    init() {
        startRelativeAltitudeUpdates()
    }
    
    deinit {
        stopAltitudeUpdates()
    }
    
    func startRelativeAltitudeUpdates() {
        guard CMAltimeter.isRelativeAltitudeAvailable() else {
            print("Relative altitude is not available on this device.")
            return
        }
        
        altimeter.startRelativeAltitudeUpdates(to: OperationQueue.main) { [weak self] data, error in
            if let error = error {
                print("Altimeter error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                DispatchQueue.main.async {
                    self?.relativeAltitude = data.relativeAltitude.doubleValue
                }
            }
        }
    }
    
    func stopAltitudeUpdates() {
        altimeter.stopRelativeAltitudeUpdates()
    }
}

#Preview {
    AltimeterView()
}
