# LiquidGlass Demo App

A comprehensive demo application showcasing all features of the LiquidGlass library.

## 🎯 What's Included

The demo app contains multiple examples organized by category:

### Basic Examples
- **Shapes Gallery** - Demonstrates all three shapes (rounded rect, circle, capsule) with various corner radii
- **Color Tints** - Shows glass effects with different color tints
- **Custom Sizes** - Examples of glass elements in different sizes

### Interactive Examples
- **Hover Effects** - Demonstrates hover interactions (macOS/iPadOS)
- **Buttons & Controls** - Glass-styled buttons, toggles, sliders, and segmented controls

### Real-World Examples
- **Cards & Lists** - Horizontal cards, grid cards, and featured cards
- **Profile UI** - Complete profile screen with glass elements
- **Dashboard** - Analytics dashboard with glass cards

### Advanced Examples
- **Layered Effects** - Multiple overlapping glass elements
- **Animations** - Animated glass components

## 🚀 Running the Demo

### Option 1: Using Xcode

1. Open `Package.swift` in Xcode
2. Select the `LiquidGlassDemo` scheme
3. Choose your target (Mac or iOS Simulator)
4. Click Run (⌘R)

### Option 2: From Command Line

```bash
# Run on macOS
swift run LiquidGlassDemo

# Or build and run
swift build
open .build/debug/LiquidGlassDemo
```

## 📱 Screenshots

The demo app includes:
- Navigation-based interface for easy exploration
- Background gradients to showcase the glass effects
- Interactive elements to test hover and tap behaviors
- Real-world UI examples you can adapt for your projects

## 💡 Learning from Examples

Each example view in the demo is well-commented and demonstrates:
- How to use the `.liquidGlass()` modifier
- How to apply color tints
- How to enable hover effects
- How to use `GlassStyle` directly
- How to combine glass effects with other SwiftUI features

## 📝 Code Structure

```
Examples/LiquidGlassDemo/
├── LiquidGlassDemoApp.swift       # App entry point
├── ContentView.swift               # Main navigation
└── Examples/
    ├── ShapesGalleryView.swift    # Shape demonstrations
    ├── ColorTintsView.swift        # Color tint examples
    ├── ButtonsControlsView.swift   # Interactive controls
    ├── CardsListView.swift         # Card layouts
    └── StubViews.swift             # Additional examples
```

## 🔧 Customization

Feel free to:
- Modify examples to test different configurations
- Add your own examples
- Use the code as a starting point for your own projects
- Experiment with different shapes, colors, and sizes

## 📚 Documentation

For more information about the LiquidGlass API, see:
- [Main README](../../README.md)
- [Quick Start Guide](../../QUICKSTART.md)
- [API Documentation](../../README.md#documentation)

## 💬 Feedback

Found an interesting use case or want to contribute more examples? 
- Open an issue on [GitHub](https://github.com/xnxjoe/LiquidGlass/issues)
- Submit a pull request with your examples

---

Happy coding with LiquidGlass! 🎨✨
