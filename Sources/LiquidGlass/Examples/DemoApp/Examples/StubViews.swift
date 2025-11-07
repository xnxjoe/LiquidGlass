//
//  StubViews.swift
//  LiquidGlassDemo
//
//  Placeholder views for additional examples
//

import SwiftUI

// MARK: - Custom Sizes View
struct CustomSizesView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ForEach([100, 150, 200, 250], id: \.self) { size in
                    Text("\(size)pt")
                        .font(.headline)
                        .padding()
                        .frame(width: CGFloat(size), height: CGFloat(size))
                        .liquidGlass(shape: .roundedRect(cornerRadius: 16))
                }
            }
            .padding()
        }
        .navigationTitle("Custom Sizes")
        .background(gradientBackground)
    }
}

// MARK: - Hover Effects View
struct HoverEffectsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("Hover Over Elements")
                    .font(.title2)
                    .padding()
                
                Text("With Hover Effect")
                    .padding(30)
                    .liquidGlass(shape: .roundedRect(cornerRadius: 16), hoverEffect: true)
                
                Text("Without Hover")
                    .padding(30)
                    .liquidGlass(shape: .roundedRect(cornerRadius: 16))
                
                HStack(spacing: 20) {
                    ForEach(["star", "heart", "bookmark"], id: \.self) { icon in
                        Image(systemName: "\(icon).fill")
                            .font(.largeTitle)
                            .padding(20)
                            .liquidGlass(shape: .circle, hoverEffect: true)
                    }
                }
            }
            .padding()
        }
        .navigationTitle("Hover Effects")
        .background(gradientBackground)
    }
}

// MARK: - Profile UI View
struct ProfileUIView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Profile Header
                VStack(spacing: 15) {
                    Image(systemName: "person.circle.fill")
                        .font(.system(size: 80))
                        .foregroundStyle(.blue)
                    
                    Text("John Doe")
                        .font(.title)
                        .fontWeight(.bold)
                    
                    Text("iOS Developer")
                        .foregroundStyle(.secondary)
                }
                .padding(30)
                .liquidGlass(shape: .roundedRect(cornerRadius: 20))
                
                // Stats
                HStack(spacing: 15) {
                    StatCard(title: "Projects", value: "24")
                    StatCard(title: "Followers", value: "1.2K")
                    StatCard(title: "Following", value: "342")
                }
                
                // Bio
                VStack(alignment: .leading, spacing: 10) {
                    Text("About")
                        .font(.headline)
                    Text("Passionate about creating beautiful user interfaces with SwiftUI.")
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .liquidGlass(shape: .roundedRect(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle("Profile")
        .background(gradientBackground)
    }
}

struct StatCard: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(spacing: 8) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .liquidGlass(shape: .roundedRect(cornerRadius: 12))
    }
}

// MARK: - Dashboard View
struct DashboardView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                DashboardCard(icon: "chart.bar.fill", title: "Analytics", value: "2.4K", color: .blue)
                DashboardCard(icon: "dollarsign.circle.fill", title: "Revenue", value: "$12K", color: .green)
                DashboardCard(icon: "person.2.fill", title: "Users", value: "834", color: .purple)
                DashboardCard(icon: "bell.fill", title: "Alerts", value: "5", color: .orange)
            }
            .padding()
        }
        .navigationTitle("Dashboard")
        .background(gradientBackground)
    }
}

struct DashboardCard: View {
    let icon: String
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundStyle(color)
            
            Text(value)
                .font(.title)
                .fontWeight(.bold)
            
            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .liquidGlass(shape: .roundedRect(cornerRadius: 16))
    }
}

// MARK: - Layered Effects View
struct LayeredEffectsView: View {
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ZStack {
                    Text("Back")
                        .padding(40)
                        .liquidGlass(shape: .roundedRect(cornerRadius: 20))
                        .offset(x: -20, y: 20)
                    
                    Text("Front")
                        .padding(40)
                        .liquidGlass(shape: .roundedRect(cornerRadius: 20))
                }
                
                ZStack {
                    Circle()
                        .fill(Color.blue.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .liquidGlass(shape: .circle)
                        .offset(x: -30)
                    
                    Circle()
                        .fill(Color.purple.opacity(0.3))
                        .frame(width: 150, height: 150)
                        .liquidGlass(shape: .circle)
                        .offset(x: 30)
                }
            }
            .padding()
        }
        .navigationTitle("Layered Effects")
        .background(gradientBackground)
    }
}

// MARK: - Animations View
struct AnimationsView: View {
    @State private var isAnimating = false
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Tap to Animate")
                .font(.title3)
                .padding(30)
                .liquidGlass(shape: .roundedRect(cornerRadius: 16))
                .scaleEffect(isAnimating ? 1.1 : 1.0)
                .animation(.spring(response: 0.3), value: isAnimating)
                .onTapGesture {
                    isAnimating.toggle()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        isAnimating = false
                    }
                }
            
            Text("Rotating")
                .padding(30)
                .liquidGlass(shape: .roundedRect(cornerRadius: 16))
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: isAnimating)
                .onAppear {
                    isAnimating = true
                }
        }
        .navigationTitle("Animations")
        .background(gradientBackground)
    }
}

// MARK: - Helper
private var gradientBackground: some View {
    LinearGradient(
        colors: [.blue.opacity(0.2), .purple.opacity(0.2)],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    .ignoresSafeArea()
}
