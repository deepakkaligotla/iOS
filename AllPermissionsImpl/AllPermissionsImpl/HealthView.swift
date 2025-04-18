//
//  HealthView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import HealthKit

struct HealthView: View {
    private let healthStore: HKHealthStore
    @State private var healthRecords: [HKClinicalRecord] = []
    @State private var isSheetPresented = false
    
    init() {
        guard HKHealthStore.isHealthDataAvailable() else { fatalError("This app requires a device that supports HealthKit") }
        healthStore = HKHealthStore()
    }
    
    private func fetchRecords(healthType: HKObjectType) {
        switch healthStore.authorizationStatus(for: healthType) {
        case .sharingAuthorized:
            self.fetchHealthRecords(healthType: healthType)
        case .sharingDenied:
            print("Access denied for \(healthType.identifier)")
            self.requestHealthAuth(healthType: healthType)
        case .notDetermined:
            print("Access not determined for \(healthType.identifier)")
            self.requestHealthAuth(healthType: healthType)
        default:
            print("Default Access case for \(healthType.identifier)")
        }
    }
    
    private func requestHealthAuth(healthType: HKObjectType) {
        healthStore.requestAuthorization(toShare: [healthType as! HKSampleType], read: [healthType]) { success, error in
            DispatchQueue.main.async {
                if success {
                    print("Authorization granted for \(healthType.identifier)")
                    self.fetchHealthRecords(healthType: healthType)
                } else {
                    print("*** Authorization request failed: \(error?.localizedDescription ?? "Unknown error") ***")
                }
            }
        }
    }
    
    private func fetchHealthRecords(healthType: HKObjectType) {
        let query = HKSampleQuery(sampleType: healthType as! HKSampleType,
                                         predicate: nil,
                                         limit: HKObjectQueryNoLimit, sortDescriptors: nil) { (query, samples, error) in
            
            guard let actualSamples = samples else {
                print("*** An error occurred: \(error?.localizedDescription ?? "nil") ***")
                return
            }
            
            let samples = actualSamples as? [HKClinicalRecord]
            self.healthRecords = samples!
        }
        healthStore.execute(query)
    }
    
    var body: some View {
        VStack {
            List(MyHealth.healthList) { healthItem in
                Button {
                    self.fetchRecords(healthType: healthItem.healthType)
                } label: {
                    Text(healthItem.healthName).foregroundColor(.green)
                }
            }
        }
        .sheet(isPresented: $isSheetPresented) {
            if healthRecords.isEmpty {
                ProgressView("Fetching Records...")
                Text("No Records Found")
            } else {
                List(healthRecords, id: \.self) { record in
                    Text("Record: \(record)")
                }
            }
        }
    }
}

struct HealthView_Previews: PreviewProvider {
    static var previews: some View {
        HealthView()
    }
}
