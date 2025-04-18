//
//  AreaChartsView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI

struct AreaChartsView: View {
    
    var body: some View {
        VStack {
            Section("Area Chart") {
                AreaChartOverview()
            }
            Section("Stacked Area Chart") {
                StackedAreaChartOverview()
            }
        }
    }
}

#Preview {
    AreaChartsView()
}
