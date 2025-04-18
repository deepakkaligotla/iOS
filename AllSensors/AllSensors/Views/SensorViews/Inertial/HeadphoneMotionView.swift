//
//  HeadphoneMotionView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct HeadphoneMotionView: View {
    @StateObject private var headphoneMotionManager = HeadphoneMotionManager()

    var body: some View {
        ZStack {
            VStack {
                Text("Headphone Motion")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(systemName: "beats.headphones")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
                
                if headphoneMotionManager.isAuthorized {
                    VStack {
                        if let motionData = headphoneMotionManager.motionData {
                            Text("Pitch: \(motionData.attitude.pitch, specifier: "%.2f")")
                            Text("Roll: \(motionData.attitude.roll, specifier: "%.2f")")
                            Text("Yaw: \(motionData.attitude.yaw, specifier: "%.2f")")
                        } else {
                            Text("Waiting for motion data...")
                        }
                    }
                    .font(.title)
                    .padding()
                } else {
                    VStack {
                        Text("Headphone motion access not authorized")
                            .foregroundColor(.red)
                        Button(action: {
                            openSettings()
                        }) {
                            Text("Check Privacy Settings")
                                .foregroundColor(.blue)
                        }
                    }
                }
            }
        }
        .onAppear {
            headphoneMotionManager.startHeadphoneMotionUpdates()
        }
        .onDisappear {
            headphoneMotionManager.stopHeadphoneMotionUpdates()
        }
    }
    
    private func openSettings() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl)
        }
    }
}

class HeadphoneMotionManager: ObservableObject {
    private var motionManager = CMHeadphoneMotionManager()
    @Published var motionData: CMDeviceMotion?
    @Published var isAuthorized: Bool = false
    
    func startHeadphoneMotionUpdates() {
        let status = CMHeadphoneMotionManager.authorizationStatus()
        print("Authorization Status: \(status.rawValue)")
        
        if status == .authorized {
            isAuthorized = true
            if motionManager.isDeviceMotionAvailable {
                print("Device motion is available")
                motionManager.startDeviceMotionUpdates(to: OperationQueue.main) { [weak self] data, error in
                    if let error = error {
                        print("Error receiving motion data: \(error.localizedDescription)")
                        return
                    }
                    if let data = data {
                        print("Received motion data: \(data)")
                        self?.motionData = data
                    } else {
                        print("No motion data received yet")
                    }
                }
            } else {
                print("Device motion is not available")
            }
        } else {
            isAuthorized = false
            print("Headphone motion access not authorized")
        }
    }
    
    func stopHeadphoneMotionUpdates() {
        if motionManager.isDeviceMotionActive {
            motionManager.stopDeviceMotionUpdates()
        }
    }
}

#Preview {
    HeadphoneMotionView()
}
