//
//  ContentView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 15/05/24.
//

import SwiftUI

struct ContentView: View {
    @State private var selection = 2
    
    var body: some View {
        TabView(selection: $selection) {
            FormView().tabItem { Label("Form", systemImage: "swiftdata") }.tag(1)
            ChartsTab().tabItem { Label("Charts", systemImage: "chart.pie") }.tag(2)
        }
    }
}

struct ChartsTab: View {
    private enum Destinations {
        case empty
        case area
        case bar
        case circular
        case custom
        case heatmap
        case line
        case point
        case range
    }
    @State private var selection: Destinations?
    
    var body: some View {
        NavigationSplitView {
            List(selection: $selection) {
                Section("Area Charts") {
                    NavigationLink(value: Destinations.area) {
                        AreaChartsView()
                    }
                }
                Section("Bar Charts") {
                    NavigationLink(value: Destinations.bar) {
                        BarChartsView()
                    }
                }
                Section("Circular Charts") {
                    NavigationLink(value: Destinations.circular) {
                        CircularChartsView()
                    }
                }
                Section("Heat Map") {
                    NavigationLink(value: Destinations.heatmap) {
                        HeatMapOverview()
                    }
                }
                Section("Line Charts") {
                    NavigationLink(value: Destinations.line) {
                        LineChartsView()
                    }
                }
                Section("Point Charts") {
                    NavigationLink(value: Destinations.point) {
                        PointChartsView()
                    }
                }
                Section("Range Charts") {
                    NavigationLink(value: Destinations.range) {
                        RangeChartsView()
                    }
                }
                
                Section("Additional examples") {
                    NavigationLink("Custom Chart", value: Destinations.custom)
                }
            }
            .navigationTitle("SwiftUI Charts")
        } detail: {
            NavigationStack {
                switch selection ?? .empty {
                case .empty: Text("Select data to view.")
                case .area: AreaChartsView()
                case .bar: BarChartsView()
                case .circular: CircularChartsView()
                case .custom: CustomChart()
                case .heatmap: HeatMap()
                case .line: LineChartsView()
                case .point: PointChartsView()
                case .range: RangeChartsView()
                }
            }
        }
    }
}

#Preview {
    ContentView().modelContainer(for: chartsData, inMemory: true)
}
