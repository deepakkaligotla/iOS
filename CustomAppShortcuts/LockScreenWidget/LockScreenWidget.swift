//
//  LockScreenWidget.swift
//  LockScreenWidget
//
//  Created by Deepak Kaligotla on 15/06/24.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: ConfigurationAppIntent())
    }

    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), configuration: configuration)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 3600 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, configuration: configuration)
            entries.append(entry)
        }

        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: ConfigurationAppIntent
}

struct LockScreenWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            Text("Time: \(entry.date, formatter: DateFormatter.timeWithSeconds)")
            Text("Favorite Emoji: \(entry.configuration.favoriteEmoji)")
        }
    }
}

extension DateFormatter {
    static var timeWithSeconds: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        return formatter
    }
}

struct LockScreenWidget: Widget {
    let kind: String = "LockScreenWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            LockScreenWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
    }
}

extension ConfigurationAppIntent {
    fileprivate static var smiley: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "😀"
        return intent
    }
    
    fileprivate static var starEyes: ConfigurationAppIntent {
        let intent = ConfigurationAppIntent()
        intent.favoriteEmoji = "🤩"
        return intent
    }
}

#Preview(as: .systemSmall) {
    LockScreenWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: .smiley)
    SimpleEntry(date: .now, configuration: .starEyes)
}
