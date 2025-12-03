//
//  GlassButtonStyle.swift
//  LiquidGlass
//
//

import SwiftUI


/// A button style that adds a subtle hover background and the glass effect.
///
/// `GlassButtonStyle` is a lightweight, composable button style that combines a
/// shape-based hover/focus background with the library's `GlassEffectModifier`.
/// It supports both content-padding and fixed-size usages.
public struct GlassButtonStyle: ButtonStyle {
    // MARK: - Properties
    
    /// The background shape for the button.
    private let shape: BackgroundShape
    
    /// Whether to use the prominent glass style (more visible/emphasized).
    private let prominent: Bool
    
    /// Optional identifier for matched geometry effects.
    private let id: String?
    
    /// Optional namespace for matched geometry effects.
    private let namespace: Namespace.ID?
    
    // MARK: - Initializer
    
    /// Creates a glass button style.
    ///
    /// - Parameters:
    ///   - shape: The background shape for the button.
    ///   - prominent: Whether to use the prominent (emphasized) glass style.
    ///   - id: Optional identifier for matched geometry effects.
    ///   - namespace: Optional namespace for matched geometry effects.
    public init(
        shape: BackgroundShape = .roundedRect(cornerRadius: 12),
        prominent: Bool = false,
        id: String? = nil,
        namespace: Namespace.ID? = nil
    ) {
        self.shape = shape
        self.prominent = prominent
        self.id = id
        self.namespace = namespace
    }

    
    // MARK: - Private Helpers
    
    /// Applies the appropriate system glass button style for Platform 26+.
    @ViewBuilder
    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
    private func systemGlassButton(label: Configuration.Label) -> some View {
        if prominent {
            label.buttonStyle(.glassProminent)
        } else {
            label.buttonStyle(.glass)
        }
    }
    
    /// Applies system button border shapes for Platform 14+.
    @ViewBuilder
    @available(macOS 14.0, iOS 16.0, watchOS 9.0, tvOS 16.0, *)
    private func applySystemButtonShape<T: View>(to content: T) -> some View {
        switch shape {
        case .roundedRect(let cornerRadius):
            content.buttonBorderShape(.roundedRectangle(radius: cornerRadius))
        case .circle:
            content.buttonBorderShape(.circle)
        case .capsule:
            content.buttonBorderShape(.capsule)
        }
    }

    /// Creates the custom glass background for pre-Platform 26 systems.
    @ViewBuilder
    private func customGlassBackground(isPressed: Bool) -> some View {
        LiquidGlass(shape: shape)
            .tint(isPressed ? Color.secondary : (prominent ? .accentColor : nil))
    }

    // MARK: - ButtonStyle Protocol
    
    public func makeBody(configuration: Configuration) -> some View {
        if #available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *) {
            // Use system glass button styles on Platform 26+
            let glassButton = systemGlassButton(label: configuration.label)
            applySystemButtonShape(to: glassButton)
        } else {
            // Use custom glass background for earlier platforms
            configuration.label
                .background {
                    customGlassBackground(isPressed: configuration.isPressed)
                }
        }
    }
}


#Preview {
    Button {
        //
    } label: {
        Text("Tap Me!")
            .padding(12)
    }
    .buttonStyle(GlassButtonStyle(shape: .capsule))
    .padding()
}
