//
//  ContentView.swift
//  AllSensors
//
//  Created by Deepak Kaligotla on 15/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var showMenu = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        Button(action: {
                            withAnimation {
                                showMenu.toggle()
                            }
                        }) {
                            Image(systemName: "line.horizontal.3")
                                .font(.largeTitle)
                                .padding()
                        }
                        Spacer()
                    }
                    Spacer()
                    Text("Main Content")
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                GeometryReader { _ in
                    HStack {
                        SideMenuView().frame(width: 250).offset(x: showMenu ? 0 : -250)
                        Spacer()
                    }
                    .background(Color.clear.opacity(showMenu ? 0.5 : 0))
                }
                .animation(.easeInOut, value: showMenu)
                .onTapGesture {
                    withAnimation {
                        showMenu.toggle()
                    }
                }
            }
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    ContentView()
}
