//
//  CalendarView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import EventKit
import EventKitUI

struct CalendarView: View {
    @State private var eventStore = EKEventStore()
    @State private var events: [EKEvent] = []
    @State private var selectedEvents: Set<EKEvent> = []
    @State private var selectedEvent: EKEvent?
    @State private var searchEventTitle: String = ""
    @State private var selectionEnabled: Bool = false
    @State private var createEventSheet: Bool = false
    @State private var eventDetailsSheet: Bool = false
    
    var eventViewDelegate: EKEventViewDelegate {
        return EventViewDelegate()
    }
    
    var searchResults: [EKEvent] {
        if searchEventTitle.isEmpty {
            return events
        } else {
            return events.filter { $0.title.contains(searchEventTitle) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Section(header: Text("Calendar Permission").font(.headline)) {
                        if EKEventStore.authorizationStatus(for: .event) == .fullAccess {
                            Text("Calendar full access granted")
                        } else {
                            Button("Grant Calendar Permission") {
                                EKEventStore().requestFullAccessToEvents(completion: { granted, error in })
                            }
                        }
                    }
                }
                .frame(height: 100)
                List(selection: $selectedEvents) {
                    Section(header: Text("Calendar Events").font(.headline)) {
                        if events.isEmpty {
                            Text("No events found")
                        } else {
                            ForEach(self.searchResults, id: \.self) { event in
                                Button {
                                    if self.selectionEnabled {
                                        self.toggleSelection(event)
                                    } else {
                                        self.fetchEventDetails(event)
                                    }
                                } label: {
                                    HStack {
                                        Text(event.title ?? "Untitled Event")
                                        Spacer()
                                        if self.selectionEnabled {
                                            if self.selectedEvents.contains(event) {
                                                Image(systemName: "checkmark.circle.fill").foregroundColor(.blue)
                                            } else {
                                                Image(systemName: "circle").foregroundColor(.gray)
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        .searchable(text: $searchEventTitle)
        .onAppear {
            if EKEventStore.authorizationStatus(for: .event) == .fullAccess {
                fetchCalendarEvents()
            }
        }
        .sheet(isPresented: $createEventSheet, onDismiss: {
            self.fetchCalendarEvents()
            self.createEventSheet=false
        }) {
            NavigationView {
                NewEventView(eventStore: self.eventStore)
            }
        }
        .sheet(isPresented: $eventDetailsSheet, onDismiss: {
            self.fetchCalendarEvents()
            self.eventDetailsSheet=false
        }) {
            NavigationView {
                EventView(event: self.selectedEvent, delegate: self.eventViewDelegate)
            }
        }
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: {self.createEventSheet = true}) {
                    Image(systemName: "plus")
                }
                .disabled(!(EKEventStore.authorizationStatus(for: .event) == .fullAccess))
                Button(action: fetchCalendarEvents) {
                    Image(systemName: "arrow.clockwise")
                }
                Button(action: {
                    if self.selectionEnabled {
                        self.selectionEnabled = false
                    } else {
                        self.selectedEvents.removeAll()
                        self.selectionEnabled = true
                    }
                }) {
                    Image(systemName: self.selectedEvents.isEmpty ? "checkmark.circle" : "trash")
                }
            }
        }
    }
    
    private func fetchCalendarEvents() {
        if EKEventStore.authorizationStatus(for: .event) == .fullAccess {
            let eventStore = EKEventStore()
            let calendars = eventStore.calendars(for: .event)
            let startDate = Date()
            let endDate = Calendar.current.date(byAdding: .year, value: 1, to: startDate)!
            let predicate = eventStore.predicateForEvents(withStart: startDate, end: endDate, calendars: calendars)
            self.events.removeAll()
            self.events = eventStore.events(matching: predicate)
        }
    }
    
    private func fetchEventDetails(_ event: EKEvent) {
        DispatchQueue.global(qos: .userInitiated).async {
            if let fetchedEvent = eventStore.event(withIdentifier: event.calendarItemIdentifier) {
                DispatchQueue.main.async {
                    self.selectedEvent = fetchedEvent
                    self.eventDetailsSheet = true
                }
            }
        }
    }
    
    private func toggleSelection(_ event: EKEvent) {
        if selectedEvents.contains(event) {
            selectedEvents.remove(event)
        } else {
            selectedEvents.insert(event)
        }
    }
}

class EventViewDelegate: NSObject, EKEventViewDelegate {
    func eventViewController(_ controller: EKEventViewController, didCompleteWith action: EKEventViewAction) {
        controller.dismiss(animated: true, completion: nil)
    }
}

struct EventView: UIViewControllerRepresentable {
    var event: EKEvent?
    var delegate: EKEventViewDelegate?
    
    func makeUIViewController(context: Context) -> UINavigationController {
        let eventViewController = EKEventViewController()
        eventViewController.allowsEditing = true
        eventViewController.delegate = delegate
        if let event = event {
            eventViewController.event = event
        }
        let navigationController = UINavigationController(rootViewController: eventViewController)
        return navigationController
    }
    
    func updateUIViewController(_ uiViewController: UINavigationController, context: Context) {
        
    }
}

struct NewEventView: UIViewControllerRepresentable {
    var eventStore: EKEventStore
    
    func makeUIViewController(context: Context) -> EKEventEditViewController {
        let eventViewController = EKEventEditViewController()
        eventViewController.eventStore = eventStore
        eventViewController.editViewDelegate = context.coordinator
        return eventViewController
    }
    
    func updateUIViewController(_ uiViewController: EKEventEditViewController, context: Context) {
        // No need to update anything here
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
    
    class Coordinator: NSObject, EKEventEditViewDelegate {
        func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
            controller.dismiss(animated: true, completion: nil)
        }
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
