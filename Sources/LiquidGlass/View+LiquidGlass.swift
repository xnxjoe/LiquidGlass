//
//  View+LiquidGlass.swift
//  LiquidGlass
//
//  Public extension to apply liquid glass effects to any SwiftUI view.
//

import SwiftUI

// MARK: - View Extension

public extension View {
    /// Apply a frosted-glass background effect to SwiftUI view.
    ///
    /// This modifier creates a frosted glass appearance behind the view content.
    /// On Platform 26+, it uses the system `.glassEffect(in:)` API.
    /// On earlier OS versions, it falls back to a custom glass implementation.
    ///
    /// Example usage:
    /// ```swift
    /// Text("Hello, World!")
    ///     .padding()
    ///     .liquidGlass(shape: .roundedRect(cornerRadius: 16), hoverEffect: true)
    /// ```
    ///
    /// - Parameters:
    ///   - shape: The ``BackgroundShape`` to use (roundedRect, circle, or capsule).
    ///   - opacity: The opacity level for the glass effect (default: 0.6).
    ///     Higher values make the glass more opaque, lower values more transparent.
    ///   - hoverEffect: If `true`, shows a subtle fill on pointer hover. Default is `false`.
    ///   - id: Optional identifier for matched geometry effects (Platform 26+). Default is `nil`.
    ///   - namespace: Optional namespace for matched geometry effects (Platform 26+). Default is `nil`.
    /// - Returns: A view with a glass background effect applied.
    func liquidGlass(
        shape: BackgroundShape = .capsule,
        opacity: CGFloat = 0.6,
        hoverEffect: Bool = false,
        id: String? = nil,
        namespace: Namespace.ID? = nil
    ) -> some View {
        self.modifier(
            GlassEffectModifier(
                shape: shape,
                opacity: opacity,
                hoverEffect: hoverEffect,
                id: id,
                namespace: namespace
            )
        )
    }
}
