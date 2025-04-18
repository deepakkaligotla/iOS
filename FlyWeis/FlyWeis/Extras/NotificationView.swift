//
//  NotificationView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI

struct NotificationView: View {
    @Binding var isShowing: Bool
    @State private var events: [DiagnosticAndMalfunctionEvent] = []
    @State private var isLoading = false

    var body: some View {
        VStack(spacing: 10) {
            if isShowing {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding()
                } else {
                    if events.isEmpty {
                        Text("No events available")
                            .foregroundColor(.white)
                            .padding()
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 10) {
                                ForEach(events, id: \.truck) { event in
                                    NotificationItemView(event: event)
                                }
                            }
                            .padding()
                        }
                        .background(Color.black.opacity(0.9))
                        .cornerRadius(8)
                        .shadow(radius: 10)
                        .padding()
                        .frame(minHeight: CGFloat(events.count * 60), maxHeight: 300)
                    }
                }
            }
        }
        .frame(width: 300)
        .onAppear {
            fetchEvents()
        }
    }
    
    private func fetchEvents() {
        isLoading = true
        API.fetchDiagnosticAndMalfunctionEvents { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let fetchedEvents):
                    self.events = fetchedEvents
                case .failure(let error):
                    print("Error fetching events: \(error.localizedDescription)")
                }
            }
        }
    }
}

struct NotificationItemView: View {
    let event: DiagnosticAndMalfunctionEvent

    var body: some View {
        VStack(alignment: .leading) {
            Text("Driver: \(event.driver)")
                .font(.headline)
                .foregroundColor(.white)
            Text("Truck: \(event.truck)")
                .foregroundColor(.white)
            Text("Location: \(event.location)")
                .foregroundColor(.white)
            Text("Event: \(event.event)")
                .foregroundColor(.red)
            Text("Date: \(event.date)")
                .foregroundColor(.white)
            Text("Time: \(event.time)")
                .foregroundColor(.white)

            Divider().background(Color.white)
        }
        .padding()
        .background(Color.black.opacity(0.8))
        .cornerRadius(8)
        .shadow(radius: 10)
    }
}

#Preview {
    NotificationView(
        isShowing: .constant(true)
    )
}
