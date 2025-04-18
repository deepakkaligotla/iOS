//
//  GyroscopeView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct GyroscopeView: View {
    @StateObject private var motionManager = GyroMotionManager()

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Gyroscope")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    GifImageView("gyroscope")
                        .scaledToFit()
                        .background(Color.clear)
                        .frame(width: 200, height: 200)
                }
                VStack {
                    Text("Rotation Rate X: \(motionManager.rotationRateX, specifier: "%.2f") rad/s")
                    Text("Rotation Rate Y: \(motionManager.rotationRateY, specifier: "%.2f") rad/s")
                    Text("Rotation Rate Z: \(motionManager.rotationRateZ, specifier: "%.2f") rad/s")
                }
                .font(.title3)
                .padding()
            }
        }
        .onAppear {
            motionManager.startGyroscope()
        }
        .onDisappear {
            motionManager.stopGyroscope()
        }
    }
}

class GyroMotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var rotationRateX: Double = 0.0
    @Published var rotationRateY: Double = 0.0
    @Published var rotationRateZ: Double = 0.0
    
    func startGyroscope() {
        if motion.isGyroAvailable {
            motion.gyroUpdateInterval = 0.1
            motion.startGyroUpdates(to: OperationQueue.main) { data, error in
                if let data = data {
                    self.rotationRateX = data.rotationRate.x
                    self.rotationRateY = data.rotationRate.y
                    self.rotationRateZ = data.rotationRate.z
                }
            }
        }
    }
    
    func stopGyroscope() {
        motion.stopGyroUpdates()
    }
}

#Preview {
    GyroscopeView()
}
