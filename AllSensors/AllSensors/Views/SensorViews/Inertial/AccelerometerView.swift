//
//  AccelerometerView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct AccelerometerView: View {
    @StateObject private var motionManager = MotionManager()

    var body: some View {
        ZStack {
            VStack {
                Text("Accelerometer")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                GifImageView("accelerometer")
                    .scaledToFit()
                    .background(Color.clear)
                    .frame(width: 200, height: 200)
                VStack {
                    Text("X: \(motionManager.x, specifier: "%.2f")")
                    Text("Y: \(motionManager.y, specifier: "%.2f")")
                    Text("Z: \(motionManager.z, specifier: "%.2f")")
                }
                .font(.title)
                .padding()
            }
        }
        .onAppear {
            motionManager.startAccelerometer()
        }
        .onDisappear {
            motionManager.stopAccelerometer()
        }
    }
}

class MotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var x: Double = 0.0
    @Published var y: Double = 0.0
    @Published var z: Double = 0.0
    
    func startAccelerometer() {
        if motion.isAccelerometerAvailable {
            motion.accelerometerUpdateInterval = 0.1
            motion.startAccelerometerUpdates(to: OperationQueue.main) { data, error in
                if let data = data {
                    self.x = data.acceleration.x
                    self.y = data.acceleration.y
                    self.z = data.acceleration.z
                }
            }
        }
    }
    
    func stopAccelerometer() {
        motion.stopAccelerometerUpdates()
    }
}

#Preview {
    AccelerometerView()
}
