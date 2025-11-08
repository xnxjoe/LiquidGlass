# ``LiquidGlass``

A beautiful, lightweight SwiftUI library for creating stunning frosted glass effects with customizable shapes and colors.

## Overview

LiquidGlass provides an elegant way to add frosted glass effects to your SwiftUI views with minimal effort. The library automatically adapts to Platform 26+ system APIs while maintaining backward compatibility.

### Features

- **Beautiful Glass Effects** - Realistic frosted glass with subtle gradients and shadows
- **Multiple Shapes** - Built-in support for rounded rectangles, circles, and capsules
- **Customizable Tints** - Apply any color tint to your glass surfaces
- **Hover Effects** - Optional hover interactions for macOS and iPadOS
- **Platform 26+ Integration** - Automatically uses system `glassEffect` API when available
- **Lightweight** - Minimal dependencies, pure SwiftUI implementation
- **Performance Optimized** - Efficient path generation and rendering
- **Dark Mode Support** - Automatically adapts to light and dark color schemes

## Topics

### Essentials

- ``GlassStyle``
- ``BackgroundShape``
- ``GlassEffectModifier``

### Getting Started

The simplest way to add glass effects is using the `.liquidGlass()` modifier:

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

### Customization

Apply custom tints to match your design:

```swift
Text("Colored Glass")
    .padding(20)
    .liquidGlass(shape: .capsule)
    .tint(.blue)
```

### Direct Usage

Use ``GlassStyle`` directly as a background for more control:

```swift
VStack {
    Text("Custom Glass")
        .padding()
}
.background(
    GlassStyle(shape: .roundedRect(cornerRadius: 20))
        .tint(.purple)
)
```

## Common Use Cases

### Glass Cards

Create elegant card interfaces with frosted backgrounds:

```swift
VStack(alignment: .leading, spacing: 12) {
    HStack {
        Image(systemName: "sparkles")
            .font(.title2)
            .foregroundStyle(.blue)
        
        VStack(alignment: .leading, spacing: 4) {
            Text("Glass Card")
                .font(.headline)
            Text("Beautiful frosted effect")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        
        Spacer()
    }
}
.padding()
.liquidGlass(shape: .roundedRect(cornerRadius: 16))
```

### Interactive Elements

Add hover effects for better interactivity on macOS and iPadOS:

```swift
Button("Tap Me") {
    // Action
}
.padding()
.liquidGlass(shape: .capsule, hoverEffect: true)
.buttonStyle(.plain)
```

### Shape Variations

Use different shapes for different UI elements:

```swift
HStack(spacing: 20) {
    GlassStyle(shape: .roundedRect(cornerRadius: 12))
        .tint(.blue)
        .frame(width: 100, height: 100)
    
    GlassStyle(shape: .circle)
        .tint(.pink)
        .frame(width: 100, height: 100)
    
    GlassStyle(shape: .capsule)
        .tint(.green)
        .frame(width: 100, height: 60)
}
```

### Color Theming

Apply custom tints to match your brand colors:

```swift
VStack(spacing: 20) {
    Text("Blue Glass")
        .liquidGlass(shape: .roundedRect(cornerRadius: 12))
        .tint(.blue)
    
    Text("Purple Glass")
        .liquidGlass(shape: .roundedRect(cornerRadius: 12))
        .tint(.purple)
    
    Text("Green Glass")
        .liquidGlass(shape: .roundedRect(cornerRadius: 12))
        .tint(.green)
}
```

## Appearance Adaptation

### Automatic Dark Mode

LiquidGlass automatically adapts to light and dark color schemes without any additional configuration:

```swift
Text("Adaptive Glass")
    .padding()
    .liquidGlass(shape: .roundedRect(cornerRadius: 16))
```

The glass effect will look perfect in both light and dark modes, adjusting shadows, highlights, and materials automatically.

### Interactive Feedback

Enable hover effects for desktop and tablet interfaces:

```swift
Text("Hover Over Me")
    .padding()
    .liquidGlass(shape: .capsule, hoverEffect: true)
```

When the user hovers over the element, it will show a subtle quaternary fill for visual feedback.
