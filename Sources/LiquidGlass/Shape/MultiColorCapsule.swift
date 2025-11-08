//
//  MultiColorCapsule.swift
//  LiquidGlass
//
//  A custom view that draws a capsule outline with multi-colored gradient segments.
//

import SwiftUI

// MARK: - MultiColorCapsule

/// A view that renders a capsule (pill) shape outline with four independently colored segments.
///
/// This view divides the capsule stroke into four quadrants, each stroked with a different color/gradient.
/// The segments transition smoothly at 45-degree points on the rounded ends, creating a dynamic
/// multi-color effect ideal for decorative glass borders.
///
/// - Note: Requires exactly 4 `ShapeStyle` values in the `colors` array for top, right, bottom, and left segments.
internal struct MultiColorCapsule<S: ShapeStyle>: View {
    // MARK: - Properties
    
    /// Width of the stroke line
    var lineWidth: CGFloat = 6
    
    /// Array of shape styles for each segment [top, right, bottom, left]
    var colors: [S]
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .local)
            // Capsule radius is half the smaller dimension (height or width)
            let cornerRadius = min(rect.midX, rect.midY)
            
            ZStack {
                // MARK: Top segment
                // Draws: left arc transition (270° → 225°) + top straight line + right arc transition (270° → 315°)
                Path { path in
                    let start = CGPoint(x: rect.minX + cornerRadius, y: rect.minY)
                    
                    // Left top arc transition (45° segment ending at top)
                    path.move(to: start)
                    path.addArc(
                        center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(270),
                        endAngle: .degrees(225),
                        clockwise: true
                    )
                    
                    // Top straight edge
                    path.move(to: start)
                    path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
                    
                    // Right top arc transition (45° segment starting from top)
                    path.addArc(
                        center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(270),
                        endAngle: .degrees(315),
                        clockwise: false
                    )
                }
                .stroke(colors[0], lineWidth: lineWidth)
                
                // MARK: Right segment
                // Draws: top-right arc (315° → 0°) + right arc continues (0° → 45°)
                Path { path in
                    // Top-right arc continuation (from 315° to 0°)
                    path.addArc(
                        center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(315),
                        endAngle: .degrees(0),
                        clockwise: false
                    )
                    
                    // Bottom-right arc start (from 0° to 45°)
                    path.addArc(
                        center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(0),
                        endAngle: .degrees(45),
                        clockwise: false
                    )
                }
                .stroke(colors[1], lineWidth: lineWidth)
                
                // MARK: Bottom segment
                // Draws: right arc transition (90° → 45°) + bottom straight line + left arc transition (90° → 135°)
                Path { path in
                    let start = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY)
                    let lineEnd = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY)
                    
                    // Right bottom arc transition (45° segment ending at bottom)
                    path.move(to: start)
                    path.addArc(
                        center: CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(45),
                        clockwise: true
                    )
                    
                    // Bottom straight edge (right to left)
                    path.move(to: start)
                    path.addLine(to: lineEnd)
                    
                    // Left bottom arc transition (45° segment starting from bottom)
                    path.addArc(
                        center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(90),
                        endAngle: .degrees(135),
                        clockwise: false
                    )
                }
                .stroke(colors[2], lineWidth: lineWidth)
                
                // MARK: Left segment
                // Draws: top-left arc (180° → 225°) + bottom-left arc (180° → 135°)
                Path { path in
                    let start = CGPoint(x: rect.minX, y: rect.minY + cornerRadius)
                    
                    // Top-left arc continuation (from 180° to 225°)
                    path.move(to: start)
                    path.addArc(
                        center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(225),
                        clockwise: false
                    )
                    
                    // Bottom-left arc start (from 180° to 135°, drawn backward)
                    path.move(to: start)
                    path.addArc(
                        center: CGPoint(x: rect.minX + cornerRadius, y: rect.maxY - cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(135),
                        clockwise: true
                    )
                }
                .stroke(colors[3], lineWidth: lineWidth)
            }
        }
    }
}

// MARK: - Preview

#Preview("Multi-Color Capsule") {
    MultiColorCapsule(
        lineWidth: 3,
        colors: [
            Color.red,
            Color.blue,
            Color.green,
            Color.purple
        ]
    )
    .frame(width: 200, height: 100)
    .padding()
}
