# LiquidGlass

[![Swift](https://img.shields.io/badge/Swift-5.9+-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/platform-iOS%2015%2B%20%7C%20macOS%2012%2B-lightgrey.svg)](https://developer.apple.com)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)
[![Swift Package Manager](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)

A beautiful, lightweight SwiftUI library for creating stunning frosted glass effects with customizable shapes and colors.

English | [简体中文](README_CN.md)

<p align="center">
  <img src=".github/assets/Liquid _Glass_Demo.png" alt="Liquid Glass Preview" width="600">
</p>

## ✨ Features

- 🎨 **Beautiful Glass Effects** - Realistic frosted glass with subtle gradients and shadows
- 🔷 **Multiple Shapes** - Built-in support for rounded rectangles, circles, and capsules
- 🎭 **Customizable Tints** - Apply any color tint to your glass surfaces
- 🖱️ **Hover Effects** - Optional hover interactions for macOS and iPadOS
- 🔄 **iOS 26+ Integration** - Automatically uses system `glassEffect` API when available
- 📦 **Lightweight** - Minimal dependencies, pure SwiftUI implementation
- ⚡ **Performance Optimized** - Efficient path generation and rendering
- 🌓 **Dark Mode Support** - Automatically adapts to light and dark color schemes

## 📋 Requirements

- iOS 15.0+ / macOS 12.0+
- Xcode 15.0+
- Swift 5.9+

## 📦 Installation

### Swift Package Manager

Add LiquidGlass to your project using Xcode:

1. File > Add Package Dependencies...
2. Enter the repository URL:
   ```
   https://github.com/xnxjoe/LiquidGlass.git
   ```
3. Select the version or branch you want to use
4. Click "Add Package"

Or add it to your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/xnxjoe/LiquidGlass.git", from: "1.0.0")
]
```

Then add `LiquidGlass` to your target dependencies:

```swift
targets: [
    .target(
        name: "YourTarget",
        dependencies: ["LiquidGlass"]
    )
]
```

## 🚀 Quick Start

### Basic Usage

Import LiquidGlass and apply the glass effect to any SwiftUI view:

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

### With Custom Tint

Add a colored tint to your glass effect:

```swift
Text("Colored Glass")
    .padding(20)
    .liquidGlass(shape: .capsule)
    .tint(.blue)
```

### Using GlassStyle Directly

For more control, use `GlassStyle` as a background:

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

## 📖 Documentation

### View Extension

The easiest way to apply glass effects is using the `.liquidGlass()` modifier:

```swift
func liquidGlass(
    shape: BackgroundShape,
    hoverEffect: Bool = false,
    id: String? = nil,
    namespace: Namespace.ID? = nil
) -> some View
```

**Parameters:**
- `shape` - The background shape (`.roundedRect()`, `.circle`, or `.capsule`)
- `hoverEffect` - Enable hover interaction (default: `false`)
- `id` - Optional identifier for matched geometry effects (iOS 26+)
- `namespace` - Optional namespace for matched geometry effects (iOS 26+)

### BackgroundShape

Choose from three built-in shapes:

```swift
// Rounded rectangle with custom corner radius
.liquidGlass(shape: .roundedRect(cornerRadius: 16))

// Perfect circle
.liquidGlass(shape: .circle)

// Capsule (pill shape)
.liquidGlass(shape: .capsule)
```

### GlassStyle

Create standalone glass backgrounds:

```swift
GlassStyle(shape: .roundedRect(cornerRadius: 12))
    .tint(.blue)
    .frame(width: 200, height: 100)
```

## 💡 Examples

### Card with Glass Background

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

### Interactive Button

```swift
Button("Tap Me") {
    // Action
}
.padding()
.liquidGlass(shape: .capsule, hoverEffect: true)
.buttonStyle(.plain)
```

### Multiple Shapes Gallery

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

### Custom Tint Colors

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

## 🎨 Customization

### Color Schemes

LiquidGlass automatically adapts to light and dark modes:

<p align="center">
  <img src=".github/assets/color-scheme-light.png" alt="Light Mode" width="400">
  <img src=".github/assets/color-scheme-dark.png" alt="Dark Mode" width="400">
</p>

```swift
// Looks great in both light and dark mode
Text("Adaptive Glass")
    .padding()
    .liquidGlass(shape: .roundedRect(cornerRadius: 16))
```

### Hover Effects

Enable interactive hover effects on macOS and iPadOS:

```swift
Text("Hover Over Me")
    .padding()
    .liquidGlass(shape: .capsule, hoverEffect: true)
```

## 🏗️ Architecture

LiquidGlass is built with a modular architecture:

- **BackgroundShape** - Enum defining available shapes with optimized path generation
- **GlassStyle** - Core view that renders the glass effect with materials and gradients
- **GlassEffectModifier** - ViewModifier that applies glass backgrounds with iOS 26+ support
- **View+LiquidGlass** - Convenient extension for easy integration
- **MultiColorRoundedRectangle/Capsule** - Helper views for multi-gradient strokes

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request. For major changes, please open an issue first to discuss what you would like to change.

## 📄 License

LiquidGlass is available under the MIT license. See the [LICENSE](LICENSE) file for more info.

## 🙏 Acknowledgments

- Built with Xcode and Github Copilot using SwiftUI
- Inspired by new Liquid Glass Design by Apple Inc.

## 📬 Contact

- GitHub: [@xnxjoe](https://github.com/xnxjoe)
- Issues: [GitHub Issues](https://github.com/xnxjoe/LiquidGlass/issues)

## 🗺️ Roadmap
💖- [ ] Additional shape support (polygons, custom paths)
- [ ] Animation presets for glass transitions
- [ ] Accessibility improvements
- [ ] Documentation website
- [ ] Video tutorials and examples
- [ ] Community showcase gallery

---

Made with love by [xnxjoe](https://github.com/xnxjoe)

If you find this package useful, please consider giving it a star on GitHub!
