//
//  ContentView.swift
//  AllSensorsWatch Watch App
//
//  Created by Deepak Kaligotla on 20/08/24.
//

import SwiftUI
import WatchConnectivity
import CoreMotion

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

class WatchFallDetectionManager: NSObject, CMFallDetectionDelegate, WCSessionDelegate {
    private let session = WCSession.default
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
        
        if CMFallDetectionManager.isAvailable {
            let manager = CMFallDetectionManager()
            manager.delegate = self
        }
    }
    
    private func fallDetectionManager(_ manager: CMFallDetectionManager, didDetect event: CMFallDetectionEvent) {
        let eventString = "Fall detected at \(event.date), Resolution: \(event.resolution)"
        session.sendMessage(["fallEvent": eventString], replyHandler: nil, errorHandler: nil)
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        // Handle activation completion
    }
}

#Preview {
    ContentView()
}
