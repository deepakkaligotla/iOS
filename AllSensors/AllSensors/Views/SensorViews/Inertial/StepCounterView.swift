//
//  StepCounterView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct StepCounterView: View {
    @StateObject private var stepCounterManager = StepCounterManager()

    var body: some View {
        VStack {
            Text("Step Counter")
                .font(.title)
                .padding()
            Image(systemName: "figure.walk")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .background(Color.clear)

            Text("Steps: \(stepCounterManager.steps)")
                .font(.largeTitle)
                .padding()

            if let error = stepCounterManager.error {
                Text("Error: \(error.localizedDescription)")
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            stepCounterManager.startStepCounting()
        }
        .onDisappear {
            stepCounterManager.stopStepCounting()
        }
    }
}

class StepCounterManager: NSObject, ObservableObject {
    private let stepCounter = CMStepCounter()
    @Published var steps: Int = 0
    @Published var error: Error?

    func startStepCounting() {
        if CMStepCounter.isStepCountingAvailable() {
            stepCounter.startStepCountingUpdates(to: .main, updateOn: 1) { [weak self] stepCount, _, error in
                DispatchQueue.main.async {
                    if let error = error {
                        self?.error = error
                    } else {
                        self?.steps = stepCount
                    }
                }
            }
        } else {
            print("Step counting is not available on this device.")
        }
    }

    func stopStepCounting() {
        stepCounter.stopStepCountingUpdates()
    }
}

#Preview {
    StepCounterView()
}
