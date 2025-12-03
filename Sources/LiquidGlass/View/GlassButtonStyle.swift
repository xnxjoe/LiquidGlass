//
//  GlassButtonStyle.swift
//  LiquidGlass
//
//

import SwiftUI

/// A button style that adds a subtle hover background and the glass effect.
///
/// `GlassButtonStyle` is a lightweight, composable button style that combines a
/// It supports both content-padding and fixed-size usages.
public struct GlassButtonStyle: ButtonStyle {
    // MARK: - Properties
    
    /// The background shape for the button.
    private let shape: BackgroundShape
    
    /// Whether to use the prominent glass style (more visible/emphasized).
    private let prominent: Bool
    
    private var tint: Color?
    
    // MARK: - Initializer
    
    /// Creates a glass button style.
    ///
    /// - Parameters:
    ///   - shape: The background shape for the button.
    ///   - prominent: Whether to use the prominent (emphasized) glass style.
    public init(
        shape: BackgroundShape = .roundedRect(cornerRadius: 12),
        prominent: Bool = false
    ) {
        self.shape = shape
        self.prominent = prominent
    }
    
    public func tint(_ tint: Color?) -> Self {
        var copy = self
        copy.tint = tint
        return copy
    }
    
    private var prominentColor: Color {
        tint ?? .accentColor
    }

    // MARK: - Private Helpers
    
    /// Applies the appropriate system glass button style for Platform 26+.
    @ViewBuilder
    @available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *)
    private func systemGlassButton(label: Configuration.Label) -> some View {
        if prominent {
            label
                .buttonStyle(.glassProminent)
                .tint(prominentColor)
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

    // MARK: - ButtonStyle Protocol
    
    public func makeBody(configuration: Configuration) -> some View {
        if #available(macOS 26.0, iOS 26.0, watchOS 26.0, tvOS 26.0, *) {
            // Use system glass button styles on Platform 26+
            applySystemButtonShape(to: systemGlassButton(label: configuration.label))
        } else {
            let tintColor: Color? = configuration.isPressed ? .secondary : (prominent ?  prominentColor : nil)
            // Use custom glass background for earlier platforms
            configuration.label
                .buttonStyle(.plain)
                .liquidGlass(shape: shape, tint: tintColor, hoverEffect: !configuration.isPressed)
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
