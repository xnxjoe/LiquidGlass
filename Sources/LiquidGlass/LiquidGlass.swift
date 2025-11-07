// The Swift Programming Language
// https://docs.swift.org/swift-book


import SwiftUI

/// GlassStyle: A SwiftUI view that renders a frosted-glass background for a `BackgroundShape`.
///
/// Usage:
///     GlassStyle(shape: .capsule)
///         .tint(.blue)
///
/// This view composes multiple translucent fills, subtle multi-stop strokes, and a soft shadow
/// to create a glass-like visual. It is lightweight and keeps the public API minimal:
/// - `init(shape:)` to create the style for a given `BackgroundShape`.
/// - `tint(_:)` to customize the accent/tint color used by subtle gradients.
public struct GlassStyle: View {
    // MARK: - Stored properties

    /// Optional tint color. If not provided, `.accentColor` is used.
    private var tintColor: Color? = nil

    /// Respect system color scheme for subtle color adjustments.
    @Environment(\.colorScheme) private var colorScheme

    /// Underlying shape to style (rounded rect, capsule, or circle)
    private let shape: BackgroundShape
    
    private let opacity: CGFloat

    // MARK: - Initializer

    /// Create a glass style for the provided `BackgroundShape`.
    /// - Parameter shape: the target `BackgroundShape` to render.
    public init(shape: BackgroundShape, opacity: CGFloat = 0.6) {
        self.shape = shape
        self.opacity = opacity
    }

    // MARK: - Fluent API

    /// Return a copy of this style using the provided `tint` color.
    /// - Parameter tint: a `Color` used to tint the subtle overlay gradient.
    public func tint(_ tint: Color) -> GlassStyle {
        var copy = self
        copy.tintColor = tint
        return copy
    }

    // MARK: - Computed colors

    /// Effective base color (tint or accent)
    private var color: Color {
//        tintColor ?? ( colorScheme == .dark ? .black : .white)
        tintColor ?? .accentColor
    }

    /// Slight bright/dark highlight depending on environment
    private var highlightColor: Color {
        colorScheme == .dark ? .black.opacity(0.7 * opacity) : .white.opacity(0.9 * opacity)
    }

    /// Shadow color tuned for light/dark modes
    private var shadowColor: Color {
        colorScheme == .dark ? Color.black.opacity(0.1) : .black.opacity(0.05)
    }

    /// Stroke base color (thin white-ish strokes in either mode)
    private var strokeColor: Color {
        tintColor?.opacity(0.3) ??
        (colorScheme == .dark ? Color.gray.opacity(0.25) : Color.white)
    }

    // MARK: - Gradients and styles

    /// Very subtle tint overlay to give the glass a hint of color.
    private var tintGradient: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                color.opacity(0.005),
                color.opacity(0.012),
                color.opacity(0.008)
            ]),
            startPoint: .topTrailing,
            endPoint: .bottomLeading
        )
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
                strokeColor.opacity(0.4),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Opacity constants used across stroke gradients (consistent Double type)
    private let highOpacity: Double = 0.8
    private let lowOpacity: Double = 0.3

    /// A faint overlay stroke used to add subtle contouring.
    private var strokeGradient2: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [
                strokeColor.opacity(0.0),
                strokeColor.opacity(0.1),
            ]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // MARK: - View body

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
                switch shape {
                case .roundedRect(let cornerRadius):
                    MultiColorRoundedRectangle(
                        cornerRadius: cornerRadius,
                        lineWidth: 1,
                        colors: [strokeGradient11, strokeGradient12, strokeGradient13, strokeGradient14]
                    )
                case .circle:
                    // Single stroke gradient for circle
                    shape.shape.stroke(strokeGradient21, lineWidth: 1)
                case .capsule:
                    MultiColorCapsule(lineWidth: 1, colors: [strokeGradient31, strokeGradient32, strokeGradient33, strokeGradient34])
                }
            }
            // A final subtle overlay stroke to blend the edges
            .overlay {
                shape.shape.stroke(strokeGradient2, lineWidth: 1).blendMode(.overlay)
            }
            // Soft shadow to lift the glass from background
            .shadow(color: shadowColor, radius: 15, x: 0, y: 6)
    }
}

// MARK: - Stroke gradient helpers
private extension GlassStyle {
    // Rounded rectangle stroke gradients — used to create a soft multi-directional stroke
    private var strokeGradient11: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(highOpacity), strokeColor.opacity(lowOpacity)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private var strokeGradient12: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(lowOpacity), strokeColor.opacity(highOpacity)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var strokeGradient13: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(highOpacity), strokeColor.opacity(lowOpacity)]),
            startPoint: .trailing,
            endPoint: .leading
        )
    }

    private var strokeGradient14: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(lowOpacity), strokeColor.opacity(highOpacity)]),
            startPoint: .bottom,
            endPoint: .top
        )
    }

    // Circle stroke gradient — symmetric fade for circular highlights
    private var strokeGradient21: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(highOpacity), strokeColor.opacity(0), strokeColor.opacity(highOpacity)]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }

    // Capsule stroke gradients — four-directional gradients similar to rounded rect
    private var strokeGradient31: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(highOpacity), strokeColor.opacity(0)]),
            startPoint: .leading,
            endPoint: .trailing
        )
    }

    private var strokeGradient32: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(0), strokeColor.opacity(highOpacity)]),
            startPoint: .top,
            endPoint: .bottom
        )
    }

    private var strokeGradient33: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(highOpacity), strokeColor.opacity(0)]),
            startPoint: .trailing,
            endPoint: .leading
        )
    }

    private var strokeGradient34: LinearGradient {
        LinearGradient(
            gradient: Gradient(colors: [strokeColor.opacity(0), strokeColor.opacity(highOpacity)]),
            startPoint: .bottom,
            endPoint: .top
        )
    }
}

// MARK: - Preview

#Preview("GlassStyle Examples") {
    let group = VStack(spacing: 30) {
        // Rounded rectangle with blue tint
        GlassStyle(shape: .roundedRect(cornerRadius: 16))
            .frame(width: 200, height: 100)
        
        // Circle with pink tint
        GlassStyle(shape: .circle)
            .frame(width: 120, height: 120)
        
        // Capsule with green tint
        GlassStyle(shape: .capsule)
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
