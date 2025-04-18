//
//  CountdownTimerView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 14/08/24.
//

import SwiftUI

struct CountdownTimerView: View {
    @State private var timeRemaining: CGFloat = 115800
    @State private var timerActive = false
    private let maxHOS: CGFloat = 216000
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: 1)
                .stroke(
                    Color.purple.opacity(0.2),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            Circle()
                .trim(from: 0, to: progress())
                .stroke(
                    AngularGradient(
                        gradient: Gradient(colors: [
                            gradientColor(),
                            gradientColor().opacity(0.7)
                        ]),
                        center: .center,
                        startAngle: .degrees(0),
                        endAngle: .degrees(360)
                    ),
                    style: StrokeStyle(lineWidth: 20, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 1), value: timeRemaining)
            
            Text(timeString())
                .font(.largeTitle)
                .bold()
        }
        .frame(width: 200, height: 200)
        .onAppear {
            startTimer()
        }
    }
    
    private func progress() -> CGFloat {
        return max(0, min(1, timeRemaining / maxHOS))
    }
    
    private func timeString() -> String {
        let hours = Int(timeRemaining) / 3600
        let minutes = (Int(timeRemaining) % 3600) / 60
        let seconds = Int(timeRemaining) % 60
        return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
    }
    
    private func gradientColor() -> Color {
        let percentage = 1 - (timeRemaining / maxHOS)
        let startColor = Color(red: 51/255, green: 147/255, blue: 120/255)
        let endColor = Color.red
        
        return Color(
            red: startColor.components.red + percentage * (endColor.components.red - startColor.components.red),
            green: startColor.components.green + percentage * (endColor.components.green - startColor.components.green),
            blue: startColor.components.blue + percentage * (endColor.components.blue - startColor.components.blue)
        )
    }
    
    private func startTimer() {
        timerActive = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                timer.invalidate()
                timerActive = false
            }
        }
    }
}

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat) {
        let scanner = Scanner(string: self.description.trimmingCharacters(in: CharacterSet.alphanumerics.inverted))
        var hexNumber: UInt64 = 0
        scanner.scanHexInt64(&hexNumber)
        let r = CGFloat((hexNumber & 0xff0000) >> 16) / 255
        let g = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
        let b = CGFloat(hexNumber & 0x0000ff) / 255
        return (r, g, b)
    }
}

#Preview {
    CountdownTimerView()
}
