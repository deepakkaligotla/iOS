//
//  SensorView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import CoreMotion

struct SensorView: View {
    @State private var sensorAllowed = false
    
    func requestMotionPermission() {
        let motionManager = CMMotionActivityManager()
        if !CMMotionActivityManager.isActivityAvailable() {
            print("Motion activity is not available.")
            self.sensorAllowed = false
            return
        }
        
        motionManager.startActivityUpdates(to: .main) { activity in
            DispatchQueue.main.async {
                if let _ = activity {
                    print("Motion permission granted")
                    self.sensorAllowed = true
                } else {
                    print("Error requesting motion permission")
                    self.sensorAllowed = false
                }
            }
        }
    }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

#Preview {
    SensorView()
}
