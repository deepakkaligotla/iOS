//
//  Snackbar.swift
//  AllPermissionsImpl
//
//  Created by Deepak Kaligotla on 20/04/24.
//

import SwiftUI

struct Snackbar: View {
    let message: String
    let actionText: String
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(message)
                .foregroundColor(.white)
                .padding(.horizontal)
            
            Button(action: {
                action()
            }) {
                Text(actionText)
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .cornerRadius(5)
            }
            .padding(.trailing)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .padding(.bottom, UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0)
        .edgesIgnoringSafeArea(.bottom)
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                withAnimation {
                    action()
                }
            }
        }
    }
}

extension View {
    func snackbar(isShowing: Binding<Bool>, message: String, actionText: String, action: @escaping () -> Void) -> some View {
        modifier(SnackbarModifier(isShowing: isShowing, message: message, actionText: actionText, action: action))
    }
}

struct SnackbarModifier: ViewModifier {
    @Binding var isShowing: Bool
    let message: String
    let actionText: String
    let action: () -> Void
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isShowing {
                Snackbar(message: message, actionText: actionText, action: action)
                    .transition(.move(edge: .bottom))
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
