//
//  LineChartsView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI

struct LineChartsView: View {
    var body: some View {
        VStack {
            Section("Curved Line") {
                CurvedLineChartOverview()
            }
            Section("Line") {
                LineChartOverview()
            }
            Section("Step Line") {
                StepLineChartOverview()
            }
        }
    }
}

#Preview {
    LineChartsView()
}
