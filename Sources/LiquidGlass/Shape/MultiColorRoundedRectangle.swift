//
//  MultiColorRoundedRectangle.swift
//  LiquidGlass
//
//  A custom view that draws a rounded rectangle outline with multi-colored gradient segments.
//

import SwiftUI

// MARK: - MultiColorRoundedRectangle

/// A view that renders a rounded rectangle outline with four independently colored segments.
///
/// This view divides the rectangle stroke into four sides (top, right, bottom, left), each stroked
/// with a different color/gradient. The segments transition smoothly at 45-degree points on the
/// rounded corners, creating a dynamic multi-color effect ideal for decorative glass borders.
///
/// - Note: Requires exactly 4 `ShapeStyle` values in the `colors` array for top, right, bottom, and left segments.
struct MultiColorRoundedRectangle<S: ShapeStyle>: View {
    // MARK: - Properties
    
    /// Corner radius for the rounded rectangle (clamped to fit within the rect)
    var cornerRadius: CGFloat = 20
    
    /// Width of the stroke line
    var lineWidth: CGFloat = 6
    
    /// Array of shape styles for each segment [top, right, bottom, left]
    var colors: [S]
    
    // MARK: - Body
    
    var body: some View {
        GeometryReader { proxy in
            let rect = proxy.frame(in: .local)
            // Clamp corner radius to ensure it fits within the rectangle
            let cornerRadius = min(cornerRadius, rect.midX, rect.midY)
            
            ZStack {
                // MARK: Top segment
                // Draws: left corner transition (270° → 225°) + top straight line + right corner transition (270° → 315°)
                Path { path in
                    let start = CGPoint(x: rect.minX + cornerRadius, y: rect.minY)
                    
                    // Left top corner transition (45° arc ending at top edge)
                    path.move(to: start)
                    path.addArc(
                        center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(270),
                        endAngle: .degrees(225),
                        clockwise: true
                    )
                    
                    // Top straight edge (left to right)
                    path.move(to: start)
                    path.addLine(to: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY))
                    
                    // Right top corner transition (45° arc starting from top edge)
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
                // Draws: top-right corner (315° → 0°) + right straight line + bottom-right corner (0° → 45°)
                Path { path in
                    let start = CGPoint(x: rect.maxX, y: rect.minY + cornerRadius)
                    let lineEnd = CGPoint(x: rect.maxX, y: rect.maxY - cornerRadius)
                    
                    // Top-right corner continuation (from 315° to 0°)
                    path.addArc(
                        center: CGPoint(x: rect.maxX - cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(315),
                        endAngle: .degrees(0),
                        clockwise: false
                    )
                    
                    // Right straight edge (top to bottom)
                    path.move(to: start)
                    path.addLine(to: lineEnd)
                    
                    // Bottom-right corner start (from 0° to 45°)
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
                // Draws: right corner transition (90° → 45°) + bottom straight line + left corner transition (90° → 135°)
                Path { path in
                    let start = CGPoint(x: rect.maxX - cornerRadius, y: rect.maxY)
                    let lineEnd = CGPoint(x: rect.minX + cornerRadius, y: rect.maxY)
                    
                    // Right bottom corner transition (45° arc ending at bottom edge)
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
                    
                    // Left bottom corner transition (45° arc starting from bottom edge)
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
                // Draws: top-left corner (180° → 225°) + left straight line + bottom-left corner (180° → 135°)
                Path { path in
                    let start = CGPoint(x: rect.minX, y: rect.minY + cornerRadius)
                    let lineEnd = CGPoint(x: rect.minX, y: rect.maxY - cornerRadius)
                    
                    // Top-left corner continuation (from 180° to 225°)
                    path.move(to: start)
                    path.addArc(
                        center: CGPoint(x: rect.minX + cornerRadius, y: rect.minY + cornerRadius),
                        radius: cornerRadius,
                        startAngle: .degrees(180),
                        endAngle: .degrees(225),
                        clockwise: false
                    )
                    
                    // Left straight edge (top to bottom)
                    path.move(to: start)
                    path.addLine(to: lineEnd)
                    
                    // Bottom-left corner start (from 180° to 135°, drawn backward)
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

#Preview("Multi-Color Rounded Rectangle") {
    MultiColorRoundedRectangle(
        cornerRadius: 20,
        lineWidth: 3,
        colors: [
            Color.red,
            Color.green,
            Color.blue,
            Color.orange
        ]
    )
    .frame(width: 200, height: 150)
    .padding()
}
