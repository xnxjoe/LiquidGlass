# Getting Started

Create a glass effect view or use view modifier.

@Metadata {
    @PageImage(purpose: card, source: "LiquidGlass", alt: "The profile images for a LiquidGlass View.")
}

## Overview

LiquidGlass provides a SwiftUI component for creating realistic frosted glass effects with smooth gradients and shadows. It supports built-in shapes such as rounded rectangles, circles, and capsules, and allows customization of color tints and opacity. Optional hover effects are available for macOS and iPadOS, offering interactive feedback. LiquidGlass automatically uses the system `glassEffect` API when available.

### Create a liquid glass view

Create a glass effect view using ``LiquidGlass``:

```swift
import SwiftUI
import LiquidGlass

struct ContentView: View {
    var body: some View {
        LiquidGlass(shape: .roundedRect(cornerRadius: 12))
            .tint(Color.blue)
            .opacity(0.6)
            .frame(width: 200, height: 100)
    }
}
```

### Apply the glass effect

For convenience, add glass effect to a SwiftUI view using the ``SwiftUICore/View/liquidGlass(shape:opacity:hoverEffect:id:namespace:)`` modifier:

```swift
import SwiftUI
import LiquidGlass

struct ContentView: View {
    var body: some View {
        Text("Hello, Glass!")
            .padding()
            .liquidGlass(shape: .roundedRect(cornerRadius: 16))
    }
}
```

#### Shape

```swift
Text("Rounded Rectangle")
    .padding(20)
    .liquidGlass(shape: .roundedRect(cornerRadius: 16))

Text("Circle")
    .padding(20)
    .liquidGlass(shape: .circle)

Text("Capsule")
    .padding(.horizontal, 30)
    .padding(.vertical, 15)
    .liquidGlass(shape: .capsule)
```

![Apply the glass effect to three different shapes: Rounded Rectangle, Circle and Capsule](LiquidGlassShape)

#### Opacity

```swift
Text("Colored Glass")
    .padding(20)
    .liquidGlass(shape: .capsule, opacity: 0.5)
```

#### Hover Effect

Enable hover effects for macOS and iPadOS.
When hovered, a subtle quaternary fill provides visual feedback.

```swift
Text("Hover Over Me")
    .padding()
    .liquidGlass(shape: .capsule, hoverEffect: true)

Button("Tap Me") {
// Action
}
.padding()
.liquidGlass(shape: .capsule, hoverEffect: true)
.buttonStyle(.plain)
```

#### Native Liquid Glass Support

For advanced animations and matched geometry effects, you can provide an `id` and a `namespace` to the `liquidGlass` modifier. This enables smooth transitions between views using SwiftUI's matched geometry effect used in `GlassEffectContainer`.

```swift
Text("Rounded Rectangle")
    .padding(20)
    .liquidGlass(shape: .roundedRect(cornerRadius: 16), id: "id_rect", namespace: namespace)
```
