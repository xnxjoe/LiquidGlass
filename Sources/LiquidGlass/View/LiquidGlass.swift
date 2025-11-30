//
//  LiquidGlass.swift
//  LiquidGlass
//

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
/// - `opacity(_:)` to customize the highlight color opacity.
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
    /// - Parameter tint: A `Color` used to tint the subtle overlay gradient, or `nil` to remove tinting.
    /// - Returns: A new `LiquidGlass` with the specified tint color.
    ///
    /// The opacity of the glass effect is preserved.
    public func tint(_ tint: Color?) -> LiquidGlass {
        var copy = self
        copy.tintColor = tint
        return copy
    }

    public var body: some View {
        let baseShape = shape.shape
        let highlightOpacity = opacity * 0.75
        let tintOpacity = 0.2 * opacity
        
        // Base fill with system material for frosted effect
        baseShape
            .fill(.ultraThinMaterial)
            .overlay {
                // Conditional tint overlay
                if let tint = tintColor {
                    baseShape.fill(tint.opacity(tintOpacity))
                }
            }
            .overlay {
                // Highlight layer
                baseShape.fill(Color.highlight.opacity(highlightOpacity))
            }
            .overlay {
                // Decorative stroke with blend mode
                shape
                    .highlight(highlighting: Color.stroke, tint: tintColor)
                    .blendMode(.plusLighter)
            }
            .shadow(color: Color.shadow, radius: 15, x: 0, y: 6)
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
