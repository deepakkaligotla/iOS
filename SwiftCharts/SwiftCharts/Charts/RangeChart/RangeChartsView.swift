//
//  RangeChartsView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 17/05/24.
//

import SwiftUI

struct RangeChartsView: View {
    var body: some View {
        VStack {
            Section("Range Bar") {
                RangeBarChartOverview()
            }
            Section("Range Area") {
                RangeAreaChartOverview()
            }
        }
    }
}

#Preview {
    RangeChartsView()
}
