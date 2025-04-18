//
//  MovementDisorderView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct MovementDisorderView: View {
    @StateObject private var manager = MovementDisorderManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Movement Disorder")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                
                Image(systemName: "figure.walk")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
                
                VStack(alignment: .leading) {
                    if let dyskineticData = manager.dyskineticData {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Dyskinetic Symptom Data:").font(.headline)
                            Text("Start Date: \(dyskineticData.startDate, formatter: dateFormatter)")
                            Text("End Date: \(dyskineticData.endDate, formatter: dateFormatter)")
                            Text("Percent Unlikely: \(dyskineticData.percentUnlikely, specifier: "%.2f")")
                            Text("Percent Likely: \(dyskineticData.percentLikely, specifier: "%.2f")")
                        }.padding().border(Color.white).font(.body)
                    }
                    
                    if let tremorData = manager.tremorData {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Tremor Data:").font(.headline)
                            Text("Start Date: \(tremorData.startDate, formatter: dateFormatter)")
                            Text("End Date: \(tremorData.endDate, formatter: dateFormatter)")
                            Text("Percent Unknown: \(tremorData.percentUnknown, specifier: "%.2f")")
                            Text("Percent None: \(tremorData.percentNone, specifier: "%.2f")")
                            Text("Percent Slight: \(tremorData.percentSlight, specifier: "%.2f")")
                            Text("Percent Mild: \(tremorData.percentMild, specifier: "%.2f")")
                            Text("Percent Moderate: \(tremorData.percentModerate, specifier: "%.2f")")
                            Text("Percent Strong: \(tremorData.percentStrong, specifier: "%.2f")")
                        }.padding().border(Color.white).font(.body)
                    }
                }
            }
            .onAppear {
                manager.fetchDyskineticSymptomData()
                manager.fetchTremorData()
            }
        }
    }
}

// Date formatter for displaying dates
private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .short
    return formatter
}()

class MovementDisorderManager: ObservableObject {
    @Published var dyskineticData: DyskineticSymptomData?
    @Published var tremorData: TremorData?
    
    func fetchDyskineticSymptomData() {
        // Implement actual data fetching here
        // Example data:
        dyskineticData = DyskineticSymptomData(
            startDate: Date(),
            endDate: Date(),
            percentUnlikely: 0.6,
            percentLikely: 0.4
        )
    }
    
    func fetchTremorData() {
        // Implement actual data fetching here
        // Example data:
        tremorData = TremorData(
            startDate: Date(),
            endDate: Date(),
            percentUnknown: 0.2,
            percentNone: 0.5,
            percentSlight: 0.1,
            percentMild: 0.1,
            percentModerate: 0.05,
            percentStrong: 0.05
        )
    }
}

#Preview {
    MovementDisorderView()
}
