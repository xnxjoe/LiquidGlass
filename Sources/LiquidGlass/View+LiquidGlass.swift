//
//  View+LiquidGlass.swift
//  LiquidGlass
//
//  Public extension to apply liquid glass effects to any SwiftUI view.
//

import SwiftUI

// MARK: - View Extension

public extension View {
    /// Apply a liquid glass background effect to this view.
    ///
    /// This modifier creates a frosted glass appearance behind the view content.
    /// On iOS 26+ and macOS 26+, it uses the system `.glassEffect(in:)` API.
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
    ///   - shape: The `BackgroundShape` to use (roundedRect, circle, or capsule).
    ///   - hoverEffect: If `true`, shows a subtle fill on pointer hover. Default is `false`.
    ///   - id: Optional identifier for matched geometry effects (iOS 26+). Default is `nil`.
    ///   - namespace: Optional namespace for matched geometry effects (iOS 26+). Default is `nil`.
    /// - Returns: A view with a glass background effect applied.
    func liquidGlass(
        shape: BackgroundShape,
        hoverEffect: Bool = false,
        id: String? = nil,
        namespace: Namespace.ID? = nil
    ) -> some View {
        self.modifier(
            GlassEffectModifier(
                shape: shape,
                hoverEffect: hoverEffect,
                id: id,
                namespace: namespace
            )
        )
    }
}
