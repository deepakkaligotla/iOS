//
//  Accelerometer.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 12/08/24.
//

import Combine
import CoreMotion
import SensorKit

class CMAccelerometerObserver: ObservableObject {
    private var motionManager = CMMotionManager()
    private var timer: Timer?
    
    @Published var x: Double = 0.0
    @Published var y: Double = 0.0
    @Published var z: Double = 0.0

    init() {
        startAccelerometerUpdates()
    }
    
    private func startAccelerometerUpdates() {
        if motionManager.isAccelerometerAvailable {
            motionManager.accelerometerUpdateInterval = 0.1 // Update every 0.1 seconds
            
            motionManager.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                guard let data = data else { return }
                self?.x = data.acceleration.x
                self?.y = data.acceleration.y
                self?.z = data.acceleration.z
            }
        } else {
            print("Accelerometer is not available.")
        }
    }
    
    deinit {
        motionManager.stopAccelerometerUpdates()
    }
}

class SKAccelerometerObserver: ObservableObject {
    
    
}
