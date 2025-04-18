//
//  AttitudeView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 16/08/24.
//

import SwiftUI
import CoreMotion

struct AttitudeView: View {
    @StateObject private var attitudeManager = AttitudeManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Attitude")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image("attitude")
                    .resizable()
                    .scaledToFit()
                    .background(Color.clear)
                    .frame(width: 200, height: 200)
                VStack {
                    Text("Pitch: \(attitudeManager.pitch, specifier: "%.2f")")
                    Text("Roll: \(attitudeManager.roll, specifier: "%.2f")")
                    Text("Yaw: \(attitudeManager.yaw, specifier: "%.2f")")
                }
                .font(.title)
                .padding()
            }
        }
        .onAppear {
            attitudeManager.startAttitudeUpdates()
        }
        .onDisappear {
            attitudeManager.stopAttitudeUpdates()
        }
    }
}

class AttitudeManager: ObservableObject {
    private var motion = CMMotionManager()
    
    @Published var roll: Double = 0.0
    @Published var pitch: Double = 0.0
    @Published var yaw: Double = 0.0
    
    func startAttitudeUpdates() {
        if motion.isDeviceMotionAvailable {
            motion.deviceMotionUpdateInterval = 0.1
            motion.startDeviceMotionUpdates(to: OperationQueue.main) { data, error in
                if let data = data {
                    self.roll = data.attitude.roll
                    self.pitch = data.attitude.pitch
                    self.yaw = data.attitude.yaw
                }
            }
        }
    }
    
    func stopAttitudeUpdates() {
        motion.stopDeviceMotionUpdates()
    }
}

#Preview {
    AttitudeView()
}
