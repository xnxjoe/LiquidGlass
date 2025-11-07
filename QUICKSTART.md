# Quick Start Guide

Get up and running with LiquidGlass in minutes!

## Installation

### Swift Package Manager (Recommended)

1. In Xcode, select **File** > **Add Package Dependencies...**
2. Enter the repository URL:
   ```
   https://github.com/xnxjoe/LiquidGlass.git
   ```
3. Click **Add Package**

## Your First Glass Effect

### Step 1: Import LiquidGlass

```swift
import SwiftUI
import LiquidGlass
```

### Step 2: Apply the Effect

```swift
struct ContentView: View {
    var body: some View {
        Text("Hello, Glass!")
            .font(.title)
            .padding(30)
            .liquidGlass(shape: .roundedRect(cornerRadius: 20))
    }
}
```

### Step 3: Run and Enjoy! 🎉

That's it! You now have a beautiful glass effect.

## Common Use Cases

### Glass Cards

```swift
VStack(alignment: .leading, spacing: 12) {
    Text("Card Title")
        .font(.headline)
    Text("Card content goes here")
        .font(.body)
        .foregroundStyle(.secondary)
}
.padding()
.liquidGlass(shape: .roundedRect(cornerRadius: 16))
```

### Circular Glass Avatars

```swift
Image(systemName: "person.fill")
    .font(.largeTitle)
    .padding(20)
    .liquidGlass(shape: .circle)
```

### Glass Buttons

```swift
Button("Tap Me") {
    print("Button tapped!")
}
.padding(.horizontal, 24)
.padding(.vertical, 12)
.liquidGlass(shape: .capsule, hoverEffect: true)
.buttonStyle(.plain)
```

### Custom Colors

```swift
Text("Colored Glass")
    .padding()
    .liquidGlass(shape: .roundedRect(cornerRadius: 12))
    .tint(.blue)
```

## Tips & Tricks

### 1. Add a Gradient Background

Glass effects look best against gradients:

```swift
ZStack {
    LinearGradient(
        colors: [.blue, .purple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    .ignoresSafeArea()
    
    YourGlassView()
}
```

### 2. Layer Multiple Glass Elements

```swift
VStack(spacing: 20) {
    Text("First Card")
        .padding()
        .liquidGlass(shape: .roundedRect(cornerRadius: 12))
    
    Text("Second Card")
        .padding()
        .liquidGlass(shape: .roundedRect(cornerRadius: 12))
}
```

### 3. Combine with Other Modifiers

```swift
Text("Interactive Glass")
    .padding()
    .liquidGlass(shape: .capsule)
    .shadow(radius: 10)
    .scaleEffect(isPressed ? 0.95 : 1.0)
    .animation(.spring(), value: isPressed)
```

## Next Steps

- Explore the [full documentation](README.md)
- Check out example projects
- Join the community discussions

## Need Help?

- [GitHub Issues](https://github.com/xnxjoe/LiquidGlass/issues)
- [Contributing Guide](CONTRIBUTING.md)

Happy coding! 🚀
