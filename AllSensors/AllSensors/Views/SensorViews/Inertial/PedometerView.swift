//
//  PedometerView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct PedometerView: View {
    @StateObject private var pedometerManager = PedometerManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Pedometer")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
                
                if let stepCount = pedometerManager.stepCount {
                    Text("Steps: \(stepCount)")
                        .font(.title)
                        .padding()
                } else {
                    Text("Fetching steps...")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
            .onAppear {
                pedometerManager.startPedometerUpdates()
            }
            .onDisappear {
                pedometerManager.stopPedometerUpdates()
            }
        }
    }
}

class PedometerManager: ObservableObject {
    private let pedometer = CMPedometer()
    @Published var stepCount: Int?

    func startPedometerUpdates() {
        guard CMPedometer.isStepCountingAvailable() else {
            print("Step counting is not available on this device.")
            return
        }

        pedometer.startUpdates(from: Date()) { [weak self] pedometerData, error in
            if let error = error {
                print("Pedometer error: \(error.localizedDescription)")
                return
            }

            guard let pedometerData = pedometerData else {
                print("Pedometer data is nil")
                return
            }

            DispatchQueue.main.async {
                self?.stepCount = pedometerData.numberOfSteps.intValue
                print("Updated step count: \(pedometerData.numberOfSteps.intValue)")
            }
        }
    }

    func stopPedometerUpdates() {
        pedometer.stopUpdates()
    }
}

#Preview {
    PedometerView()
}
