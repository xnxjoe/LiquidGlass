//
//  BackgroundShape.swift
//  LiquidGlass

import SwiftUI

/// BackgroundShape describes simple shapes used by the glass background renderer.
///
/// Use `.shape` to obtain a `Shape` that can be placed into SwiftUI view builders.
public enum BackgroundShape: Sendable {

    case roundedRect(cornerRadius: CGFloat)

    case circle

    case capsule

    public var shape: CustomShape {
        switch self {
        case .roundedRect(let cornerRadius):
            return CustomShape(shape: self, animatableCornerRadius: cornerRadius)
        case .circle, .capsule:
            return CustomShape(shape: self)
        }
    }
}

// MARK: - CustomShape (Insettable, Animatable, Sendable)
/// Animatable, insettable shape that works with BackgroundShape enum (Sendable)
public struct CustomShape: InsettableShape, Animatable, Sendable {
    // MARK: - Properties
    /// Internal inset amount (animatable)
    private var insetAmount: CGFloat = 0.0
    
    /// Animatable corner radius
    public var animatableCornerRadius: CGFloat
    
    /// The underlying shape type
    public let shape: BackgroundShape
    
    // MARK: - Animatable Data
    public var animatableData: AnimatablePair<CGFloat, CGFloat> {
        get { AnimatablePair(insetAmount, animatableCornerRadius) }
        set {
            insetAmount = newValue.first
            animatableCornerRadius = newValue.second
        }
    }
    
    // MARK: - Initializer
    /// Create a CustomShape from a BackgroundShape
    public init(shape: BackgroundShape, animatableCornerRadius: CGFloat = 0) {
        self.shape = shape
        self.animatableCornerRadius = animatableCornerRadius
    }
    
    // MARK: - InsettableShape Requirement
    public func inset(by amount: CGFloat) -> Self {
        var copy = self
        copy.insetAmount = max(0, insetAmount + amount)
        return copy
    }

    // MARK: - Shape Requirement
    public func path(in rect: CGRect) -> Path {
        let insetRect = rect.insetBy(dx: insetAmount, dy: insetAmount)
        guard insetRect.width > 0, insetRect.height > 0 else { return Path() }

        switch shape {
        case .roundedRect:
            let maxRadius = min(insetRect.width, insetRect.height) / 2
            let radius = min(animatableCornerRadius, maxRadius)
            return RoundedRectangle(cornerRadius: radius).path(in: insetRect)

        case .circle:
            let size = min(insetRect.width, insetRect.height)
            let circleRect = CGRect(
                x: insetRect.midX - size / 2,
                y: insetRect.midY - size / 2,
                width: size,
                height: size
            )
            return Path(ellipseIn: circleRect)

        case .capsule:
            return Capsule().path(in: insetRect)
        }
    }
}
