//
//  HeadphoneView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import CoreMotion

struct MotionActivityView: View {
    @StateObject private var activityManager = MotionActivityManager()
    
    var body: some View {
        ZStack {
            VStack {
                Text("Motion Activity")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(systemName: "thermometer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
                
                if let activity = activityManager.activity {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Start Date: \(activity.startDate, formatter: dateFormatter)")
                        Text("Stationary: \(activity.stationary ? "Yes" : "No")")
                        Text("Walking: \(activity.walking ? "Yes" : "No")")
                        Text("Running: \(activity.running ? "Yes" : "No")")
                        Text("Automotive: \(activity.automotive ? "Yes" : "No")")
                        Text("Cycling: \(activity.cycling ? "Yes" : "No")")
                        Text("Confidence: \(activity.confidence.rawValue)")
                    }
                    .font(.body)
                    .padding()
                } else {
                    Text("Fetching motion activity...")
                        .foregroundColor(.gray)
                        .padding()
                }
            }
        }
        .onAppear {
            activityManager.startActivityUpdates()
        }
        .onDisappear {
            activityManager.stopActivityUpdates()
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }
}

class MotionActivityManager: ObservableObject {
    private let activityManager = CMMotionActivityManager()
    @Published var activity: CMMotionActivity?
    
    func startActivityUpdates() {
        guard CMMotionActivityManager.isActivityAvailable() else {
            print("Activity data is not available on this device.")
            return
        }
        
        activityManager.startActivityUpdates(to: OperationQueue.main) { [weak self] activity in
            guard let activity = activity else {
                print("No activity data available.")
                return
            }
            
            DispatchQueue.main.async {
                self?.activity = activity
            }
        }
    }
    
    func stopActivityUpdates() {
        activityManager.stopActivityUpdates()
    }
}

#Preview {
    MotionActivityView()
}
