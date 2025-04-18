//
//  GravityView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct GravityView: View {
    @StateObject private var motionManager = GravityMotionManager()

    var body: some View {
        ZStack {
            VStack {
                VStack {
                    Text("Gravity")
                        .font(.title)
                        .frame(maxWidth: .infinity, alignment: .center)
                    GifImageView("gravity1")
                        .scaledToFit()
                        .background(Color.clear)
                        .frame(width: 200, height: 200)
                }
                VStack {
                    Text("Gravity X: \(motionManager.gravityX, specifier: "%.2f") G")
                    Text("Gravity Y: \(motionManager.gravityY, specifier: "%.2f") G")
                    Text("Gravity Z: \(motionManager.gravityZ, specifier: "%.2f") G")
                }
                .font(.title3)
                .padding()
            }
        }
        .onAppear {
            motionManager.startGravityUpdates()
        }
        .onDisappear {
            motionManager.stopGravityUpdates()
        }
    }
}

class GravityMotionManager: ObservableObject {
    private var motion = CMMotionManager()
    @Published var gravityX: Double = 0.0
    @Published var gravityY: Double = 0.0
    @Published var gravityZ: Double = 0.0
    
    func startGravityUpdates() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 0.1
            motion.startDeviceMotionUpdates(to: OperationQueue.main) { data, error in
                if let data = data {
                    self.gravityX = data.gravity.x
                    self.gravityY = data.gravity.y
                    self.gravityZ = data.gravity.z
                }
            }
        }
    }
    
    func stopGravityUpdates() {
        motion.stopDeviceMotionUpdates()
    }
}

#Preview {
    GravityView()
}
