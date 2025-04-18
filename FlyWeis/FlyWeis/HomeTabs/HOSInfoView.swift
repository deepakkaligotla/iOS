//
//  HOSInfoView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 14/08/24.
//

import SwiftUI

struct HOSInfoView: View {
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    HStack {
                        SectionView(title: "HOS info") {
                            ElevatedCard {
                                VStack(alignment: .center) {
                                    HOSOptionsView().padding()
                                    CountdownTimerView().padding()
                                }.padding()
                            }
                        }
                    }
                }
            }
            .navigationTitle("HOS Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    HOSInfoView()
}
