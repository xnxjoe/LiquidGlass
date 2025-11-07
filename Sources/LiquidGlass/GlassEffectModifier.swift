//
//  GlassEffectModifier.swift
//  LiquidGlass
//
//  A ViewModifier that applies a glass effect to any SwiftUI view.
//

import SwiftUI

// MARK: - GlassEffectModifier

/// A `ViewModifier` that applies a frosted glass background to the modified view.
///
/// On OS Platform 26+, this modifier uses the system's native `.glassEffect(in:)` API.
/// On earlier OS versions, it falls back to the custom `GlassStyle` implementation.
///
/// Optional features:
/// - **Hover effect**: When enabled, shows a subtle quaternary fill on pointer hover.
/// - **Namespace matching**: Supports `glassEffectID(_:in:)` for matched geometry effects.
public struct GlassEffectModifier: ViewModifier {
    // MARK: - Properties
    
    /// The underlying background shape (roundedRect, circle, capsule)
    private let shape_: BackgroundShape
    
    /// Optional identifier for matched geometry glass effects (Platform 26+)
    private let id: String?
    
    /// Optional namespace for matched geometry glass effects (Platform 26+)
    private let namespace: Namespace.ID?
    
    /// Whether to show a subtle hover effect on pointer hover
    private let hoverEffect: Bool
    
    /// Tracks current hover state (used when hoverEffect is true)
    @State private var onHover = false

    // MARK: - Initializer
    
    /// Create a glass effect modifier.
    /// - Parameters:
    ///   - shape: The `BackgroundShape` to use for the glass background.
    ///   - hoverEffect: If `true`, displays a subtle fill on pointer hover. Default is `false`.
    ///   - id: Optional identifier for matched geometry effects (iOS 26+).
    ///   - namespace: Optional namespace for matched geometry effects (iOS 26+).
    init(
        shape: BackgroundShape,
        hoverEffect: Bool = false,
        id: String? = nil,
        namespace: Namespace.ID? = nil
    ) {
        self.shape_ = shape
        self.id = id
        self.namespace = namespace
        self.hoverEffect = hoverEffect
    }
    
    /// Convenience computed property to convert `BackgroundShape` to `Shape`
    private var shape: some Shape {
        shape_.shape
    }
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        Group {
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
                // Use the system glass effect API
                if let id = id, let namespace = namespace {
                    // Apply matched geometry glass effect with ID
                    content
                        .glassEffect(in: shape)
                        .glassEffectID(id, in: namespace)
                } else {
                    // Apply glass effect without matched geometry
                    content
                        .glassEffect(in: shape)
                }
            } else {
                // Fallback to custom glass style for earlier OS versions
                content
                    .background(GlassStyle(shape: shape_))
            }
        }
        // Track hover state if hover effect is enabled
        .onHover { hovering in
            if hoverEffect {
                withAnimation {
                    self.onHover = hovering
                }
            }
        }
        // Show a subtle fill on hover when enabled
        .background(
            shape.fill(
                hoverEffect && onHover ? AnyShapeStyle(.quaternary) : AnyShapeStyle(.clear)
            )
        )
    }
}
