//
//  StarRatingView.swift
//  SwiftCharts
//
//  Created by Deepak Kaligotla on 15/05/24.
//

import SwiftUI

struct GetRatingStars: View {
    var value: Double
    var stars: Int = 5
    
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 0) {
                Color.yellow.frame(width: geo.size.width * value / Double(stars))
                Color.white.frame(width: geo.size.width * (Double(stars) - value)/Double(stars))
            }
            .clipShape(RatingClipShape(paddingAmount: 0.01, stars: 5))
        }
    }
}

struct SetRatingStars: View {
    @Binding var value: Double
    var stars: Int = 5
    @State var lastCoordinateValue: CGFloat = 0.0
    
    var body: some View {
        GeometryReader { geo in
            let ratingWidth = geo.size.width * value / Double(stars)
            let starWidth = geo.size.width * (Double(stars) - value)/Double(stars)
            let maxValue = geo.size.width
            let scaleFactor = maxValue / Double(stars)
            
            HStack(spacing: 0) {
                Color.yellow.frame(width: ratingWidth)
                Color.white.frame(width: starWidth)
            }
            .clipShape(RatingClipShape(paddingAmount: 0.01, stars: 5))
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { changedValue in
                        if (abs(changedValue.translation.width) < 0.1) {
                            self.lastCoordinateValue = changedValue.location.x
                        }
                        if changedValue.translation.width > 0 {
                            let nextCoordinateValue = min(maxValue, self.lastCoordinateValue + changedValue.translation.width)
                            self.value = (nextCoordinateValue / scaleFactor)
                        } else {
                            let nextCoordinateValue = max(0.0, self.lastCoordinateValue + changedValue.translation.width)
                            self.value = (nextCoordinateValue / scaleFactor)
                        }
                    }
            )
        }
    }
}

struct RatingClipShape: Shape {
    var paddingAmount = 5.0
    var stars = 5
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let padding = rect.width * paddingAmount / 100
        let diameter = (rect.width - (4 * padding)) / CGFloat(stars)
        let step = diameter + padding
        
        for i in 0..<stars {
            let starPath = createStarPath(in: CGRect(x: CGFloat(i) * step + padding * CGFloat(i + 1), y: 0, width: diameter, height: diameter))
            path.addPath(starPath)
        }
        
        return path
    }
    
    private func createStarPath(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let outerRadius = min(rect.width, rect.height) / 2
        let innerRadius = outerRadius / 2.5
        var angle: CGFloat = -CGFloat.pi / 2
        let angleIncrement = CGFloat.pi * 2 / CGFloat(5 * 2)
        var isFirstPoint = true
        
        let path = Path { path in
            for _ in 1...5 {
                let outerPoint = CGPoint(x: center.x + outerRadius * cos(angle), y: center.y + outerRadius * sin(angle))
                let innerPoint = CGPoint(x: center.x + innerRadius * cos(angle + angleIncrement), y: center.y + innerRadius * sin(angle + angleIncrement))
                
                if isFirstPoint {
                    path.move(to: outerPoint)
                    isFirstPoint = false
                } else {
                    path.addLine(to: outerPoint)
                }
                
                path.addLine(to: innerPoint)
                angle += angleIncrement * 2
            }
            path.closeSubpath()
        }
        return path
    }
}
