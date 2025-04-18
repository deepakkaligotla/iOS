//
//  AmbientPressureView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import SensorKit
import CoreMotion

class AmbientPressureManager: NSObject, SRSensorReaderDelegate, ObservableObject {
    @Published var pressure: Double?
    @Published var temperature: Double?
    @Published var errorMessage: String?
    private var sensorManager: SRSensorReader?
    
    func requestAuthorization() {
        SRSensorReader.requestAuthorization(sensors: [.accelerometer, .ambientLightSensor,
                                                      .ambientPressure, .deviceUsageReport,
                                                      .electrocardiogram, .electrocardiogram,
                                                      .faceMetrics, .heartRate, .keyboardMetrics,
                                                      .mediaEvents, .messagesUsageReport,
                                                      .odometer, .onWristState, .pedometerData,
                                                      .phoneUsageReport, .photoplethysmogram,
                                                      .rotationRate, .siriSpeechMetrics,
                                                      .telephonySpeechMetrics, .visits,
                                                      .wristTemperature]) { (error: Error?) in
                if let error = error {
                    fatalError("Sensor authorization failed due to: \(error)")
                } else {
                    print("""
                    User dismissed the authorization prompt.
                    Awaiting authorization status changes.
                """)
                }
            }
    }
    
    func startFetching() {
        sensorManager = SRSensorReader(sensor: .ambientPressure)
        sensorManager?.delegate = self
        let fromTime = SRAbsoluteTime(Date().addingTimeInterval(-3600).timeIntervalSinceReferenceDate)
        let toTime = SRAbsoluteTime(Date().timeIntervalSinceReferenceDate)
        let fetchRequest = SRFetchRequest()
        fetchRequest.from = fromTime
        fetchRequest.to = toTime
        sensorManager?.fetch(fetchRequest)
    }
    
    func sensorReader(_ reader: SRSensorReader, didFetch data: [Any], for request: SRFetchRequest) {
        DispatchQueue.main.async {
            if let data = data as? [CMAmbientPressureData], let firstData = data.first {
                self.pressure = firstData.pressure.converted(to: .kilopascals).value
                self.temperature = firstData.temperature.converted(to: .celsius).value
            } else {
                self.errorMessage = "No data available."
            }
        }
    }
    
    func sensorReader(_ reader: SRSensorReader, fetching request: SRFetchRequest, failedWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = "Failed to fetch data: \(error.localizedDescription)"
        }
    }
}

struct AmbientPressureView: View {
    @StateObject private var manager = AmbientPressureManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Ambient Pressure")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(systemName: "thermometer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
                
                if let pressure = manager.pressure, let temperature = manager.temperature {
                    VStack {
                        Text("Pressure: \(pressure) kPa")
                        Text("Temperature: \(temperature) °C")
                    }
                    .font(.headline)
                    .padding()
                } else if let errorMessage = manager.errorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                } else {
                    Text("Fetching data...")
                        .foregroundColor(.gray)
                }
            }
        }
        .onAppear {
            manager.startFetching()
        }
    }
}

#Preview {
    AmbientPressureView()
}
