//
//  ButtonsControlsView.swift
//  LiquidGlassDemo
//
//  Demonstrates interactive buttons and controls
//

import SwiftUI

struct ButtonsControlsView: View {
    @State private var isToggled = false
    @State private var sliderValue: Double = 0.5
    @State private var selectedSegment = 0
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                // Basic Buttons
                VStack(spacing: 20) {
                    Text("Buttons")
                        .font(.headline)
                    
                    Button("Primary Action") {
                        print("Primary tapped")
                    }
                    .foregroundStyle(.primary)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .liquidGlass(shape: .capsule, hoverEffect: true)
                    .buttonStyle(.plain)
                    
                    Button("Secondary Action") {
                        print("Secondary tapped")
                    }
                    .foregroundStyle(.secondary)
                    .padding(.horizontal, 30)
                    .padding(.vertical, 15)
                    .liquidGlass(shape: .roundedRect(cornerRadius: 12), hoverEffect: true)
                    .buttonStyle(.plain)
                    
                    HStack(spacing: 15) {
                        Button {
                            print("Icon button 1")
                        } label: {
                            Image(systemName: "star.fill")
                                .font(.title2)
                        }
                        .padding(15)
                        .liquidGlass(shape: .circle, hoverEffect: true)
                        .buttonStyle(.plain)
                        
                        Button {
                            print("Icon button 2")
                        } label: {
                            Image(systemName: "heart.fill")
                                .font(.title2)
                        }
                        .padding(15)
                        .liquidGlass(shape: .circle, hoverEffect: true)
                        .buttonStyle(.plain)
                        
                        Button {
                            print("Icon button 3")
                        } label: {
                            Image(systemName: "bookmark.fill")
                                .font(.title2)
                        }
                        .padding(15)
                        .liquidGlass(shape: .circle, hoverEffect: true)
                        .buttonStyle(.plain)
                    }
                }
                
                Divider()
                
                // Toggle
                VStack(spacing: 15) {
                    Text("Toggle Control")
                        .font(.headline)
                    
                    HStack {
                        Text("Enable Feature")
                        Spacer()
                        Toggle("", isOn: $isToggled)
                            .labelsHidden()
                    }
                    .padding()
                    .liquidGlass(shape: .roundedRect(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                Divider()
                
                // Slider
                VStack(spacing: 15) {
                    Text("Slider Control")
                        .font(.headline)
                    
                    VStack(spacing: 10) {
                        HStack {
                            Text("Volume")
                            Spacer()
                            Text("\(Int(sliderValue * 100))%")
                                .foregroundStyle(.secondary)
                        }
                        Slider(value: $sliderValue)
                    }
                    .padding()
                    .liquidGlass(shape: .roundedRect(cornerRadius: 12))
                    .padding(.horizontal)
                }
                
                Divider()
                
                // Segmented Control
                VStack(spacing: 15) {
                    Text("Segmented Control")
                        .font(.headline)
                    
                    Picker("Options", selection: $selectedSegment) {
                        Text("First").tag(0)
                        Text("Second").tag(1)
                        Text("Third").tag(2)
                    }
                    .pickerStyle(.segmented)
                    .padding()
                    .liquidGlass(shape: .capsule)
                    .padding(.horizontal)
                }
            }
            .padding(.vertical, 30)
        }
        .navigationTitle("Buttons & Controls")
        .background(backgroundGradient)
    }
    
    private var backgroundGradient: some View {
        LinearGradient(
            colors: [.green.opacity(0.2), .blue.opacity(0.2)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
}

#Preview {
    ButtonsControlsView()
}
