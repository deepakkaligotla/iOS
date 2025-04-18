//
//  ContentView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Text("Top Left")
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                    Spacer()
                    Text("Top")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(8)
                    Spacer()
                    Text("Top Right")
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                Spacer()
                
                HStack {
                    Text("Center Left")
                        .padding()
                        .background(Color.orange)
                        .cornerRadius(8)
                    Spacer()
                    Text("Center")
                        .padding()
                        .background(Color.purple)
                        .cornerRadius(8)
                    Spacer()
                    Text("Center Right")
                        .padding()
                        .background(Color.yellow)
                        .cornerRadius(8)
                }
                Spacer()
                
                HStack {
                    Text("Bottom Left")
                        .padding()
                        .background(Color.pink)
                        .cornerRadius(8)
                    Spacer()
                    Text("Bottom")
                        .padding()
                        .background(Color.cyan)
                        .cornerRadius(8)
                    Spacer()
                    Text("Bottom Right")
                        .padding()
                        .background(Color.teal)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
