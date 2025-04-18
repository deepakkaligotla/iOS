//
//  SplashView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 08/08/24.
//

import SwiftUI

struct SplashView: View {
    @State var isActive: Bool = false
    
    var body: some View {
        ZStack {
            if self.isActive {
                LoginView()
            } else {
                ZStack {
                    Image("SplashBackground")
                        .resizable()
                        .scaledToFill()
                        .frame(minWidth: 0)
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack {
                        Image("logo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .background(Color(red: 52/255, green: 183/255, blue: 193/255))
                            .clipShape(Circle())
                            .frame(maxWidth: .infinity, alignment: .top)
                            .padding(.top, 50)
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashView()
}
