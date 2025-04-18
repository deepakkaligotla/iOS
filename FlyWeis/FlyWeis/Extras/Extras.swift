//
//  Extras.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI

struct SectionView<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            content
        }
    }
}

struct ElevatedCard<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        VStack {
            content
        }
        .padding() // Added padding for better appearance
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
        .shadow(color: Color.black.opacity(0.5), radius: 8, x: 0, y: 4)
        .frame(maxWidth: .infinity) // Corrected to maxWidth
    }
}

extension Color {
    static func random() -> Color {
        let red = Double.random(in: 0...1)
        let green = Double.random(in: 0...1)
        let blue = Double.random(in: 0...1)
        return Color(red: red, green: green, blue: blue)
    }
}
