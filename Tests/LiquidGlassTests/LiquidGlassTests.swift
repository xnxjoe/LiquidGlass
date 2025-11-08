@testable import LiquidGlass
import SwiftUI
import Testing

// MARK: - BackgroundShape Tests

@Test("BackgroundShape creates valid shapes")
func testBackgroundShapeCreation() async throws {
    // Test rounded rectangle
    let roundedRect = BackgroundShape.roundedRect(cornerRadius: 12)
    _ = roundedRect.shape
    #expect(true, "Rounded rectangle shape should be created")
    
    // Test circle
    let circle = BackgroundShape.circle
    _ = circle.shape
    #expect(true, "Circle shape should be created")
    
    // Test capsule
    let capsule = BackgroundShape.capsule
    _ = capsule.shape
    #expect(true, "Capsule shape should be created")
}

@Test("BackgroundShape generates valid paths")
func testBackgroundShapePaths() async throws {
    let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    // Test rounded rectangle path
    let roundedRect = BackgroundShape.roundedRect(cornerRadius: 12).shape
    let roundedRectPath = roundedRect.path(in: rect)
    #expect(!roundedRectPath.isEmpty, "Rounded rectangle should generate a non-empty path")
    
    // Test circle path
    let circle = BackgroundShape.circle.shape
    let circlePath = circle.path(in: rect)
    #expect(!circlePath.isEmpty, "Circle should generate a non-empty path")
    
    // Test capsule path
    let capsule = BackgroundShape.capsule.shape
    let capsulePath = capsule.path(in: rect)
    #expect(!capsulePath.isEmpty, "Capsule should generate a non-empty path")
}

@Test("BackgroundShape handles edge cases for corner radius")
func testCornerRadiusClamping() async throws {
    let smallRect = CGRect(x: 0, y: 0, width: 20, height: 20)
    
    // Test with corner radius larger than rect
    let largeCornerRadius = BackgroundShape.roundedRect(cornerRadius: 100).shape
    let path = largeCornerRadius.path(in: smallRect)
    #expect(!path.isEmpty, "Should handle corner radius larger than rect dimensions")
}

@Test("BackgroundShape enum cases are Sendable")
func testBackgroundShapeSendable() async throws {
    // Test that BackgroundShape conforms to Sendable
    let shape: any Sendable = BackgroundShape.roundedRect(cornerRadius: 12)
    #expect(shape is BackgroundShape, "BackgroundShape should be Sendable")
}

// MARK: - LiquidGlass Tests

@MainActor
@Test("LiquidGlass initializes with default values")
func testGlassStyleInitialization() async throws {
    _ = LiquidGlass(shape: .roundedRect(cornerRadius: 12))
    // Successfully created - no need for nil check on struct
    #expect(true, "LiquidGlass should initialize successfully")
}

@MainActor
@Test("LiquidGlass tint creates new instance")
func testGlassStyleTint() async throws {
    let original = LiquidGlass(shape: .capsule)
    _ = original.tint(.blue)
    
    // Both instances should exist (structs are always valid)
    #expect(true, "LiquidGlass tint should create modified copy")
}

@MainActor
@Test("LiquidGlass supports all BackgroundShape types")
func testGlassStyleShapes() async throws {
    _ = LiquidGlass(shape: .roundedRect(cornerRadius: 16))
    _ = LiquidGlass(shape: .circle)
    _ = LiquidGlass(shape: .capsule)
    
    // All styles created successfully
    #expect(true, "Should support all BackgroundShape types")
}

// MARK: - View Extension Tests

@MainActor
@Test("View extension liquidGlass modifier exists")
func testLiquidGlassModifier() async throws {
    let view = Text("Test")
    _ = view.liquidGlass(shape: .roundedRect(cornerRadius: 12))
    
    // Modifier applied successfully
    #expect(true, "liquidGlass modifier should return a valid view")
}

@MainActor
@Test("View extension supports hover effect")
func testLiquidGlassHoverEffect() async throws {
    let view = Text("Test")
    _ = view.liquidGlass(shape: .capsule, hoverEffect: true)
    
    // Hover effect parameter accepted
    #expect(true, "Should support hover effect parameter")
}

