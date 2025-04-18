//
//  MediaPlaybackView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI
import SensorKit

struct MediaEventsView: View {
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Image(systemName: "thermometer")
                        .scaledToFit()
                        .background(Color.clear)
                        .frame(width: 30, height: 30)
                    Spacer()
                    Text("Media Events")
                        .font(.body)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    MediaEventsView()
}
