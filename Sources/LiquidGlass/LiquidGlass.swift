// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

/// A SwiftUI view that renders a frosted-glass background for a ``BackgroundShape``.
///
/// ```swift
/// LiquidGlass(shape: .capsule)
///     .tint(.blue)
///     .opacity(0.8)
/// ```
///
/// This view composes multiple translucent fills, subtle multi-stop strokes, and a soft shadow
/// to create a glass-like visual. It is lightweight and keeps the public API minimal:
/// - `init(shape:)` to create the style for a given ``BackgroundShape``.
/// - `tint(_:)` to customize the accent/tint color used by subtle gradients.
/// - `opacity(_:)` to customize the hightlight color opacity.
public struct LiquidGlass: View {
    // MARK: - Stored properties

    /// Optional tint color. If not provided, `.accentColor` is used.
    private var tintColor: Color?

    /// Respect system color scheme for subtle color adjustments.
    @Environment(\.colorScheme) private var colorScheme

    /// Underlying shape to style (rounded rect, capsule, or circle)
    private let shape: BackgroundShape
    
    /// The opacity level for the glass effect (default: 0.6).
    /// Higher values make the glass more opaque, lower values more transparent.
    private var opacity: CGFloat = 0.6

    // MARK: - Initializer

    /// Create a glass style for the provided `BackgroundShape`.
    /// - Parameters:
    ///   - shape: the target `BackgroundShape` to render.
    public init(shape: BackgroundShape) {
        self.shape = shape
    }    

    // MARK: - Fluent API
    
    /// Return a modified view with the specified opacity value.
    /// - Parameter opacity: The opacity level for the glass effect (default: 0.6).
    ///   Higher values make the glass more opaque, lower values more transparent.
    /// - Returns: A new `LiquidGlass` with the specified opacity.
    public func opacity(_ opacity: CGFloat = 0.6) -> LiquidGlass {
        var copy = self
        copy.opacity = opacity
        return copy
    }

    /// Return a modified view using the provided `tint` color.
    /// - Parameter tint: a `Color` used to tint the subtle overlay gradient.
    /// - Returns: A new `LiquidGlass` with the specified tint color.
    ///
    /// The opacity of the glass effect is preserved.
    public func tint(_ tint: Color) -> LiquidGlass {
        var copy = self
        copy.tintColor = tint
        return copy
    }

    // MARK: - Computed colors

    /// Effective base color (tint or accent)
    private var color: Color {
        tintColor ?? .clear
    }

    /// Slight bright/dark highlight depending on environment
    private var highlightColor: Color {
        colorScheme == .dark ? .black.opacity(0.7 * 0.6 * opacity) : .white.opacity(1.0 * opacity)
    }

    /// Shadow color tuned for light/dark modes
    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.1) : .black.opacity(0.05)
    }

    /// Stroke base color (thin white-ish strokes in either mode)
    private var strokeColor: Color {
        tintColor?.opacity(0.3) ??
        (colorScheme == .dark ? Color.gray.opacity(0.3) : Color.white)
    }

    // MARK: - Gradients and styles

    /// Very subtle tint overlay to give the glass a hint of color.
    private var tintGradient: some ShapeStyle {
//        let baseColor = color
//        return LinearGradient(
//            gradient: Gradient(colors: [
//                baseColor.opacity(0.1),
//                baseColor.opacity(0.2),
//                baseColor.opacity(0.1)
//            ]),
//            startPoint: .topTrailing,
//            endPoint: .bottomLeading
//        )
        color.opacity(0.2)
    }

    /// A simple highlight color (keeps the shape bright at the top area).
    private var highlightGradient: some ShapeStyle {
        // Returning a Color here is sufficient (conforms to ShapeStyle).
        highlightColor.opacity(0.75)
    }

    /// Slight multi-stop gradient used for some stroke decorations.
    private var strokeGradient1: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                strokeColor.opacity(0.5),
                strokeColor.opacity(0.2),
                strokeColor.opacity(0.4)
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Opacity constants used across stroke gradients (consistent Double type)
    private let highOpacity: Double = 0.7
    private let lowOpacity: Double = 0.1

    // MARK: - View body
    
    private func gradient(startAngle: CGFloat, mid1: CGFloat, mid2: CGFloat) -> AngularGradient {
        let highStroke = strokeColor.opacity(highOpacity)
        let lowStroke = strokeColor.opacity(lowOpacity)
        
        return AngularGradient(
            stops: [
                .init(color: highStroke, location: 0),
                .init(color: lowStroke, location: mid1),
                .init(color: highStroke, location: 0.5),
                .init(color: lowStroke, location: mid2),
                .init(color: highStroke, location: 1)
            ],
            center: .center,
            angle: .radians(startAngle)
        )
    }

    public var body: some View {
        // Base fill: use a system material to provide the frosted effect, then layer other accents on top.
        shape
            .shape
            .fill(.ultraThinMaterial)
            // Tint overlay: soft colored wash
            .overlay {
                shape.shape.fill(tintGradient)
            }
            // Highlight: adds a faint brightening to the shape
            .overlay {
                shape.shape.fill(highlightGradient)
            }
            // Decorative strokes: vary by shape to match edges
            .overlay {
                Group {
                    switch shape {
                    case .roundedRect(let r):
                        GeometryReader { proxy in
                            shape
                                .shape
                                .stroke(
                                    calculatedGradient(proxy: proxy, radius: r)
                                )
                        }
                    case .circle:
                        // Single stroke gradient for circle
                        shape.shape
                            .stroke(
                                gradient(startAngle: .pi + .pi / 4, mid1: 0.25, mid2: 0.75)
                            )
                    case .capsule:
                        GeometryReader { proxy in
                            let r = proxy.size.height / 2
                            shape
                                .shape
                                .stroke(
                                    calculatedGradient(proxy: proxy, radius: r)
                                )
                        }
                    }
                }
                .blendMode(.plusLighter)
            }
            .shadow(color: shadowColor, radius: 15, x: 0, y: 6)
    }
    
    private func calculatedGradient(proxy: GeometryProxy, radius: CGFloat) -> AngularGradient {
        let halfWidth = proxy.size.width / 2
        let halfHeight = proxy.size.height / 2
        let d = halfWidth - radius
        let l = halfHeight - radius
        let sqrt2 = sqrt(2)
        
        let a = sqrt2 * l + radius
        let b = d - l
        let t1 = sqrt2 * a
        let t2 = a * a + b * b + sqrt2 * a * b
        let alpha = asin(t1 / (2 * sqrt(t2)))
        
        let startAngle = CGFloat.pi + alpha
        let mid = (CGFloat.pi - 2 * alpha) / (2 * CGFloat.pi)
        let mid2 = 0.5 + mid // Symmetric
        
        return gradient(startAngle: startAngle, mid1: mid, mid2: mid2)
    }
}



// MARK: - Preview

#Preview("LiquidGlass Examples") {
    let group = VStack(spacing: 30) {
        // Rounded rectangle with blue tint
        LiquidGlass(shape: .roundedRect(cornerRadius: 16))
            .frame(width: 200, height: 100)
        
        // Circle with pink tint
        LiquidGlass(shape: .circle)
            .frame(width: 120, height: 120)
        
        // Capsule with green tint
        LiquidGlass(shape: .capsule)
            .frame(width: 180, height: 60)
    }
    
    HStack {
        group
    }
    .padding(40)
    .background(
        LinearGradient(
            colors: [.purple.opacity(0.3), .blue.opacity(0.3)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    )
}
