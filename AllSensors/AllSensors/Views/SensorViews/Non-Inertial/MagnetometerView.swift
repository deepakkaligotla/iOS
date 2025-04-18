//
//  MagnetometerView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI  

struct MagnetometerView: View {
    var body: some View {
        ZStack {
            VStack {
                Text("Magnetometer")
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
    MagnetometerView()
}
