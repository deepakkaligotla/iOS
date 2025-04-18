//
//  PointChartsView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI

struct PointChartsView: View {
    var body: some View {
        VStack {
            Section("Bubble") {
                BubbleChartOverview()
            }
            Section("Scatter Plot") {
                ScatterPlotOverview()
            }
        }
    }
}

#Preview {
    PointChartsView()
}
