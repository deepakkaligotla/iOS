//
//  GraphView.swift
//  FlyWeis
//
//  Created by Deepak Kaligotla on 09/08/24.
//

import SwiftUI

struct GraphView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(spacing: 0) {
                // Column for labels
                VStack(alignment: .leading, spacing: 32) {
                    Text("OFF")
                    Text("SB")
                    Text("D")
                    Text("ON")
                }
                .font(.system(size: 16, weight: .bold))
                .frame(width: 40) // Width for label alignment
                
                // Main graph area
                GeometryReader { geo in
                    ZStack {
                        // Vertical grid lines
                        ForEach(0..<12) { index in
                            Rectangle()
                                .opacity(0.5)
                                .frame(width: 1)
                                .offset(x: CGFloat(index) * geo.size.width / 12)
                        }
                        
                        // Horizontal grid lines
                        ForEach(0..<4) { index in
                            Rectangle()
                                .opacity(0.5)
                                .frame(height: 1)
                                .offset(y: CGFloat(index) * geo.size.height / 4)
                        }
                        
                        // Dummy graph data
                        Path { path in
                            let width = geo.size.width
                            let height = geo.size.height
                            
                            // Start point
                            path.move(to: CGPoint(x: width * 0.2, y: height * 0.25))
                            
                            // Draw lines
                            path.addLine(to: CGPoint(x: width * 0.2, y: height * 0.5))
                            path.addLine(to: CGPoint(x: width * 0.3, y: height * 0.5))
                            path.addLine(to: CGPoint(x: width * 0.3, y: height * 0.75))
                            path.addLine(to: CGPoint(x: width * 0.5, y: height * 0.75))
                        }
                        .stroke(Color.blue, lineWidth: 2)
                        
                        // Border for graph
                        Rectangle()
                            .stroke(Color.gray, lineWidth: 1)
                    }
                }
                .aspectRatio(3, contentMode: .fit)
                .padding(.trailing, 4) // Padding for spacing

                // Column for time labels
                GeometryReader { geo in
                    VStack(alignment: .trailing, spacing: geo.size.height / 4) {
                        ForEach(0..<4) { _ in
                            Text("00:00")
                                .font(.system(size: 12))
                                .offset(x: 4)
                        }
                    }
                }
                .frame(width: 40) // Width for alignment of time labels
            }
            
            // Bottom time indicators
            HStack(spacing: 0) {
                ForEach(0..<12) { index in
                    Text("\(index)")
                        .font(.system(size: 12))
                        .frame(maxWidth: .infinity, alignment: .center)
                        .overlay(
                            Rectangle()
                                .opacity(0.5)
                                .frame(width: 1, height: 8)
                                .offset(y: -8)
                        )
                }
            }
            .padding(.horizontal, 20) // Add padding to align bottom axis
        }
        .padding(.leading, 20) // Padding for left alignment
        .padding(.top, 20) // Padding for top alignment
        .border(Color.gray, width: 1) // Outer border for the entire graph
    }
}

#Preview {
    GraphView()
}
