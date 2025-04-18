//
//  BarometerView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI

struct BarometerView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Barometer")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                Image(systemName: "thermometer")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .background(Color.clear)
            }
        }
    }
}

#Preview {
    BarometerView()
}
