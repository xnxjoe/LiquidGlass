//
//  CardsListView.swift
//  LiquidGlassDemo
//
//  Demonstrates cards and lists with glass effects
//

import SwiftUI

struct CardsListView: View {
    let items = [
        CardItem(icon: "star.fill", title: "Favorites", description: "Your starred items", color: .yellow),
        CardItem(icon: "heart.fill", title: "Liked", description: "Items you've liked", color: .pink),
        CardItem(icon: "bookmark.fill", title: "Saved", description: "Your bookmarks", color: .blue),
        CardItem(icon: "clock.fill", title: "Recent", description: "Recently viewed", color: .purple),
        CardItem(icon: "folder.fill", title: "Collections", description: "Your collections", color: .orange),
        CardItem(icon: "doc.fill", title: "Documents", description: "All documents", color: .cyan)
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Card Style 1: Horizontal
                Text("Horizontal Cards")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                ForEach(items) { item in
                    HStack(spacing: 15) {
                        Image(systemName: item.icon)
                            .font(.title2)
                            .foregroundStyle(item.color)
                            .frame(width: 50, height: 50)
                            .background(item.color.opacity(0.1))
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(item.title)
                                .font(.headline)
                            Text(item.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .font(.caption)
                            .foregroundStyle(.tertiary)
                    }
                    .padding()
                    .liquidGlass(shape: .roundedRect(cornerRadius: 16), hoverEffect: true)
                }
                
                Divider()
                    .padding(.vertical)
                
                // Card Style 2: Vertical Grid
                Text("Grid Cards")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 15) {
                    ForEach(items) { item in
                        VStack(spacing: 12) {
                            Image(systemName: item.icon)
                                .font(.largeTitle)
                                .foregroundStyle(item.color)
                            
                            Text(item.title)
                                .font(.headline)
                            
                            Text(item.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                                .multilineTextAlignment(.center)
                        }
                        .padding()
                        .frame(height: 150)
                        .liquidGlass(shape: .roundedRect(cornerRadius: 20), hoverEffect: true)
                    }
                }
                
                Divider()
                    .padding(.vertical)
                
                // Featured Card
                Text("Featured Card")
                    .font(.headline)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                VStack(alignment: .leading, spacing: 15) {
                    HStack {
                        Image(systemName: "sparkles")
                            .font(.title)
                            .foregroundStyle(.yellow)
                        
                        Spacer()
                        
                        Text("New")
                            .font(.caption)
                            .fontWeight(.semibold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.yellow.opacity(0.2))
                            .clipShape(Capsule())
                    }
                    
                    Text("Premium Feature")
                        .font(.title2)
                        .fontWeight(.bold)
                    
                    Text("Unlock advanced features and get the most out of your experience with our premium plan.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                    
                    Button("Learn More") {
                        print("Learn more tapped")
                    }
                    .font(.headline)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background(Color.blue)
                    .clipShape(Capsule())
                }
                .padding(20)
                .liquidGlass(shape: .roundedRect(cornerRadius: 20))
            }
            .padding()
        }
        .navigationTitle("Cards & Lists")
        .background(backgroundGradient)
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [.pink.opacity(0.2), .purple.opacity(0.2), .blue.opacity(0.2)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

struct CardItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: String
    let description: String
    let color: Color
}