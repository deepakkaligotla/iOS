//
//  CircularChartsView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI

struct CircularChartsView: View {
    var body: some View {
        VStack {
            Section("Pie") {
                PieChartOverview()
            }
            Section("Donut") {
                DonutChartOverview()
            }
        }
    }
}

#Preview {
    CircularChartsView()
}
