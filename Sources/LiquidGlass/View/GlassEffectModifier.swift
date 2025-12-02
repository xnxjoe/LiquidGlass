//
//  GlassEffectModifier.swift
//  LiquidGlass
//
//  A ViewModifier that applies a glass effect to any SwiftUI view.
//

import SwiftUI

// MARK: - GlassEffectModifier

/// A `ViewModifier` that applies a frosted-glass background to the modified view.
///
/// On OS Platform 26+, this modifier uses the system's native `.glassEffect(in:)` API.
/// On earlier OS versions, it falls back to the custom ``LiquidGlass`` implementation.
///
/// Optional features:
/// - **Hover effect**: When enabled, shows a subtle quaternary fill on pointer hover.
/// - **Namespace matching**: Supports `glassEffectID(_:in:)` for matched geometry effects.
public struct GlassEffectModifier: ViewModifier {
    // MARK: - Properties
    
    /// The underlying background shape (roundedRect, circle, capsule)
    private let shape: BackgroundShape
    
    /// Optional identifier for matched geometry glass effects (Platform 26+)
    private let id: String?
    
    /// Optional namespace for matched geometry glass effects (Platform 26+)
    private let namespace: Namespace.ID?
    
    /// Whether to show a subtle hover effect on pointer hover
    private let hoverEffect: Bool

    /// The opacity level for the glass effect (default: 0.6).
    /// Higher values make the glass more opaque, lower values more transparent.
    private let opacity: CGFloat
    
    private let tint: Color?
    
    /// Tracks current hover state (used when hoverEffect is true)
    @State private var onHover: Bool = false
    
    /// Respect system color scheme for subtle color adjustments.
    @Environment(\.colorScheme) private var colorScheme

    // MARK: - Initializer
    
    /// Create a glass effect modifier.
    /// - Parameters:
    ///   - shape: The `BackgroundShape` to use for the glass background.
    ///   - opacity: The opacity level for the glass effect (default: 0.6).
    ///     Higher values make the glass more opaque, lower values more transparent.
    ///   - hoverEffect: If `true`, displays a subtle fill on pointer hover. Default is `false`.
    ///   - id: Optional identifier for matched geometry effects (Platform 26+).
    ///   - namespace: Optional namespace for matched geometry effects (Platform 26+).
    public init(
        shape: BackgroundShape,
        opacity: CGFloat = 0.6,
        tint: Color? = nil,
        hoverEffect: Bool = false,
        id: String? = nil,
        namespace: Namespace.ID? = nil
    ) {
        self.shape = shape
        self.id = id
        self.namespace = namespace
        self.hoverEffect = hoverEffect
        self.opacity = opacity
        self.tint = tint
    }
    
//    /// Convenience computed property to convert `BackgroundShape` to `Shape`
//    private var containerShape: some Shape {
//        shape.shape
//    }
    
    // MARK: - Body
    
    public func body(content: Content) -> some View {
        Group {
            if #available(iOS 26.0, macOS 26.0, tvOS 26.0, watchOS 26.0, *) {
                let glassContent = Group {
                    switch self.shape {
                    case .roundedRect(let cornerRadius):
                        content
                            .glassEffect(in: RoundedRectangle(cornerRadius: cornerRadius))
                    case .circle:
                        content
                            .glassEffect(in: .circle)
                    case .capsule:
                        content
                            .glassEffect(in: .capsule)
                    }
                }
                    .tint(tint)
                    .backgroundStyle(hoverEffect && onHover ? AnyShapeStyle(hoverBackground) : AnyShapeStyle(.clear))
                // Use the system glass effect API
                if let id = id, let namespace = namespace {
                    // Apply matched geometry glass effect with ID
                    glassContent
                        .glassEffectID(id, in: namespace)
                } else {
                    // Apply glass effect without matched geometry
                    glassContent
                }
            } else {
                // Fallback to custom glass style for earlier OS versions
                content
                    .background {
                        LiquidGlass(shape: shape, hovering: hoverEffect && onHover)
                            .opacity(opacity)
                            .tint(tint)
                    }
                    .background {
                        Group {
                            switch shape {
                            case .roundedRect(let cornerRadius):
                                RoundedRectangle(cornerRadius: cornerRadius)
                                    .fill(hoverEffect && onHover ? AnyShapeStyle(hoverBackground) : AnyShapeStyle(.clear))
                            case .circle:
                                Circle()
                                    .fill(hoverEffect && onHover ? AnyShapeStyle(hoverBackground) : AnyShapeStyle(.clear))
                            case .capsule:
                                Capsule()
                                    .fill(hoverEffect && onHover ? AnyShapeStyle(hoverBackground) : AnyShapeStyle(.clear))
                            }
                        }
                    }
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
    }
    
    private var hoverBackground: some ShapeStyle {
        colorScheme == .dark ? AnyShapeStyle(.quaternary) : AnyShapeStyle(.white)
    }
    
}
