//
//  Gyroscope.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 12/08/24.
//

import Combine
import CoreMotion

class GyroscopeObserver: ObservableObject {
    private var motionManager = CMMotionManager()
    
    @Published var rotationX: Double = 0.0
    @Published var rotationY: Double = 0.0
    @Published var rotationZ: Double = 0.0

    init() {
        startGyroscopeUpdates()
    }
    
    private func startGyroscopeUpdates() {
        if motionManager.isGyroAvailable {
            motionManager.gyroUpdateInterval = 0.1 // Update every 0.1 seconds
            
            motionManager.startGyroUpdates(to: .main) { [weak self] data, error in
                guard let data = data else { return }
                self?.rotationX = data.rotationRate.x
                self?.rotationY = data.rotationRate.y
                self?.rotationZ = data.rotationRate.z
            }
        } else {
            print("Gyroscope is not available.")
        }
    }
    
    deinit {
        motionManager.stopGyroUpdates()
    }
}
