//
//  GlassToggleStyle.swift
//  LiquidGlass
//
//

import SwiftUI

/// A toggle style that switches between expanded and collapsed states with glass effects.
///
/// `GlassToggleStyle` creates an animated toggle that shows the full label when on
/// and only the icon when off, both with glass backgrounds that adapt their shapes.
///
/// ```swift
/// @State private var isEnabled = false
/// @Namespace private var toggleNamespace
///
/// Toggle("Settings", systemImage: "gear", isOn: $isEnabled)
///     .toggleStyle(GlassToggleStyle(
///         shape: .roundedRect(cornerRadius: 12),
///         id: "settings-toggle",
///         namespace: toggleNamespace
///     ).tint(.blue))
/// ```
public struct GlassToggleStyle: ToggleStyle {

    // MARK: - Properties
    
    /// The background shape for the expanded (on) state.
    private let backgroundShape: BackgroundShape
    
    /// Padding applied to the toggle content.
    private let padding: EdgeInsets
    
    /// Identifier for matched geometry effects.
    private let id: String
    
    /// Namespace for matched geometry effects.
    private let namespace: Namespace.ID
    
    /// Optional tint color for the icon when enabled.
    private var tint: Color?

    // MARK: - Initializers
    
    /// Creates a glass toggle style with explicit edge insets.
    ///
    /// - Parameters:
    ///   - shape: The background shape for the expanded state.
    ///   - padding: Edge insets for content padding.
    ///   - id: Identifier for matched geometry effects.
    ///   - namespace: Namespace for matched geometry effects.
    public init(
        shape: BackgroundShape,
        padding: EdgeInsets = EdgeInsets(top: 6, leading: 10, bottom: 6, trailing: 10),
        id: String,
        namespace: Namespace.ID
    ) {
        self.backgroundShape = shape
        self.padding = padding
        self.id = id
        self.namespace = namespace
    }

    /// Creates a glass toggle style with uniform padding.
    ///
    /// - Parameters:
    ///   - shape: The background shape for the expanded state.
    ///   - padding: Uniform padding value for all edges.
    ///   - id: Identifier for matched geometry effects.
    ///   - namespace: Namespace for matched geometry effects.
    public init(
        shape: BackgroundShape,
        padding: CGFloat,
        id: String,
        namespace: Namespace.ID
    ) {
        let edgeInsets = EdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        self.init(shape: shape, padding: edgeInsets, id: id, namespace: namespace)
    }

    // MARK: - Fluent API
    
    /// Returns a modified toggle style with the specified tint color.
    /// - Parameter color: The color to apply to the icon when the toggle is enabled.
    /// - Returns: A new `GlassToggleStyle` with the specified tint.
    public func tint(_ color: Color) -> Self {
        var copy = self
        copy.tint = color
        return copy
    }

    // MARK: - ToggleStyle Protocol
    
    public func makeBody(configuration: Configuration) -> some View {
        let toggleContent = Group {
            if configuration.isOn {
                // Expanded state: show full label with background shape
                configuration.label
                    .labelStyle(ToggleLabelStyle(tint: tint))
                    .padding(padding)
                    .modifier(GlassEffectModifier(
                        shape: backgroundShape,
                        hoverEffect: true,
                        id: id,
                        namespace: namespace
                    ))
            } else {
                // Collapsed state: show only icon with circular background
                configuration.label
                    .labelStyle(.iconOnly)
                    .padding(padding.top)
                    .modifier(GlassEffectModifier(
                        shape: .circle,
                        hoverEffect: true,
                        id: id,
                        namespace: namespace
                    ))
            }
        }
        
        if #available(macOS 14.0, *) {
            toggleContent
                .transition(.opacity.combined(with: .symbolEffect))
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        } else {
            toggleContent
                .transition(.opacity)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}

// MARK: - Private Label Style

/// Internal label style that applies tinting to the icon when provided.
private struct ToggleLabelStyle: LabelStyle {
    let tint: Color?

    func makeBody(configuration: Configuration) -> some View {
        Label {
            configuration.title
        } icon: {
            if let tint = tint {
                configuration.icon
                    .foregroundStyle(tint)
            } else {
                configuration.icon
            }
        }
        .labelStyle(.titleAndIcon)
        .symbolVariant(.fill)
    }
}
