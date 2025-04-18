//
//  AmbientLightView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import SensorKit

struct AmbientLightView: View {
    @ObservedObject var viewModel = AmbientLightViewModel()

    var body: some View {
        VStack {
            Text("Ambient Light")
                .font(.title)
                .frame(maxWidth: .infinity, alignment: .center)

            Image("ambient_light")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)

            if let sample = viewModel.ambientLightSample {
                Text("Lux: \(sample.lux.value, specifier: "%.2f")")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if viewModel.isFetchingData {
                Text("Fetching data...")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            } else {
                Text("No data available.")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .center)
            }
        }
        .onAppear {
            viewModel.startMonitoring()
        }
    }
}

class AmbientLightViewModel: NSObject, ObservableObject, SRSensorReaderDelegate {
    @Published var ambientLightSample: SRAmbientLightSample?
    @Published var isFetchingData = true
    @Published var errorMessage: String?

    private var sensorReader: SRSensorReader?

    override init() {
        super.init()
        sensorReader = SRSensorReader(sensor: .ambientLightSensor)
        sensorReader?.delegate = self
    }

    func startMonitoring() {
        sensorReader?.fetchDevices()
    }

    func sensorReader(_ reader: SRSensorReader, didFetch samples: [SRAmbientLightSample]) {
        DispatchQueue.main.async {
            if let sample = samples.first {
                self.ambientLightSample = sample
                self.isFetchingData = false
            } else {
                self.errorMessage = "No ambient light data available."
                self.isFetchingData = false
            }
        }
    }

    func sensorReader(_ reader: SRSensorReader, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
            self.isFetchingData = false
        }
    }
}

#Preview {
    AmbientLightView()
}
