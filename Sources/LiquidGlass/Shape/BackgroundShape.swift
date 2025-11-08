//
//  BackgroundShape.swift
//  LiquidGlass

import SwiftUI

/// BackgroundShape describes simple shapes used by the glass background renderer.
///
/// Use `.shape` to obtain a `Shape` that can be placed into SwiftUI view builders.
public enum BackgroundShape: Sendable {
    /// Rounded rectangle with the given corner radius.
    /// The radius will be clamped to the available rect so the shape stays valid.
    case roundedRect(cornerRadius: CGFloat)

    /// A centered circle that fits inside the provided rect.
    case circle

    /// A capsule (pill) shape that fills the provided rect.
    case capsule

    /// Convenience `Shape` wrapper for the enum value.
    public var shape: CustomShape { CustomShape(shape: self) }
}

// MARK: - CustomShape

/// Internal `Shape` implementation that maps `BackgroundShape` cases to SwiftUI `Shape`
/// primitives where possible. Delegating to the standard shapes reduces code surface and
/// benefits from internal optimizations in the framework.
public struct CustomShape: Shape {
    /// Underlying enum value
    let shape: BackgroundShape

    public func path(in rect: CGRect) -> Path {
        switch shape {
        case .roundedRect(let cornerRadius):
            // Clamp the corner radius so it never exceeds half the smallest dimension.
            let radius = min(cornerRadius, rect.midX, rect.midY)
            return RoundedRectangle(cornerRadius: radius).path(in: rect)

        case .circle:
            // Create a centered circle that fits inside `rect` (preserves circle shape even
            // when rect is not square).
            let radius = min(rect.midX, rect.midY)
            let diameter = radius * 2
            let square = CGRect(x: rect.midX - radius, y: rect.midY - radius, width: diameter, height: diameter)
            return Path(ellipseIn: square)

        case .capsule:
            // Use the system `Capsule` to generate a pill-like path that fills the rect.
            return Capsule().path(in: rect)
        }
    }
}
