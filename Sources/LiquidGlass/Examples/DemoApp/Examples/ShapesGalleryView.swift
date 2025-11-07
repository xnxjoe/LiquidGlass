//
//  ShapesGalleryView.swift
//  LiquidGlassDemo
//
//  Demonstrates all available shapes
//

import SwiftUI

struct ShapesGalleryView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Rounded Rectangle
                VStack(spacing: 12) {
                    Text("Rounded Rectangle")
                        .font(.headline)
                    
                    Text("Hello, Glass!")
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.primary)
                        .padding(30)
                        .liquidGlass(shape: .roundedRect(cornerRadius: 20))
                }
                
                // Circle
                VStack(spacing: 12) {
                    Text("Circle")
                        .font(.headline)
                    
                    Text("🌟")
                        .font(.system(size: 50))
                        .padding(40)
                        .liquidGlass(shape: .circle)
                }
                
                // Capsule
                VStack(spacing: 12) {
                    Text("Capsule")
                        .font(.headline)
                    
                    Text("Liquid Glass")
                        .font(.headline)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 16)
                        .liquidGlass(shape: .capsule)
                }
                
                // Different corner radius
                VStack(spacing: 12) {
                    Text("Small Corner Radius")
                        .font(.headline)
                    
                    Text("Subtle Corners")
                        .padding(20)
                        .liquidGlass(shape: .roundedRect(cornerRadius: 8))
                }
                
                VStack(spacing: 12) {
                    Text("Large Corner Radius")
                        .font(.headline)
                    
                    Text("Very Rounded")
                        .padding(20)
                        .liquidGlass(shape: .roundedRect(cornerRadius: 30))
                }
            }
            .padding(30)
        }
        .navigationTitle("Shapes Gallery")
        .background(backgroundGradient)
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [.blue.opacity(0.3), .purple.opacity(0.3)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ShapesGalleryView()
}