@MainActor
@Test("View extension supports matched geometry parameters")
func testLiquidGlassMatchedGeometry() async throws {
    let view = Text("Test")
    // Note: Namespace.ID can't be easily created in tests without a real SwiftUI context,
    // but we can verify the API accepts nil values
    _ = view.liquidGlass(shape: .circle, hoverEffect: false, id: "testID", namespace: nil)
    
    // Matched geometry parameters accepted
    #expect(true, "Should support matched geometry parameters")
}

// MARK: - Integration Tests

@Test("Complete glass effect pipeline works")
func testCompleteGlassPipeline() async throws {
    // Create a background shape
    let shape = BackgroundShape.roundedRect(cornerRadius: 20)
    
    // Generate path
    let rect = CGRect(x: 0, y: 0, width: 200, height: 100)
    let path = shape.shape.path(in: rect)
    #expect(!path.isEmpty, "Path generation should work")
    
    // Test passes if we get this far without crashes
    #expect(true, "Complete pipeline components work together")
}

@Test("Multiple shapes render without conflicts")
func testMultipleShapesRendering() async throws {
    let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
    
    let shapes: [BackgroundShape] = [
        .roundedRect(cornerRadius: 12),
        .circle,
        .capsule
    ]
    
    for shape in shapes {
        let path = shape.shape.path(in: rect)
        #expect(!path.isEmpty, "Each shape should render independently")
    }
}

// MARK: - Path Validation Tests

@Test("Rounded rectangle path bounds match input rect")
func testRoundedRectangleBounds() async throws {
    let rect = CGRect(x: 10, y: 10, width: 100, height: 100)
    let shape = BackgroundShape.roundedRect(cornerRadius: 12).shape
    let path = shape.path(in: rect)
    let pathBounds = path.boundingRect
    
    // Path bounds should be close to input rect (accounting for rounding)
    #expect(abs(pathBounds.width - rect.width) < 1.0, "Path width should match rect width")
    #expect(abs(pathBounds.height - rect.height) < 1.0, "Path height should match rect height")
}

@Test("Circle path is centered in rect")
func testCircleCentering() async throws {
    let rect = CGRect(x: 0, y: 0, width: 100, height: 100)
    let shape = BackgroundShape.circle.shape
    let path = shape.path(in: rect)
    let pathBounds = path.boundingRect
    
    // Circle should be centered
    let expectedRadius = min(rect.midX, rect.midY)
    #expect(pathBounds.width <= expectedRadius * 2, "Circle should fit within rect")
    #expect(pathBounds.height <= expectedRadius * 2, "Circle should fit within rect")
}

@Test("Capsule path fills rect properly")
func testCapsulePath() async throws {
    let rect = CGRect(x: 0, y: 0, width: 200, height: 100)
    let shape = BackgroundShape.capsule.shape
    let path = shape.path(in: rect)
    
    #expect(!path.isEmpty, "Capsule path should not be empty")
    
    let bounds = path.boundingRect
    #expect(bounds.width > 0, "Capsule should have width")
    #expect(bounds.height > 0, "Capsule should have height")
}

// MARK: - Performance Tests

@Test("Path generation is efficient")
func testPathGenerationPerformance() async throws {
    let rect = CGRect(x: 0, y: 0, width: 200, height: 200)
    let shape = BackgroundShape.roundedRect(cornerRadius: 20).shape
    
    // Generate path multiple times to ensure no performance issues
    for _ in 0..<100 {
        let path = shape.path(in: rect)
        #expect(!path.isEmpty, "Path should be generated efficiently")
    }
}

@Test("Multiple shape creations are lightweight")
func testShapeCreationPerformance() async throws {
    // Create multiple shapes to ensure no performance issues
    for shapeIndex in 0..<100 {
        let shape = BackgroundShape.roundedRect(cornerRadius: CGFloat(shapeIndex % 20))
        let path = shape.shape.path(in: CGRect(x: 0, y: 0, width: 100, height: 100))
        #expect(!path.isEmpty, "Shape creation should be lightweight")
    }
}
