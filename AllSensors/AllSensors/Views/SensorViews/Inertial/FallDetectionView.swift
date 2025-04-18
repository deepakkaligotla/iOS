//
//  FallDetectionView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion
import WatchConnectivity

struct FallDetectionView: View {
    @StateObject private var manager = iPhoneFallDetectionManager()
    @StateObject private var connectivityManager = WatchConnectivityManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Fall Detection")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(systemName: "thermometer")
                    .resizable()
                    .scaledToFit()
                    .background(Color.clear)
                    .frame(width: 200, height: 200)
                
                if connectivityManager.isWatchPaired {
                    if connectivityManager.isWatchAppInstalled {
                        Text("Apple Watch is paired and the app is installed.")
                        List(manager.fallEvents, id: \.self) { event in
                            Text(event)
                        }
                    } else {
                        Text("Apple Watch is paired, but the app is not installed.")
                    }
                } else {
                    Text("No Apple Watch is paired with this iPhone.")
                }
            }
        }
        .onAppear {
            connectivityManager.checkWatchStatus()
        }
    }
}

class WatchConnectivityManager: NSObject, ObservableObject, WCSessionDelegate {
    private let session = WCSession.default
    @Published var isWatchPaired = false
    @Published var isWatchAppInstalled = false
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            session.delegate = self
            session.activate()
        }
    }
    
    func checkWatchStatus() {
        DispatchQueue.main.async {
            self.isWatchPaired = self.session.isPaired
            self.isWatchAppInstalled = self.session.isWatchAppInstalled
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
            checkWatchStatus()
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) { }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
}

class iPhoneFallDetectionManager: NSObject, ObservableObject, WCSessionDelegate {
    @Published var fallEvents: [String] = []
    
    override init() {
        super.init()
        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
        }
    }
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: (any Error)?) {
        if let error = error {
            print("WCSession activation failed with error: \(error.localizedDescription)")
        } else {
            print("WCSession activated with state: \(activationState.rawValue)")
        }
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        // Handle session becoming inactive if needed
    }
    
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        if let event = message["fallEvent"] as? String {
            DispatchQueue.main.async {
                self.fallEvents.append(event)
            }
        }
    }
}

#Preview {
    FallDetectionView()
}
