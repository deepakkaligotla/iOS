//
//  BarChartsView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI

struct BarChartsView: View {
    var body: some View {
        VStack {
            Section("Horizontal Bar") {
                HorizontalBarChartOverview()
            }
            Section("Stacked Bar") {
                StackedBarChartOverview()
            }
            Section("Vertical Bar") {
                VerticalBarChartOverview()
            }
        }
    }
}

#Preview {
    BarChartsView()
}
