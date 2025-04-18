//
//  RemindersView.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 29/03/24.
//

import SwiftUI
import EventKit

struct RemindersView: View {
    @State private var reminders: [EKReminder] = []
    @State private var permissionGranted = false
    
    var body: some View {
        NavigationView {
            VStack {
                if EKEventStore.authorizationStatus(for: .reminder) == .fullAccess {
                    if reminders.isEmpty {
                        Text("No reminders found")
                    } else {
                        List {
                            ForEach(reminders, id: \.self) { reminder in
                                Text(reminder.title ?? "Untitled Reminder")
                            }
                            .onDelete(perform: deleteReminder)
                        }
                    }
                } else {
                    Button("Grant Reminders Permission") {
                        EKEventStore().requestFullAccessToReminders(completion: { granted, error in })
                    }
                }
            }
        }
        .navigationBarItems(trailing: EditButton())
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                Button(action: createReminder) {
                    Image(systemName: "plus")
                }
                Button(action: fetchReminders) {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
        .onAppear {
            fetchReminders()
        }
    }
    
    private func fetchReminders() {
        let eventStore = EKEventStore()
        let calendars = eventStore.calendars(for: .reminder)
        let predicate = eventStore.predicateForReminders(in: calendars)
        
        eventStore.fetchReminders(matching: predicate) { reminders in
            DispatchQueue.main.async {
                self.reminders = reminders ?? []
            }
        }
    }
    
    private func createReminder() {
        let eventStore = EKEventStore()
        let newReminder = EKReminder(eventStore: eventStore)
        
        newReminder.title = "Your Reminder Title"
        newReminder.calendar = eventStore.defaultCalendarForNewReminders()
        newReminder.priority = 1
        newReminder.notes = "Additional notes for your reminder"
        
        let dueDate = Date().addingTimeInterval(24 * 60 * 60)
        newReminder.dueDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: dueDate)
        
        do {
            try eventStore.save(newReminder, commit: true)
            print("Reminder created successfully.")
        } catch {
            print("Error creating reminder: \(error.localizedDescription)")
        }
    }
    
    private func deleteReminder(at offsets: IndexSet) {
        let eventStore = EKEventStore()
        
        for offset in offsets {
            guard reminders.indices.contains(offset) else {
                continue
            }
            
            let reminder = reminders[offset]
            
            do {
                try eventStore.remove(reminder, commit: true)
                reminders.remove(at: offset)
            } catch {
                print("Error deleting reminder: \(error.localizedDescription)")
            }
        }
    }
}

struct RemindersView_Previews: PreviewProvider {
    static var previews: some View {
        RemindersView()
    }
}
